import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:anime_time/core/config/app_config.dart';
import 'package:anime_time/core/constants/app_constants.dart';

final graphqlClientProvider = Provider<GraphQLClient>((ref) {
  final url = AppConfig.apiUrl.isNotEmpty
      ? AppConfig.apiUrl
      : AppConstants.aniListApiUrl;

  final link = HttpLink(url);

  return GraphQLClient(link: link, cache: GraphQLCache());
});
