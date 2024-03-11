import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_call/features/calls/bloc/calls_bloc.dart';
import 'package:secure_call/features/calls/bloc/calls_event.dart';
import 'package:secure_call/features/calls/bloc/calls_state.dart';
import 'package:secure_call/features/contacts/constants/contact_card_icon_type.dart';
import '../../contacts/widgets/contact_card.dart';

class CallsScreen extends StatefulWidget {
  const CallsScreen({super.key});

  @override
  State<CallsScreen> createState() => _CallsScreenState();
}

class _CallsScreenState extends State<CallsScreen> {
  @override
  void initState() {
    super.initState();
    loadRecentCalls();
  }

  loadRecentCalls() {
    context.read<CallsBloc>().add(LoadRecentCalls());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsBloc, CallsState>(
      builder: (context, state) {
        if (state is LoadingRecentCalls) {
          return const CircularProgressIndicator();
        } else if (state is LoadedRecentCalls) {
          if (state.contacts.isEmpty) {
            return const Center(child: Text("No recent calls found"));
          }

          return Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ListView.separated(
              itemCount: state.contacts.length,
              itemBuilder: (context, index) => ContactCard(
                  contact: state.contacts[index],
                  iconType: ContactCardIconType.noIcon),
              separatorBuilder: (context, index) => const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5,
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}