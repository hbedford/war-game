class ServerGraphQL {
  ServerGraphQL._();
  static String openServer(int userId) => """
    mutation MyMutation {
      insert_server(objects: {host_user_id: $userId, server_user: {data: {user_id: $userId}}}) {
        returning {
          id
          user {
            id
            email
            name
          }
          isstarted
          server_users {
            user {
              id
              name
            email
            }
          }
          server_users_aggregate {
            aggregate {
              count
            }
          }
          isloading
        }
      }
    }
    """;
  static String loadingGame(int serverId) => """
  mutation MyMutation {
    update_server(where: {id: {_eq: $serverId}}, _set: {isloading:true}) {
      affected_rows
    }
  }
  """;
  static String loadedGame(int serverId) => """
  mutation MyMutation {
    update_server(where: {id: {_eq: $serverId}}, _set: {isloading:false,isstarted:true}) {
      affected_rows
    }
  }
  """;
  static String get listenServers => """ 
    subscription MySubscription {
      server {
        id
        first_user_id
        second_user_id
        third_user_id
        fourth_user_id
        selected_user_id
        isstarted
        server_users {
            user {
              id
              name
              email
            }
          }
        user {
          id
          name
          email
        }
        server_users_aggregate {
          aggregate {
            count
          }
        }
        isloading
      }
    }
    """;
  static String listenServer(int serverId) => """
  subscription MySubscription {
  server(where: {id: {_eq: $serverId}}) {
    id
    first_user_id
    second_user_id
    third_user_id
    fourth_user_id
    selected_user_id
    isstarted
    server_users {
      user {
        id
        name
        email
      }
    }
    user {
      id
      name
      email
    }
    server_users_aggregate {
      aggregate {
        count
      }
    }
    isloading
  }
}


  """;
  static String connectToServer(int serverId, int userId) => """
  mutation MyMutation {
    insert_server_users(objects: {server_id: $serverId, user_id: $userId}) {
      affected_rows
    }
  }
  """;
  static String game(int serverId) => """subscription  {
      continent (where: {territories: {server_id: {_eq: $serverId}}}){
        id
        name
        bonus
        territories {
          id
          name
          server_id
          amountsoldiers
          offset
          user_id
          neighbors
          continent_id
        }
      }
    }
  """;
  static String get addTerritories => """
    mutation MyMutation(\$objects:[territory_insert_input!]!) {
      insert_territory(objects:\$objects ) {
        affected_rows
      }
    }
    """;
}
