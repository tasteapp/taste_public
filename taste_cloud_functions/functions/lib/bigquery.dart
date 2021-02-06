import 'package:googleapis/bigquery/v2.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

final _bigquery = authenticatedHttpClient.then((c) => BigqueryApi(c));

@Deprecated('Use newer `tasteBQStreaming` which avoids materializing the whole'
    'result set.')
Future<List<T>> tasteBQ<T>(
    String query, T Function(List<String> values) converter) async {
  if (buildType.isTest) {
    return [];
  }
  final bq = await _bigquery;
  final request = QueryRequest()
    ..useLegacySql = false
    ..timeoutMs = 5.minutes.inMilliseconds
    ..query = query;
  final response = await bq.jobs.query(request, projectId);
  if (response.errors?.isNotEmpty ?? false) {
    throw Exception(response.errors);
  }
  if (!response.jobComplete) {
    throw Exception('Query timed out:\n$query');
  }
  final total = int.parse(response?.totalRows ?? '0');
  final rows = List.of(response.rows ?? <TableRow>[]);
  var token = response.pageToken;
  while (rows.length < total) {
    final next = await (await _bigquery).jobs.getQueryResults(
        projectId, response.jobReference.jobId,
        pageToken: token);
    rows.addAll(next.rows ?? []);
    token = next.pageToken;
  }
  return rows.listMap((x) => converter(x.f.listMap((x) => x.v as String)));
}

Future<List<T>> tasteBQStreaming<T>(
    String query, T Function(List<String> values) converter) async {
  if (buildType.isTest) {
    return [];
  }
  final bq = await _bigquery;
  final request = QueryRequest()
    ..useLegacySql = false
    ..timeoutMs = 5.minutes.inMilliseconds
    ..query = query;
  final response = await bq.jobs.query(request, projectId);
  if (response.errors?.isNotEmpty ?? false) {
    throw Exception(response.errors);
  }
  if (!response.jobComplete) {
    throw Exception('Query timed out:\n$query');
  }
  final total = int.parse(response?.totalRows ?? '0');
  final rows = List.of(response.rows ?? <TableRow>[]);
  var processed = 0;
  final process = (List<TableRow> rows) {
    processed += rows.length;
    return rows
        .map((row) => converter(row.f.listMap((cell) => cell.v as String)));
  };
  final result = <T>[...process(rows)];
  var token = response.pageToken;
  while (processed < total) {
    final next = await (await _bigquery).jobs.getQueryResults(
        projectId, response.jobReference.jobId,
        pageToken: token);
    result.addAll(process(next.rows));
    token = next.pageToken;
  }
  return result;
}
