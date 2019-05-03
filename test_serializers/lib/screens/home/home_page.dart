import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:test_serializers/screens/authentication/authentication.dart';
import 'package:test_serializers/screens/user/user.dart';
import 'package:test_serializers/service/repository/auth_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserBloc userBloc;
  AuthRepository authRepository=new AuthRepository();
  @override
  void initState() {
    // TODO: implement initState
    userBloc=BlocProvider.of<UserBloc>(context);
    authRepository.getCurrentUser().then((auth){
        userBloc.dispatch(GetDetailUser(userId:auth.id.toString()));
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
    BlocProvider.of<AuthenticationBloc>(context);
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Center(
            child: Column(
              children: <Widget>[
                BlocBuilder<UserEvent,UserState>(
                  bloc: userBloc,
                  builder: (BuildContext context,UserState state){

                    if(state is GetUserSuccess){

                      return Text( state.user.email);
                    }
                    if(state is GetUserError){
                      return Text("get user error");
                    }

                    return Container();
                  },
                ),


                RaisedButton(
                  child: Text('logout'),
                  onPressed: () {
                    authenticationBloc.dispatch(LoggedOut());
                  },
                ),
              ],
            )),
      ),
    );
  }
}


