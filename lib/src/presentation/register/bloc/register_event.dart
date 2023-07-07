part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}


class CreateUserEvent extends RegisterEvent {}

class WatchPasswordEvent extends RegisterEvent {}
