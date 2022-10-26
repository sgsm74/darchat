import 'dart:convert';
import 'dart:io';

import 'package:darchat/chat/data/models/chat_data_model.dart';
import 'package:darchat/chat/data/models/message_model.dart';
import 'package:darchat/chat/data/models/pong.dart';
import 'package:darchat/chat/data/models/stream.dart';
import 'package:darchat/chat/data/models/visitor_model.dart';
import 'package:darchat/chat/domain/entities/chat_data.dart';
import 'package:darchat/chat/domain/entities/messsge.dart';
import 'package:darchat/chat/domain/entities/method.dart';
import 'package:darchat/chat/domain/entities/visitor.dart';
import 'package:darchat/chat/presentation/bloc/chat_bloc.dart';
import 'package:darchat/core/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'dart:math' as math;

import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:uuid/uuid.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.ws}) : super(key: key);
  final WebSocket ws;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = TextEditingController();
  List<Message> messages = [];
  ChatData? chatData;
  Visitor? visitor;
  _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      height: 55.0,
      color: const Color(0xffFADDD7),
      child: Row(
        textDirection: TextDirection.rtl,
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: controller,
              textDirection: TextDirection.rtl,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'نوشتن پیام...',
                hintTextDirection: TextDirection.rtl,
                hintStyle: TextStyle(
                  color: Constants.kHintColor,
                ),
              ),
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(math.pi),
            child: IconButton(
              icon: const Icon(Icons.send),
              iconSize: 25.0,
              color: Constants.kTextColor,
              onPressed: () {
                if (controller.text.isNotEmpty) {
                  final id = const Uuid().v4();
                  var map = {
                    "msg": "method",
                    "method": Method.sendMessageLivechat.value,
                    "id": id,
                    "params": [
                      {
                        "_id": id,
                        "rid": SokcetData.roomId,
                        "msg": controller.text,
                        "token": SokcetData.myToken
                      }
                    ]
                  };
                  messages.add(Message(
                    id: id,
                    roomId: SokcetData.roomId,
                    body: controller.text,
                    userId: visitor!.id,
                    name: visitor!.name,
                    date: DateTime.now().millisecondsSinceEpoch,
                  ));
                  widget.ws.add(jsonEncode(map));
                  controller.text = '';
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            shape: const CircleBorder(),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(50),
              ),
              child: Image.asset("assets/user-images/rick.png"),
            ),
          ),
        ),
        title: Text(
          'پشتیبان',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Constants.kTextColor,
            fontSize: 15,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Constants.kArrowBackIcon,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      widget.ws.close();
                      //Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      color: Constants.kTextColor,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: widget.ws,
          builder: (context, snapshot) {
            bool haveMessages = snapshot.hasData;
            if (haveMessages) {
              print(snapshot.data);
              if (jsonDecode(snapshot.data)['msg'] == 'ping') {
                //BlocProvider.of<ChatBloc>(context).add(event)
                widget.ws.add(jsonEncode(PongModel().toJson()));
              }
              if (jsonDecode(snapshot.data)['result'] != null &&
                  jsonDecode(snapshot.data)['result']['enabled'] != null) {
                chatData = ChatDataModel.fromJson(jsonDecode(snapshot.data))
                    .toEntity();
                var map = {
                  "msg": "method",
                  "method": Method.livechatRegisterGuest.value,
                  "id": const Uuid().v4(),
                  "params": [
                    {
                      "token": SokcetData.myToken,
                      "name": 'Saeed',
                      "email": 's.sgh4286@gmail.com',
                      "department": chatData!.departments.first.id
                    }
                  ]
                };
                widget.ws.add(jsonEncode(map));
              }
              if (jsonDecode(snapshot.data)['result'] != null &&
                  jsonDecode(snapshot.data)['result']['userId'] != null) {
                visitor =
                    VisitorModel.fromJson(jsonDecode(snapshot.data)).toEntity();
              }
              if (jsonDecode(snapshot.data)['collection'] ==
                  'stream-room-messages') {
                final message =
                    MessageModel.fromJson(jsonDecode(snapshot.data)).toEntity();
                if (message.userId != visitor!.id) {
                  messages.add(message);
                }
              }
              if (messages.isNotEmpty) {
                if (jsonDecode(snapshot.data)['id'] == messages.first.id) {
                  widget.ws.add(jsonEncode(StreamModel().toJson()));
                }
              }
            }
            return GestureDetector(
              child: Column(
                children: [
                  !haveMessages
                      ? Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "لطفا بخش مورد نظر را انتخاب نمایید",
                                textDirection: TextDirection.rtl,
                                style: TextStyle(
                                  color: Constants.kTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              // Row(
                              //   mainAxisAlignment:
                              //       MainAxisAlignment.spaceEvenly,
                              //   children: [
                              //     ...chatData!.departments.map(
                              //       (department) => DepartmentButton(
                              //         departmentTitle: department.name,
                              //         callback: () {
                              //           var map = {
                              //             "msg": "method",
                              //             "method": Method
                              //                 .livechatRegisterGuest.value,
                              //             "id": const Uuid().v4(),
                              //             "params": [
                              //               {
                              //                 "token": SokcetData.myToken,
                              //                 "name": 'Saeed',
                              //                 "email": 's.sgh4286@gmail.com',
                              //                 "department": department.id
                              //               }
                              //             ]
                              //           };
                              //           widget.ws.add(jsonEncode(map));
                              //         },
                              //       ),
                              //     ),
                              //   ],
                              // )
                            ],
                          ),
                        )
                      : Expanded(
                          child: StickyGroupedListView<Message, String>(
                            elements: messages,
                            groupBy: (Message element) => DateTime(
                              DateTime.fromMillisecondsSinceEpoch(element.date)
                                  .year,
                              DateTime.fromMillisecondsSinceEpoch(element.date)
                                  .month,
                              DateTime.fromMillisecondsSinceEpoch(element.date)
                                  .day,
                            ).toString(),
                            groupSeparatorBuilder: (Message element) {
                              var date = Jalali.fromDateTime(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      element.date.toInt()));
                              final f = date.formatter;
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.5, horizontal: 3),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: Constants.kBorderColor,
                                ),
                                width: MediaQuery.of(context).size.width / 2.5,
                                margin: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width /
                                            2.5),
                                child: Text(
                                  ' ${f.d} ${f.mN}',
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Constants.kFocusedBorderColor,
                                    fontSize: 12,
                                  ),
                                ),
                              );
                            },
                            indexedItemBuilder:
                                (context, Message element, index) => Container(
                              width: MediaQuery.of(context).size.width * 0.70,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 7),
                              margin: element.userId == visitor!.id
                                  ? const EdgeInsets.only(
                                      left: 80, top: 10, bottom: 10, right: 10)
                                  : const EdgeInsets.only(
                                      right: 80, top: 10, bottom: 10, left: 10),
                              decoration: BoxDecoration(
                                color: element.userId == visitor!.id
                                    ? Constants.kSenderMessageBackgroundColor
                                    : Constants.kReceiverMessageBackgroundColor,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Text(
                                element.body,
                                textDirection: TextDirection.rtl,
                              ),
                            ),
                            initialScrollIndex: messages.length,
                            order: StickyGroupedListOrder.ASC,
                            reverse: false,
                            floatingHeader: true,
                            stickyHeaderBackgroundColor:
                                Colors.transparent, // optional
                          ),
                        ),
                  _buildMessageComposer(),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    BlocProvider.of<ChatBloc>(context).add(DisconnectEvent(ws: widget.ws));
    super.dispose();
  }
}

class DepartmentButton extends StatelessWidget {
  const DepartmentButton({
    Key? key,
    required this.departmentTitle,
    required this.callback,
  }) : super(key: key);

  final String departmentTitle;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: callback,
      child: Container(
        decoration: BoxDecoration(
          color: Constants.kArrowBackIcon,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Text(departmentTitle),
      ),
    );
  }
}
