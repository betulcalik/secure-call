abstract class CallsEvent {}

class LoadRecentCalls extends CallsEvent {}

class AddCall extends CallsEvent {
  final String id;
  AddCall(this.id);
}