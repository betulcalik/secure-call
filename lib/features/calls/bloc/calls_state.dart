import 'package:flutter_contacts/contact.dart';

abstract class CallsState {}

class LoadingRecentCalls extends CallsState {}

class LoadedRecentCalls extends CallsState {
  final List<Contact> contacts;
  LoadedRecentCalls(this.contacts);
}
