import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Jobs.dart';
import 'package:online_freelance_system_flutter_frontend/utils/constants.dart';

class JobsDataProvider {
  final http.Client httpClient;

  JobsDataProvider({required this.httpClient});
  Future<List<Job>> getAllJobs() async {
    final url = Uri.parse(apiUrl + '/jobs');
    try {
      final response = await httpClient.get(url);
      print(response.statusCode);
      print(response.request);
      if (response.statusCode == 200) {
        final map = jsonDecode(response.body);
        print("asd");

        List<Job> jobs = Jobs.fromJson(map).jobs;
        return jobs;
      } else {
        print("sorry am here ");
        throw Exception('Failed to load jobs');
      }
    } catch (_) {
      throw Exception();
    }
  }
}
