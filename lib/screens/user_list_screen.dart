import 'package:crud_operation/bloc/user_bloc.dart';
import 'package:crud_operation/config/app_string.dart';
import 'package:crud_operation/repository/user_repository.dart';
import 'package:crud_operation/screens/user_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  UserBloc userBloc = UserBloc(userRepository: UserRepository());
  @override
  void initState() {
    userBloc.add(LoadUsers()); // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    userBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppString.titleName),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        bloc: userBloc,
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserError) {
            userBloc.add(LoadUsers());
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                print(state);
                final user = state.users[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                      title: Text(user.name ?? 'Name'),
                      subtitle: Text(user.email ?? 'some@example.com'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          userBloc.add(DeleteUser(user.id ?? 0));
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UserDetailScreen(
                              user: user,
                              onUpdate: (user) {
                                userBloc.add(UpdateUser(user));
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
              itemCount: state.users.length,
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => UserDetailScreen(
                      onUpdate: (usr) {
                        userBloc.add((AddUser(usr)));
                      },
                    )),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
