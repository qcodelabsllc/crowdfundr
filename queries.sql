CREATE TABLE users
(
    id         uuid PRIMARY KEY,
    username   VARCHAR(50) UNIQUE  NOT NULL,
    email      VARCHAR(255) UNIQUE NOT NULL,
    password   VARCHAR(255)        NOT NULL,
    created_at TIMESTAMP           NOT NULL,
    updated_at TIMESTAMP           NOT NULL
);

CREATE TABLE projects
(
    id            uuid PRIMARY KEY,
    title         VARCHAR(255)   NOT NULL,
    description   TEXT           NOT NULL,
    goal_amount   DECIMAL(10, 2) NOT NULL,
    amount_raised DECIMAL(10, 2) DEFAULT 0.00,
    status        VARCHAR(50)    NOT NULL,
    start_date    TIMESTAMP      NOT NULL,
    end_date      TIMESTAMP      NOT NULL,
    user_id       uuid           NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    created_at    TIMESTAMP      NOT NULL,
    updated_at    TIMESTAMP      NOT NULL
);

CREATE TABLE donations
(
    id         uuid PRIMARY KEY,
    amount     DECIMAL(10, 2) NOT NULL,
    user_id    uuid           NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    project_id uuid           NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP      NOT NULL,
    updated_at TIMESTAMP      NOT NULL
);

CREATE TABLE project_members
(
    id         uuid PRIMARY KEY,
    user_id    uuid           NOT NULL REFERENCES users (id) ON DELETE CASCADE,
    project_id uuid           NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP      NOT NULL,
    updated_at TIMESTAMP      NOT NULL
);

CREATE TABLE disbursements
(
    id         uuid PRIMARY KEY,
    amount     DECIMAL(10, 2) NOT NULL,
    project_id uuid           NOT NULL REFERENCES projects (id) ON DELETE CASCADE,
    created_at TIMESTAMP      NOT NULL,
    updated_at TIMESTAMP      NOT NULL
);

-- alter projects table to include status & amount_disbursed
ALTER TABLE projects ADD COLUMN status VARCHAR(50) NOT NULL DEFAULT 'pending';
ALTER TABLE projects ADD COLUMN amount_disbursed DECIMAL(10, 2) DEFAULT 0.00;
ALTER TABLE projects ADD COLUMN backers INT DEFAULT 0;

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
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE projects SET amount_raised = amount_raised + NEW.amount
    WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_amount_raised function
CREATE TRIGGER update_project_amount_raised_trigger
    AFTER INSERT ON donations
    FOR EACH ROW
EXECUTE FUNCTION update_project_amount_raised();

-- create function to update project status
CREATE OR REPLACE FUNCTION update_project_status()
    RETURNS TRIGGER AS $$
DECLARE
    total_amount_raised NUMERIC;
    project_goal NUMERIC;
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
    AFTER INSERT ON donations
    FOR EACH ROW
EXECUTE FUNCTION update_project_status();

-- create function to update project backers
CREATE OR REPLACE FUNCTION update_project_backers()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE projects SET backers = backers + 1 WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_backers function
CREATE TRIGGER update_project_backers_trigger
    AFTER INSERT ON project_members
    FOR EACH ROW
EXECUTE FUNCTION update_project_backers();

-- create function to update project amount disbursed
CREATE OR REPLACE FUNCTION disburse_funds()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE projects SET amount_disbursed = amount_disbursed + NEW.amount WHERE id = NEW.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call disburse_funds function
CREATE TRIGGER disburse_funds_trigger
    AFTER INSERT ON disbursements
    FOR EACH ROW
EXECUTE FUNCTION disburse_funds();

-- create function to update project amount disbursed
CREATE OR REPLACE FUNCTION update_project_amount_disbursed()
    RETURNS TRIGGER AS $$
BEGIN
    UPDATE projects SET amount_disbursed = amount_disbursed - OLD.amount WHERE id = OLD.project_id;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- create trigger to call update_project_amount_disbursed function
CREATE TRIGGER update_project_amount_disbursed_trigger
    AFTER UPDATE ON disbursements
    FOR EACH ROW
EXECUTE FUNCTION update_project_amount_disbursed();


