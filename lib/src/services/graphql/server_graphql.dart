class ServerGraphQL {
  String openServer(int userId) => """
    mutation MyMutation {
      insert_server(objects: {host_user_id: $userId}) {
        returning {
          id
          user {
            id
            email
            name
          }
          isstarted
        }
      }
    }
    """;
  String startGame(int serverId, int userId) => """
    mutation MyMutation {
      update_server(where: {id: {_eq: ${serverId}}, host_user_id: {_eq: ${userId}}}, _set: {stats: 2,isstarted:true}) {
        affected_rows
        returning {
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
          stats
          updated_at
          isstarted
        }
      }
    }
    """;
}
