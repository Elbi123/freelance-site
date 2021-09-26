import 'package:online_freelance_system_flutter_frontend/data_provider/jobsDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Job.dart';
import 'package:online_freelance_system_flutter_frontend/models/jobs/Jobs.dart';

class JobsRepo {
  final JobsDataProvider jobsDataProvider;

  JobsRepo({required this.jobsDataProvider});
  Future<List<Job>> getJobs() async {
    return await jobsDataProvider.getAllJobs();
  }
}
