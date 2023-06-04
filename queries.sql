CREATE TABLE users
(
    id         uuid      DEFAULT gen_random_uuid() PRIMARY KEY,
    username   VARCHAR(50) UNIQUE      NOT NULL,
    email      VARCHAR(255) UNIQUE     NOT NULL,
    password   VARCHAR(255)            NOT NULL,
    created_at TIMESTAMP DEFAULT now() NOT NULL,
    updated_at TIMESTAMP DEFAULT now() NOT NULL
);

CREATE TABLE projects
(
    id               uuid PRIMARY KEY        DEFAULT gen_random_uuid(),
    title            VARCHAR(255)   NOT NULL,
    description      TEXT           NOT NULL,
    goal_amount      DECIMAL(10, 2) NOT NULL,
    amount_raised    DECIMAL(10, 2)          DEFAULT 0.00,
    category         VARCHAR(50)    NOT NULL DEFAULT 'other',
    image            VARCHAR(255)   NOT NULL DEFAULT 'https://cdn.dribbble.com/userupload/5004110/file/original-2d9c3b37b1babac285ac55ce0eb441fb.jpg?compress=1&resize=752x',
    status           VARCHAR(50)    NOT NULL DEFAULT 'pending',
    start_date       TIMESTAMP      NOT NULL,
    amount_disbursed DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    backers          INT                     DEFAULT 0,
    end_date         TIMESTAMP      NOT NULL,
    user_id          uuid           NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at       TIMESTAMP               DEFAULT now() NOT NULL,
    updated_at       TIMESTAMP               DEFAULT now() NOT NULL
);

CREATE TABLE donations
(
    id         uuid PRIMARY KEY        DEFAULT gen_random_uuid(),
    amount     DECIMAL(10, 2) NOT NULL,
    user_id    uuid           NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    project_id uuid           NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP      NOT NULL DEFAULT now(),
    updated_at TIMESTAMP      NOT NULL DEFAULT now()
);

CREATE TABLE project_members
(
    id         uuid PRIMARY KEY   DEFAULT gen_random_uuid(),
    user_id    uuid      NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    project_id uuid      NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NOT NULL DEFAULT now()
);

CREATE TABLE disbursements
(
    id         uuid PRIMARY KEY        DEFAULT gen_random_uuid(),
    amount     DECIMAL(10, 2) NOT NULL,
    project_id uuid           NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP      NOT NULL DEFAULT now(),
    updated_at TIMESTAMP      NOT NULL DEFAULT now()
);

-- alter projects table to have default created_at and updated_at
ALTER TABLE projects
    ALTER COLUMN created_at SET DEFAULT now(),
    ALTER COLUMN updated_at SET DEFAULT now();

-- alter the projects table to add a foreign key to the categories table
-- ALTER TABLE projects
--     ADD CONSTRAINT projects_category_fkey FOREIGN KEY (category) REFERENCES categories (id);

-- indexes on users table
CREATE INDEX users_username_idx ON users (username);
CREATE INDEX users_email_idx ON users (email);

-- indexes on projects table
CREATE INDEX projects_user_id_idx ON projects (user_id);

-- indexes on donations table
CREATE INDEX donations_user_id_idx ON donations (user_id);
CREATE INDEX donations_project_id_idx ON donations (project_id);

-- create index on project members table
CREATE INDEX project_members_user_id_idx ON project_members (user_id);
CREATE INDEX project_members_project_id_idx ON project_members (project_id);

-- create index on disbursements table
CREATE INDEX disbursements_project_id_idx ON disbursements (project_id);

-- create function to update project amount raised
CREATE OR REPLACE FUNCTION update_project_amount_raised()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE projects
    SET amount_raised = amount_raised + NEW.amount
    WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_amount_raised function
CREATE TRIGGER update_project_amount_raised_trigger
    AFTER INSERT
    ON donations
    FOR EACH ROW
EXECUTE FUNCTION update_project_amount_raised();

-- create function to update project status
CREATE OR REPLACE FUNCTION update_project_status()
    RETURNS TRIGGER AS
$$
DECLARE
    total_amount_raised NUMERIC;
    project_goal        NUMERIC;
BEGIN
    SELECT SUM(amount) INTO total_amount_raised FROM donations WHERE project_id = NEW.id;
    SELECT goal_amount INTO project_goal FROM projects WHERE id = NEW.id;

    IF (total_amount_raised >= project_goal) THEN
        UPDATE projects SET status = 'funded' WHERE id = NEW.id;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_status function
CREATE TRIGGER update_project_status_trigger
    AFTER INSERT
    ON donations
    FOR EACH ROW
EXECUTE FUNCTION update_project_status();

-- create function to update project backers
CREATE OR REPLACE FUNCTION update_project_backers()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE projects SET backers = backers + 1 WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_backers function
CREATE TRIGGER update_project_backers_trigger
    AFTER INSERT
    ON project_members
    FOR EACH ROW
EXECUTE FUNCTION update_project_backers();

-- create function to update project amount disbursed
CREATE OR REPLACE FUNCTION disburse_funds()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE projects SET amount_disbursed = amount_disbursed + NEW.amount WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call disburse_funds function
CREATE TRIGGER disburse_funds_trigger
    AFTER INSERT
    ON disbursements
    FOR EACH ROW
EXECUTE FUNCTION disburse_funds();

-- create function to update project amount disbursed
CREATE OR REPLACE FUNCTION update_project_amount_disbursed()
    RETURNS TRIGGER AS
$$
BEGIN
    UPDATE projects SET amount_disbursed = amount_disbursed - OLD.amount WHERE id = OLD.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_amount_disbursed function
CREATE TRIGGER update_project_amount_disbursed_trigger
    AFTER UPDATE
    ON disbursements
    FOR EACH ROW
EXECUTE FUNCTION update_project_amount_disbursed();

alter user crowdfundr with password 'crowdfundr';

--  grant all privileges on all tables in schema to crowdfundr
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA crowdfundr_schema TO crowdfundr;

-- create a procedure to get user by email
CREATE OR REPLACE PROCEDURE get_user_by_email(
    email_address VARCHAR,
    OUT _id uuid,
    OUT _email VARCHAR,
    OUT _username VARCHAR,
    OUT _created_at TIMESTAMP
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id, email, username, created_at
    INTO _id, _email, _username, _created_at
    FROM users
    WHERE email = email_address;
END;
$$;

-- create a procedure to delete a user by id
CREATE OR REPLACE PROCEDURE delete_user_by_id(
    user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    DELETE
    FROM users
    WHERE id = user_id;
END;
$$;

-- create a procedure to update a user by id
CREATE OR REPLACE PROCEDURE update_user_by_id(
    user_id uuid,
    user_name VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE users
    SET username = user_name
    WHERE id = user_id;
END;
$$;

-- create a procedure to get a project by id
CREATE OR REPLACE PROCEDURE get_project_by_id(
    project_id uuid,
    OUT _id uuid,
    OUT _title VARCHAR,
    OUT _description VARCHAR,
    OUT _goal_amount DECIMAL,
    OUT _amount_raised DECIMAL,
    OUT _amount_disbursed DECIMAL,
    OUT _backers INT,
    OUT _status VARCHAR,
    OUT _created_at TIMESTAMP,
    OUT _updated_at TIMESTAMP
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    INTO _id, _title, _description, _goal_amount, _amount_raised, _amount_disbursed, _backers, _status, _created_at, _updated_at
    FROM projects
    WHERE id = project_id;
END;
$$;

-- create a procedure to get all projects
CREATE OR REPLACE PROCEDURE get_all_projects()
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects;
END;
$$;

-- create a procedure to get all projects by status
CREATE OR REPLACE PROCEDURE get_projects_by_status(
    project_status VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects
    WHERE status = project_status;
END;
$$;

-- create a procedure to get all projects by user id
CREATE OR REPLACE PROCEDURE get_projects_by_user_id(
    project_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects
    WHERE user_id = project_user_id;
END;
$$;

-- create a procedure to get all projects by category
CREATE OR REPLACE PROCEDURE get_projects_by_category(
    project_category_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects
    WHERE category = project_category_id;
END;
$$;

-- create a procedure to get all projects donated to by user id
CREATE OR REPLACE PROCEDURE get_projects_donated_to_by_user_id(
    project_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT projects.id,
           projects.title,
           projects.description,
           projects.goal_amount,
           projects.amount_raised,
           projects.amount_disbursed,
           projects.backers,
           projects.status,
           projects.created_at,
           projects.updated_at
    FROM projects
             INNER JOIN donations ON projects.id = donations.project_id
    WHERE donations.user_id = project_user_id;
END;
$$;

-- create a procedure to get all projects backed by user id
CREATE OR REPLACE PROCEDURE get_projects_backed_by_user_id(
    project_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT projects.id,
           projects.title,
           projects.description,
           projects.goal_amount,
           projects.amount_raised,
           projects.amount_disbursed,
           projects.backers,
           projects.status,
           projects.created_at,
           projects.updated_at
    FROM projects
             INNER JOIN project_members ON projects.id = project_members.project_id
    WHERE project_members.user_id = project_user_id;
END;
$$;

-- create a procedure to get all projects created by user id
CREATE OR REPLACE PROCEDURE get_projects_created_by_user_id(
    project_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects
    WHERE user_id = project_user_id;
END;
$$;

-- create a procedure to get all projects due to expire in a number of days
CREATE OR REPLACE PROCEDURE get_projects_due_to_expire_in_days(
    project_days INT
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           title,
           description,
           goal_amount,
           amount_raised,
           amount_disbursed,
           backers,
           status,
           created_at,
           updated_at
    FROM projects
    WHERE status = 'active'
      AND created_at + (project_days || ' days')::interval < now();
END;
$$;

--  create a procedure to show all donations made for all projects by user id
CREATE OR REPLACE PROCEDURE get_donations_by_user_id(
    donation_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT donations.id,
           donations.amount,
           donations.created_at,
           donations.updated_at,
           projects.id,
           projects.title,
           projects.description,
           projects.goal_amount,
           projects.amount_raised,
           projects.amount_disbursed,
           projects.backers,
           projects.status,
           projects.created_at,
           projects.updated_at
    FROM donations
             INNER JOIN projects ON donations.project_id = projects.id
    WHERE donations.user_id = donation_user_id;
END;
$$;

-- create a procedure to create a category
-- CREATE OR REPLACE PROCEDURE create_category(
--     category_name VARCHAR
-- )
--     LANGUAGE plpgsql
-- AS
-- $$
-- BEGIN
--     INSERT INTO categories (name)
--     VALUES (category_name);
-- END;
-- $$;

-- create a procedure to create a new user by email, username and password
CREATE OR REPLACE PROCEDURE create_user(
    user_email VARCHAR,
    user_username VARCHAR,
    user_password VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO users (email, username, password)
    VALUES (user_email, user_username, user_password);
END;
$$;

-- create a procedure to get user by id
CREATE OR REPLACE PROCEDURE get_user_by_id(
    user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           email,
           username,
           created_at
    FROM users
    WHERE id = user_id;
END;
$$;

-- create a procedure to create a new project. The backers must be increase by 1 since the user who created the project is also a backer
CREATE OR REPLACE PROCEDURE create_project(
    project_title VARCHAR,
    project_description VARCHAR,
    project_goal_amount NUMERIC,
    project_category_id uuid,
    project_user_id uuid,
    project_start_date TIMESTAMP,
    project_end_date TIMESTAMP
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO projects (title, description, goal_amount, category, user_id, start_date, end_date)
    VALUES (project_title, project_description, project_goal_amount, project_category_id, project_user_id,
            project_start_date, project_end_date);
    UPDATE projects
    SET backers = backers + 1
    WHERE user_id = project_user_id;
END;
$$;

-- create a procedure to create a new donation
CREATE OR REPLACE PROCEDURE create_donation(
    donation_amount NUMERIC,
    donation_project_id uuid,
    donation_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO donations (amount, project_id, user_id)
    VALUES (donation_amount, donation_project_id, donation_user_id);
END;
$$;

-- create a procedure to create a new project member
CREATE OR REPLACE PROCEDURE create_project_member(
    project_member_project_id uuid,
    project_member_user_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    INSERT INTO project_members (project_id, user_id)
    VALUES (project_member_project_id, project_member_user_id);
END;
$$;

-- create a procedure to update a project
CREATE OR REPLACE PROCEDURE update_project(
    project_id uuid,
    project_title VARCHAR,
    project_description VARCHAR,
    project_goal_amount NUMERIC,
    project_category_id uuid,
    project_user_id uuid,
    project_start_date TIMESTAMP,
    project_end_date TIMESTAMP
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE projects
    SET title       = project_title,
        description = project_description,
        goal_amount = project_goal_amount,
        category    = project_category_id,
        user_id     = project_user_id,
        start_date  = project_start_date,
        end_date    = project_end_date
    WHERE id = project_id;
END;
$$;

-- create a procedure to update a user
CREATE OR REPLACE PROCEDURE update_user(
    user_id uuid,
    user_email VARCHAR,
    user_username VARCHAR,
    user_password VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    UPDATE users
    SET email    = user_email,
        username = user_username,
        password = user_password
    WHERE id = user_id;
END;
$$;

-- create a procedure to list all members of a project
CREATE OR REPLACE PROCEDURE get_project_members(
    current_project_id uuid
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT users.id,
           users.email,
           users.username,
           users.created_at
    FROM users
             INNER JOIN project_members ON users.id = project_members.user_id
    WHERE project_members.project_id = current_project_id;
END;
$$;

-- create a procedure to get user by email and password
CREATE OR REPLACE PROCEDURE get_user_by_email_and_password(
    user_email VARCHAR,
    user_password VARCHAR
)
    LANGUAGE plpgsql
AS
$$
BEGIN
    SELECT id,
           email,
           username,
           created_at
    FROM users
    WHERE email = user_email
      AND password = user_password;
END;
$$;