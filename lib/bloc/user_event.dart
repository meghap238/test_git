part of 'user_bloc.dart';

abstract class UserEvent  {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUsers extends UserEvent {}

class AddUser extends UserEvent {
  final UserModel user;

  const AddUser(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final UserModel user;

  const UpdateUser(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUser extends UserEvent {
  final int id;

  const DeleteUser(this.id);

  @override
  List<Object> get props => [id];
}