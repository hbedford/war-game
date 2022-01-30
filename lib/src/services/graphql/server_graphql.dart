class ServerGraphQL {
  String openServer(int userId) => """
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
        }
      }
    }
    """;
  String startGame(int serverId) => """
  mutation MyMutation {
    update_server(where: {id: {_eq: 10}}, _set: {isstarted: true}) {
      affected_rows
    }
  }
  """;
  String get listenServers => """ 
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
      }
    }""";

  String connectToServer(int serverId, int userId) => """
  mutation MyMutation {
    insert_server_users(objects: {server_id: $serverId, user_id: $userId}) {
      affected_rows
    }
  }
  """;
  String game(int serverId) => """subscription  {
      continent (where: {territories: {server_id: {_eq: $serverId}}}){
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
          continent_id
        }
      }
    }
  """;
}
