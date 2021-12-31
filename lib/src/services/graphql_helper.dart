import 'package:flutter/material.dart';
import 'package:graphql/client.dart';

class GraphQLHelper {
  final durationTimeOut = Duration(seconds: 15);

  GraphQLClient getGraphQLClient({String? token}) {
    final Link _link = HttpLink(
      'https://game-war.herokuapp.com/v1/graphql',
      /* defaultHeaders: token != null
          ? {
              'Authorization': 'Unhide tok = $token',
            }
          : {}, */
    );

    return GraphQLClient(
      cache: GraphQLCache(),
      link: _link,
    );
  }

  Future<QueryResult> mutation({
    required String data,
    String? token,
  }) async {
    final GraphQLClient _client = getGraphQLClient(
      token: token,
    );

    final MutationOptions options = MutationOptions(
      document: gql(data),
    );

    final QueryResult result = await _client
        .mutate(
      options,
    )
        .timeout(durationTimeOut, onTimeout: () async {
      return _timeoutAPI();
    });

    if (result.exception != null) {
      if (result.exception!.linkException != null) {
        if (result.exception!.linkException!.originalException
            .toString()
            .contains("SocketException: Failed host lookup")) {
          return _timeoutAPI();
        }
      }
    }

    return result;
  }

  Future<QueryResult> query({
    required String data,
    String? token,
  }) async {
    final GraphQLClient _client = getGraphQLClient(
      token: token,
    );

    final QueryOptions options = QueryOptions(
      document: gql(data),
    );

    final QueryResult result = await _client
        .query(
      options,
    )
        .timeout(durationTimeOut, onTimeout: () async {
      return _timeoutAPI();
    });

    if (result.exception != null) {
      if (result.exception!.linkException != null) {
        if (result.exception!.linkException!.originalException
            .toString()
            .contains("SocketException: Failed host lookup")) {
          return _timeoutAPI();
        }
      }
    }

    return result;
  }

  QueryResult _timeoutAPI() {
    return QueryResult(
      source: QueryResultSource.network,
      exception: OperationException(
        graphqlErrors: [
          GraphQLError(
            message: "timeout",
          )
        ],
      ),
    );
  }

  checkNetwork(QueryResult result, BuildContext context) {
    if (result.exception != null) {
      if (result.exception!.graphqlErrors.first.message == "timeout") {
        /* Toast.show("Você está sem conexão", context); */
        return;
      } else {
        /*  Toast.show("Tente novamente mais tarde", context); */
        return;
      }
    }
  }
}
