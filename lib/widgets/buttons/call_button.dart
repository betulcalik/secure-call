import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/features/calls/bloc/calls_bloc.dart';
import 'package:secure_call/features/calls/bloc/calls_event.dart';
import '../../features/call/widgets/call_screen.dart';
import '../../features/calls/bloc/calls_state.dart';

class CallButton extends StatefulWidget {
  final Contact contact;
  const CallButton({super.key, required this.contact});

  @override
  State<CallButton> createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {

  void _callPressed(Contact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CallScreen(contact: contact))
    );
    BlocProvider.of<CallsBloc>(context).add(AddCall(contact.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallsBloc, CallsState>(
      builder: (context, state) {
        return IconButton(
          icon: const Icon(
            Icons.call,
            color: Colors.green,
          ),
          onPressed: () => _callPressed(widget.contact),
        );
      },
    );
  }
}
