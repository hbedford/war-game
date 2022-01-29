import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/failure/failure.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/user/user.dart';
import 'package:war/src/services/resultlr.dart';

import 'graphql/server_graphql.dart';

class WARAPI {
  HasuraConnect hasuraConnect =
      HasuraConnect('https://game-war.herokuapp.com/v1/graphql');

  Future<Snapshot> game() async {
    return await hasuraConnect.subscription("""subscription  {
      continent {
        id
        name
        bonus
        territories {
          id
          name
          amountsoldiers
          offset
          user_id
          neighbors
        }
      }
    }
  """);
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

  Future<ResultLR<Failure, bool>> startGame(int serverId, int userId) async {
    ServerGraphQL graphql = ServerGraphQL();
    Map<String, dynamic> result =
        await hasuraConnect.mutation(graphql.startGame(serverId));
    if (result['data'] != null) {
      return Right((result['data']['update_server']['affected_rows'] > 0));
    }
    return Left(Failure(0, ''));
  }
}
