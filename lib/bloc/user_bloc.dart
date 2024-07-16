import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/user.dart';
import '../repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(UserInitial()) {

    on<UserEvent>((event, emit) {
    });

    on<LoadUsers>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<AddUser>((event, emit) async {
      emit(UserLoading());
      try {
        await userRepository.createUser(event.user);
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      try {
        await userRepository.updateUser(event.user);
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }

    });

    on<DeleteUser>((event, emit) async {
      emit(UserLoading());

      try {
        await userRepository.deleteUser(event.id);
        final users = await userRepository.fetchUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}
