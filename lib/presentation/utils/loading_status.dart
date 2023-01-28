abstract class ApiStatus<T extends Object> {
  final T? item;
  final String? message;

  ApiStatus({this.item, this.message});
}

class IdleStatus<T extends Object> extends ApiStatus<T> {
  IdleStatus();
}

class LoadingStatus<T extends Object> extends ApiStatus<T> {
  LoadingStatus();
}

class LoadedStatus<T extends Object> extends ApiStatus<T> {
  LoadedStatus(T? item) : super(item: item);
}

class FailedStatus<T extends Object> extends ApiStatus<T> {
  FailedStatus(String? message) : super(message: message);
}
