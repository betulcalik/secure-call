import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/calls/bloc/calls_event.dart';
import 'package:secure_call/features/calls/bloc/calls_state.dart';
import 'package:secure_call/features/calls/utils/calls_repository.dart';

class CallsBloc extends Bloc<CallsEvent, CallsState> {
  final CallsRepository callsRepository;

  CallsBloc(this.callsRepository) : super(LoadingRecentCalls()) {
    on<LoadRecentCalls>((event, emit) async {
      emit(LoadingRecentCalls());
      try {
        final contacts = await callsRepository.getRecentCalls();
        emit(LoadedRecentCalls(contacts));
      } catch (_) {
        emit(LoadedRecentCalls([]));
      }
    });

    on<AddCall>((event, emit) async {
      await callsRepository.addCall(event.id);
      final contacts = await callsRepository.getRecentCalls();
      emit(LoadedRecentCalls(contacts));
    });
  }
}