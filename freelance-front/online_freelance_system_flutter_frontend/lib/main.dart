import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/auth_bloc/authBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc/jobs_bloc/jobBloc.dart';
import 'package:online_freelance_system_flutter_frontend/bloc_observer.dart';
import 'package:online_freelance_system_flutter_frontend/data_provider/authDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/data_provider/jobsDataProvider.dart';
import 'package:online_freelance_system_flutter_frontend/repository/authRepository.dart';
import 'package:online_freelance_system_flutter_frontend/repository/jobsRepo.dart';
import 'package:online_freelance_system_flutter_frontend/utils/routes.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AuthRepo authRepo = AuthRepo(authDataProvider: AuthDataProvider());

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.authRepo,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
              create: (context) => AuthBloc(authRepo: authRepo)),
          BlocProvider<JobsBloc>(
              create: (context) => JobsBloc(
                  jobsRepo: JobsRepo(
                      jobsDataProvider:
                          JobsDataProvider(httpClient: Client())))),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: AppRoute.generateRoute,
        ),
      ),
    );
  }
}
