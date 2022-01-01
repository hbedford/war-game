import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/server/server.dart';
import 'package:war/src/models/territory/territory.dart';
import 'package:war/src/models/user/user.dart';

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
    return await hasuraConnect.subscription(""" 
    subscription MySubscription {
      server {
        id
        user {
          id
          name
          email
        }
        first_user_id
        second_user_id
        third_user_id
        fourth_user_id
        selected_user_id
      }
    }""");
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
    return await hasuraConnect.mutation("""
    mutation MyMutation {
      insert_server(objects: {host_user_id: ${user.id}}) {
        returning {
          id
          user {
            id
            email
            name
          }
        }
      }
    }
    """);
  }

  Future<Map<String, dynamic>> start(User user, Server server) async {
    return await hasuraConnect.mutation("""
    mutation MyMutation {
      update_server(where: {id: {_eq: ${server.id}}, host_user_id: {_eq: ${user.id}}}, _set: {stats: 2}) {
        affected_rows
      }
    }
    """);
  }
}
