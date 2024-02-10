import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/features/call/bloc/call_bloc.dart';
import 'package:secure_call/features/call/bloc/call_event.dart';
import '../../features/call/bloc/call_state.dart';
import '../../features/call/widgets/call_screen.dart';

class CallButton extends StatefulWidget {
  final Contact contact;
  const CallButton({super.key, required this.contact});

  @override
  State<CallButton> createState() => _CallButtonState();
}

class _CallButtonState extends State<CallButton> {

  void _callPressed(Contact contact) {
    BlocProvider.of<CallBloc>(context).add(CallStartedEvent());

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CallScreen(contact: contact))
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CallBloc, CallState>(
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
