class BlocEvent<T> {
  Status status;
  String message;
  T data;

  BlocEvent.loading(this.message) : status = Status.LOADING;
  BlocEvent.completed(this.data) : status = Status.COMPLETED;
  BlocEvent.error(this.message) : status = Status.ERROR;
}

enum Status {LOADING, COMPLETED, ERROR}