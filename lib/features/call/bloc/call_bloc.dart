import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/call/bloc/call_event.dart';
import 'package:secure_call/features/call/bloc/call_state.dart';
import 'package:secure_call/features/call/utils/call_repository.dart';

class CallBloc extends Bloc<CallEvent, CallState> {
  final CallRepository callRepository;

  CallBloc(this.callRepository): super(CallInitial()) {
    on<CallStarted>((event, emit) async {

    });

    on<CallEnded>((event, emit) async {

    });
  }
}