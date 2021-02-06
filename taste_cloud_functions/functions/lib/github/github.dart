import 'package:github/github.dart';
import 'package:node_http/node_http.dart';
import 'package:taste_cloud_functions/taste_functions.dart';

final _accessToken = 'GITHUB_ACCESS_TOKEN';

final _testColl = 'fake_github'.coll;

Future<List<String>> testGithubMessages() async => (await _testColl.get())
    .documents
    .map((d) => d.data.getString('text'))
    .toList();

Future createIssue(String title, [String body]) async => buildType ==
        BuildType.test
    ? await _testColl.document().setData({'text': '$title $body'}.documentData)
    : await GitHub(
            auth: Authentication.withToken(_accessToken), client: NodeClient())
        .issues
        .create(
            RepositorySlug('tasteapp', 'taste'),
            IssueRequest(
                title: title,
                body: body ?? '',
                labels: ['bug-report', buildType.toString()]));
