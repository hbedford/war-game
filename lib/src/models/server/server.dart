import 'package:war/src/models/user/user.dart';

class Server {
  final int id;
  final User hostUser;
  final int? userSelectedId;
  final int? firstUserId;
  final int? secondUserId;
  final int? thirdUserId;
  final int? fourthUserId;
  final bool isStarted;
  final int amountUsers;
  List<User> users;
  bool isLoading;
  Server({
    required this.id,
    required this.hostUser,
    required this.userSelectedId,
    required this.firstUserId,
    required this.secondUserId,
    required this.thirdUserId,
    required this.fourthUserId,
    required this.isStarted,
    required this.amountUsers,
    required this.users,
    this.isLoading = false,
  });
  factory Server.fromJson(Map map) => Server(
        id: map['id'],
        hostUser: User.fromJson(map['user']),
        userSelectedId: map['selected_user_id'],
        firstUserId: map['first_user_id'],
        secondUserId: map['second_user_id'],
        thirdUserId: map['third_user_id'],
        fourthUserId: map['fourth_user_id'],
        isStarted: map['isstarted'],
        amountUsers: map['server_users_aggregate']['aggregate']['count'],
        users: map['server_users']
            .map<User>((map) => User.fromJson(map['user']))
            .toList(),
        isLoading: map['isloading'],
      );
}
