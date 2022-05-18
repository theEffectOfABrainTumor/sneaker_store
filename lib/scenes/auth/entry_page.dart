import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_page.dart';
import 'auth_bloc/auth_bloc.dart';
import 'auth_page.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if(state is AutoLoginState){
          return const HomePage();
        } else if(state is NeedToAuthState){
          return const AuthPage();
        } else if(state is  AuthLoadingState){
          return const Center(child: CircularProgressIndicator());
        }
        return Container();
      },
    );
  }
}