import 'dart:math';

import 'package:mobile/generated/protos/category.pb.dart';
import 'package:mobile/generated/protos/project.pb.dart';
import 'package:mobile/generated/protos/user.pb.dart';
import 'package:protobuf_google/protobuf_google.dart';
import 'package:uuid/uuid.dart';

final kSampleProjects = <Project>[
  Project(
    id: const Uuid().v4(),
    title: 'Urgent need of funds to complete the construction of a school',
    amountDisbursed: 0,
    amountRaised: 123441,
    backers: 6,
    categoryId:
        kSampleCategories[Random().nextInt(kSampleCategories.length)].id,
    createdAt: Timestamp.fromDateTime(DateTime.now()),
    updatedAt: Timestamp.fromDateTime(DateTime.now()),
    description: 'Lorem ipsum dolor sit amet, consectetur ad elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad '
        'minim veniam, quis nostrud exercitation ullamco laboris nisi ut '
        'aliquip ex ea commodo consequat. Duis aute irure dolor in '
        'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
        'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
        'culpa qui officia deserunt mollit anim id est laborum.',
    goalAmount: 400000,
    status: ProjectStatus.PENDING,
    imageUrl:
        'https://images.unsplash.com/photo-1552581234-26160f608093?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=2370&q=80',
    startDate: Timestamp.fromDateTime(DateTime.now()),
    projectOwner: kSampleUsers[Random().nextInt(kSampleUsers.length)],
  ),
  Project(
    id: const Uuid().v4(),
    title: 'Retirement package for Mr. George Bilson',
    amountDisbursed: 0,
    amountRaised: 3445,
    backers: 6,
    categoryId:
        kSampleCategories[Random().nextInt(kSampleCategories.length)].id,
    createdAt: Timestamp.fromDateTime(DateTime.now()),
    updatedAt: Timestamp.fromDateTime(DateTime.now()),
    description: 'Lorem ipsum dolor sit amet, consectetur ad elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad '
        'minim veniam, quis nostrud exercitation ullamco laboris nisi ut '
        'aliquip ex ea commodo consequat. Duis aute irure dolor in '
        'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla '
        'pariatur. Excepteur sint occaecat cupidatat non proident, sunt in '
        'culpa qui officia deserunt mollit anim id est laborum.',
    goalAmount: 60000,
    status: ProjectStatus.ACTIVE,
    imageUrl: 'https://picsum.photos/seed/picsum/200/300',
    startDate: Timestamp.fromDateTime(DateTime.now()),
    projectOwner: kSampleUsers[Random().nextInt(kSampleUsers.length)],
  ),
];

final kSampleCategories = <Category>[
  Category(id: const Uuid().v4(), name: 'Education'),
  Category(id: const Uuid().v4(), name: 'Fundraising'),
  Category(id: const Uuid().v4(), name: 'Startups'),
  Category(id: const Uuid().v4(), name: 'Healthcare'),
];

final kSampleUsers = <User>[
  User(
      id: const Uuid().v4(),
      username: 'Quabynah Bilson',
      email: 'qcodelabsllc@gmail.com',
      avatar:
          'https://avatars.githubusercontent.com/u/117631255?s=400&u=753eb33bf8f7454a6d53e4ae6270591ba1864d7c')
];
