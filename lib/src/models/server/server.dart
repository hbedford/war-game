class Server {
  final int id;
  final int hostUserId;
  final int userSelectedId;
  final int firstUserId;
  final int secondUserId;
  final int thirdUserId;
  final int fourthUserId;
  Server({
    required this.id,
    required this.hostUserId,
    required this.userSelectedId,
    required this.firstUserId,
    required this.secondUserId,
    required this.thirdUserId,
    required this.fourthUserId,
  });
  factory Server.fromJson(Map map)=>Server(id: map['id'], hostUserId: hostUserId, userSelectedId: userSelectedId, firstUserId: firstUserId, secondUserId: secondUserId, thirdUserId: thirdUserId, fourthUserId: fourthUserId)
}
