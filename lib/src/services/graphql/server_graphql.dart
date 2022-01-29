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
          user {
            server_users_aggregate {
              aggregate {
                count
              }
            }
            server_users {
              user {
                id
                name
                email
              }
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
        user {

          id
          name
          email
          server_users_aggregate {
            aggregate {
              count
            }
          }
          server_users {
            user {
              id
              name
              email
            }
          }
        }
      }
    }""";
}
