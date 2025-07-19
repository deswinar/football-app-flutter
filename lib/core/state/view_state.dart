import 'package:equatable/equatable.dart';

sealed class ViewState<T> extends Equatable {
  const ViewState();

  @override
  List<Object?> get props => [];
}

final class ViewStateInitial<T> extends ViewState<T> {
  const ViewStateInitial();

  @override
  String toString() => 'ViewStateInitial';
}

final class ViewStateLoading<T> extends ViewState<T> {
  const ViewStateLoading();

  @override
  String toString() => 'ViewStateLoading';
}

final class ViewStateSuccess<T> extends ViewState<T> {
  final T data;

  const ViewStateSuccess(this.data);

  @override
  List<Object?> get props => [data];

  @override
  String toString() => 'ViewStateSuccess($data)';
}

final class ViewStateError<T> extends ViewState<T> {
  final String message;

  const ViewStateError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ViewStateError($message)';
}
