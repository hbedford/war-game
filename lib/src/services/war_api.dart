import 'package:hasura_connect/hasura_connect.dart';
import 'package:war/src/models/territory/territory.dart';

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
    return await hasuraConnect.subscription(""" subscription MyQuery {
  server {
    id
    host_user_id
    first_user_id
    second_user_id
    third_user_id
    fourth_user_id
    selected_user_id
  }}""");
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
}
