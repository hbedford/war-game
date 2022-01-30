import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/resultlr.dart';

import 'graphql/server_graphql.dart';

class WARAPI {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://game-war.herokuapp.com/v1/graphql');

  Future<Snapshot> game(int serverId) async {
    return await hasuraConnect.subscription(ServerGraphQL.game(serverId));
  }

  Future addTerritories(List<Territory> territories) async {
    await hasuraConnect.mutation(ServerGraphQL.addTerritories, variables: {
      'objects': territories.map((territory) => territory.toMap).toList()
    });
  }

//   Future<dynamic> addContinents(List<Map<String, dynamic>> list) async {
//     print(list);
//     return await hasuraConnect.mutation("""
//      mutation MyMutation(\$objects:[territory_insert_input!]!) {
//   insert_territory(objects:\$objects ) {
//     affected_rows
//   }
// }
//     """, variables: {'objects': list}).catchError((e) => print(e));
//   }

  Future<Snapshot> listenServers() async {
    return await hasuraConnect.subscription(ServerGraphQL.listenServers);
  }

  Future<Snapshot> listenServer(int serverId) async {
    return await hasuraConnect
        .subscription(ServerGraphQL.listenServer(serverId));
  }

  Future<Map<String, dynamic>> getLogin(String email) async {
    return await hasuraConnect.query("""
    query MyQuery {
      user(where: {email: {_eq: "$email"}}) {
        email
        id
        name
      }
    }
    """);
  }

  Future<Map<String, dynamic>> registerLogin(String email, String name) async {
    return await hasuraConnect.mutation("""
    mutation MyMutation {
  insert_user(objects: {email: "$email", name: "$name"}) {
    returning {
      id
      name
      email
    }
    affected_rows
  }
}

    """);
  }

  Future<Map<String, dynamic>> openServer(User user) async {
    return await hasuraConnect.mutation(ServerGraphQL.openServer(user.id));
  }

  Future<ResultLR<Failure, bool>> loadingGame(int serverId) async {
    Map<String, dynamic> result =
        await hasuraConnect.mutation(ServerGraphQL.loadingGame(serverId));
    if (result['data'] != null) {
      return Right((result['data']['update_server']['affected_rows'] > 0));
    }
    return Left(Failure(0, ''));
  }

  Future<ResultLR<Failure, bool>> loadedGame(int serverId) async {
    Map<String, dynamic> result =
        await hasuraConnect.mutation(ServerGraphQL.loadedGame(serverId));
    if (result['data'] != null) {
      return Right((result['data']['update_server']['affected_rows'] > 0));
    }
    return Left(Failure(0, ''));
  }

  Future<ResultLR<Failure, bool>> connectToServer(
      int serverId, int userId) async {
    Map<String, dynamic> result = await hasuraConnect
        .mutation(ServerGraphQL.connectToServer(serverId, userId));
    if (result['data'] != null)
      return Right(result['data']['insert_server_users']['affected_rows'] > 0);
    return Left(Failure(0, ''));
  }
}
