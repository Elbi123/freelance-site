import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobEvent.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/proposalBloc/proposalBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc_observer.dart';
import 'package:online_freelance_system_flutter_frontend/data_provider/authDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/data_provider/jobsDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/data_provider/proposalDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/repository/authRepo.dart';
import 'package:online_freelance_system_flutter_frontend/repository/jobsRepo.dart';
import 'package:online_freelance_system_flutter_frontend/repository/proposalRepo.dart';
import 'package:online_freelance_system_flutter_frontend/screens/auth/loginPage.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routeNames.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routes.dart';

import 'bloc/auth_bloc/authBloc.dart';
import 'data_provider/userDataProvider.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  final AuthRepo authRepo =
      AuthRepo(authDataProvider: AuthDataProvider(Client()));
  runApp(MyApp(
    authRepo: authRepo,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo;

  MyApp({Key? key, required this.authRepo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.authRepo,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (BuildContext context) =>
                  AuthBloc(authRepo: this.authRepo)),
          BlocProvider<JobsBloc>(
              create: (BuildContext context) => JobsBloc(
                  jobsRepo: JobsRepo(
                      jobsDataProvider: JobsDataProvider(httpClient: Client())))
                ..add(JobsLoad())),
          BlocProvider<ProposalBloc>(
              create: (BuildContext context) => ProposalBloc(
                  proposalRepo: ProposalRepo(
                      proposalDataProvider: ProposalDataProvider(Client())))),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: '/',
            onGenerateRoute: AppRoute.generateRoute,
            routes: {
              loginpageroute: (context) => const LoginPage(),
            }),
      ),
    );
  }
}
