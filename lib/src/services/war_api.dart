import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/resultlr.dart';

import 'graphql/server_graphql.dart';

class WARAPI {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://game-war.herokuapp.com/v1/graphql');

  Future<Snapshot> game(int serverId) async {
    ServerGraphQL graphQL = ServerGraphQL();
    return await hasuraConnect.subscription(graphQL.game(serverId));
  }

  Future<dynamic> addContinents(List<Map<String, dynamic>> list) async {
    print(list);
    return await hasuraConnect.mutation("""
     mutation MyMutation(\$objects:[territory_insert_input!]!) {
  insert_territory(objects:\$objects ) {
    affected_rows
  }
}
    """, variables: {'objects': list}).catchError((e) => print(e));
  }

  Future<Snapshot> listenServer() async {
    ServerGraphQL graphQL = ServerGraphQL();
    return await hasuraConnect.subscription(graphQL.listenServers);
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
    ServerGraphQL graphql = ServerGraphQL();
    return await hasuraConnect.mutation(graphql.openServer(user.id));
  }

  Future<ResultLR<Failure, bool>> startGame(int serverId) async {
    ServerGraphQL graphql = ServerGraphQL();
    Map<String, dynamic> result =
        await hasuraConnect.mutation(graphql.startGame(serverId));
    if (result['data'] != null) {
      return Right((result['data']['update_server']['affected_rows'] > 0));
    }
    return Left(Failure(0, ''));
  }

  Future<ResultLR<Failure, bool>> connectToServer(
      int serverId, int userId) async {
    ServerGraphQL graphQL = ServerGraphQL();
    Map<String, dynamic> result =
        await hasuraConnect.mutation(graphQL.connectToServer(serverId, userId));
    if (result['data'] != null)
      return Right(result['data']['insert_server_users']['affected_rows'] > 0);
    return Left(Failure(0, ''));
  }
}
