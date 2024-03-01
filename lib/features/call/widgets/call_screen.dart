import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:secure_call/features/call/bloc/call_state.dart';
import '../../../utils/custom_colors.dart';
import '../bloc/call_bloc.dart';
import '../bloc/call_event.dart';

class CallScreen extends StatefulWidget {
  final Contact contact;

  const CallScreen({super.key, required this.contact});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  @override
  void initState() {
    super.initState();
    startCall();
  }

  void startCall() {
    BlocProvider.of<CallBloc>(context).add(CallStarted());
  }

  void endCall() {
    BlocProvider.of<CallBloc>(context).add(CallEnded());
  }

  void pop() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Check if the contact has a photo
    bool hasPhoto =
        widget.contact.photo != null && widget.contact.photo!.isNotEmpty;

    return BlocListener<CallBloc, CallState>(listener: (context, state) {
      if (state is CallDisconnected) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          pop();
        });
      }
    }, child: BlocBuilder<CallBloc, CallState>(builder: (context, state) {
      return Scaffold(
        body: Stack(
          children: <Widget>[
            if (hasPhoto)
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(widget.contact.photo!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            if (!hasPhoto) Container(color: CustomColors.secondaryColor),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                  child: Text(
                    widget.contact.displayName,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                if (state is CallConnecting)
                  const Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Text(
                      "Connecting...",
                      style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 46),
                    child: ElevatedButton(
                      onPressed: () => endCall(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                        shape: const CircleBorder(), // Make it circular
                        padding: const EdgeInsets.all(
                            20), // Adjust padding as needed
                      ),
                      child: const Icon(
                        Icons.call_end,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }));
  }
}
