import 'package:equatable/equatable.dart';

class Visitor extends Equatable {
  const Visitor({
    required this.id,
    required this.token,
    required this.name,
    required this.userName,
    required this.email,
    required this.departmentId,
  });
  final String id;
  final String token;
  final String name;
  final String userName;
  final String email;
  final String departmentId;

  @override
  List<Object> get props => [id];
}
