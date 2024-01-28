import 'package:flutter/foundation.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:logging/logging.dart';

class SignalRService {
  final Logger logger = Logger("SignalR - hub");
  late HubConnection hubConnection;
  String url = "";

  SignalRService() {
    startConnection();
    _listenLoggerOnConsole();
  }

  void _listenLoggerOnConsole() {
    Logger.root.level = Level.ALL;

    // Writes the log messages to the console
    Logger.root.onRecord.listen((LogRecord rec) {
      if (kDebugMode) {
        print('${rec.level.name}: ${rec.time}: ${rec.message}');
      }
    });
  }

  Future<void> startConnection() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(url)
        .configureLogging(logger)
        .build();
    await hubConnection.start();
  }

  Future<void> stopConnection() async {
    await hubConnection.stop();
  }

  Future<void> updateConnection() async {
    if (hubConnection.state == HubConnectionState.Disconnected) {
      startConnection();
    } else {
      stopConnection();
    }
  }

  // TODO: UPDATE.
  Future<void> sendMessage() async {
    final result = _sendMessage("MethodOneSimpleParameterSimpleReturnValue", <Object>["ParameterValue"]);
    logger.log(Level.INFO, "Result: '$result");
  }

  Future<Object?> _sendMessage(String functionName, List<Object>? parameters) async {
    return await hubConnection.invoke(functionName, args: parameters);
  }

  Future<void> getMessage() async {
    hubConnection.on("aClientProvidedFunction", _getMessage);
  }

  void _getMessage(List<Object?>? parameters) {
    logger.log(Level.INFO, "Server invoked the method");
  }

  void _unregisterMethod(String methodName) {
    hubConnection.off(methodName);
  }
}
