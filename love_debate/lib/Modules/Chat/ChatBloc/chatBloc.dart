import 'dart:async';
import 'dart:convert';

import 'package:app_push_notifications/Modules/Chat/Model/chatMessages.dart';
import 'package:app_push_notifications/Utils/Constants/SharedPref.dart';
import 'package:app_push_notifications/Utils/Constants/WebService.dart';
import 'package:app_push_notifications/Utils/Controllers/ApiBaseHelper.dart';
import 'package:app_push_notifications/Utils/Controllers/AppExceptions.dart';
import 'package:app_push_notifications/Utils/Globals/UserSession.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;
import 'blocProvider.dart';

class ChatBloc implements Bloc{

  static String _socketUrl = 'https://api.lovedebate.co:3001/';
  IO.Socket _socket;
  final SharedPref _sharedPref = SharedPref();

  bool _isLoading = false;
  final _isLoadingStream = StreamController<bool>.broadcast();
  Stream<bool> get isLoading => _isLoadingStream.stream;

  List<ChatConversation> _listOfMessages = List<ChatConversation>();
  final _listOfMessagesStream = StreamController<List<ChatConversation>>.broadcast();
  Stream<List<ChatConversation>> get listOfMessages => _listOfMessagesStream.stream;

  ScrollController _scrollController;
  final _scrollControllerStream = StreamController<ScrollController>.broadcast();
  Stream<ScrollController> get scrollController => _scrollControllerStream.stream;


  ChatBloc(){
    createSocketConnection();
    _listOfMessagesStream.sink.add(_listOfMessages);
    _scrollController = new ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: false,
    );
    _scrollControllerStream.sink.add(_scrollController);
  }

  void _toEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    _scrollControllerStream.sink.add(_scrollController);
  }

  createSocketConnection(){
    _socket = IO.io(_socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    _socket.connect();

    _socket.on("connect", (_) async {
      print('Socket Connect');
      registerUser();
    });
    _socket.on("connect_error", (_){
      print('connect_error');
    });

    _socket.on("disconnect", (_){
      print('disconnect');
    });
    _socket.on("error", (_){
      print('error');
    });
  }

  registerUser()async{
    var userId = await _sharedPref.getSocketId();
    _socket.emit('adduser_1', userId);
    getChatMessages();
  }


  sendMessages({String toUserId, String message})async{
    //Add to listOf Chat
//    _listOfMessages.add(ChatMessage(type: MessageType.Sender, message: message));
//    _listOfMessagesStream.sink.add(_listOfMessages);
    _toEnd();
    var fromUserId = await _sharedPref.getSocketId();
    var fromUserName  = await _sharedPref.getBy(UserSession.name);
    _socket.emit("check_user_1", [fromUserId, toUserId]);
    _socket.once('msg_user_found_1', (data){
      if(data[0] != '-1'){
        //emit on socket
        _socket.emit("msg_user_1", [fromUserId, fromUserName, toUserId, message]);
      }
    });
  }

  getChatMessages(){
    _socket.on('msg_user_handle_1', (data){
      var fromUserId = data[0];
      var fromUserName = data[1];
      var message = data[2];
      //If route == 'chatDetails' && toUserId == data[0] => add to listOfMessages
      //Add to listOf Chat
//      _listOfMessages.add(ChatMessage(type: MessageType.Receiver, message: data[1]));
//      _listOfMessagesStream.sink.add(_listOfMessages);
//      _toEnd();

      //else => show local notifications and put message in shared Preferences

      //show count unread messages on chat Tab icon and also show on chat list

    });
  }



  getChatFromServer(String conv_id){
    Map<String, dynamic> body= {
      "conv_id" : conv_id,
      "offset" : "0",
      "limit" : "10000"
    };
    try {
      ApiBaseHelper().fetchService(method: HttpMethod.post,authorization: true, url: WebService.conversationList,body: body,isFormData: true).then(
              (response) async{

            var res = response as http.Response;
            if (res.statusCode == 200){
              Map<String, dynamic> responseJson = json.decode(res.body);
              if(responseJson.containsKey('success')){
//                print("response is =====> "+responseJson['success']);
                responseJson["success"].forEach((v) {
                  ChatConversation item = ChatConversation.fromJson(v);
                  _listOfMessages.add(ChatConversation.fromJson(v));

                });
                _listOfMessagesStream.add(_listOfMessages);
                _isLoading = false;
                _isLoadingStream.add(_isLoading);
              }else{
                _isLoading = false;
                _isLoadingStream.add(_isLoading);
                print("Oh no response");
              }
            }else if (res.statusCode == 401){
              _isLoading = false;
              _isLoadingStream.add(_isLoading);
              Map<String, dynamic> err = json.decode(res.body);
//              GFunction.showError(err['error'].toString(), context);
            }else{
              _isLoading = false;
              _isLoadingStream.add(_isLoading);
//              GFunction.showError(res.reasonPhrase.toString(), context);
            }
          });
    } on FetchDataException catch(e) {
      _isLoading = false;
      _isLoadingStream.add(_isLoading);
//      GFunction.showError(e.toString(), context);
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    _listOfMessagesStream.close();
    _scrollControllerStream.close();
    _isLoadingStream.close();
  }
}


