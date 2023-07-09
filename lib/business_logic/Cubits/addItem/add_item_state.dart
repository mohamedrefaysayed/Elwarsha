part of 'add_item_cubit.dart';

@immutable
abstract class AddItemState {}

class AddItemInitial extends AddItemState {}
class AddItemloading extends AddItemState {}
class AddItemSuccess extends AddItemState {}
class AddItemFailuer extends AddItemState {}


