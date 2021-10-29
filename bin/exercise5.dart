import 'dart:convert';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    final activeSymArray = decodedMessage['active_symbols'];
    tickHistory(activeSymArray[10]['symbol']);

    print(activeSymArray[10]['symbol']);

    channel.sink.close(status.goingAway);

});
channel.sink.add('{"active_symbols": "brief","product_type": "basic"}');

}

void tickHistory(children){
  final channel = IOWebSocketChannel.connect('wss://ws.binaryws.com/websockets/v3?app_id=1089');

channel.stream.listen((message) {
    final decodedMessage = jsonDecode(message);
    print(decodedMessage);
});
channel.sink.add('{"ticks_history": "$children","adjust_start_time": 1,"count": 10,"end": "latest","start": 1,"style": "ticks"}');
// {"ticks_history": "$children","adjust_start_time": 1,"count": 10,"end": "latest","start": 1,"style": "ticks"}
// {"ticks": "$children","subscribe": 1}

}
