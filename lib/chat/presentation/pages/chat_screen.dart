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
import 'package:darchat/injection.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shamsi_date/shamsi_date.dart';

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
  File? file;
  void filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      print(file!.path);
      //BlocProvider.of<ChatBloc>(context).add(UploadEvent(file: file));
    } else {
      // User canceled the picker
    }
  }

  Widget _buildMessageComposer(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color.fromARGB(255, 238, 238, 238),
      //height: 50,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {
              filePicker();
              setState(() {});
              if (file != null) {
                BlocProvider.of<ChatBloc>(context)
                    .add(UploadEvent(file: file!));
              }
            },
            icon: const Icon(
              Icons.attach_file_rounded,
              color: Colors.grey,
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey,
                  )),
              child: TextFormField(
                //textInputAction: TextInputAction.newline,
                textCapitalization: TextCapitalization.sentences,
                controller: controller,
                textDirection: TextDirection.ltr,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  hintText: 'Write a message...',
                  border: InputBorder.none,
                  hintTextDirection: TextDirection.ltr,
                  hintStyle: TextStyle(
                    color: Constants.kHintColor,
                  ),
                ),
              ),
            ),
          ),
          // controller.text.isNotEmpty
          //     ?
          IconButton(
            icon: const Icon(Icons.send),
            iconSize: 25.0,
            color: Constants.supportChatBackground,
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
          )
          // : IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.mic_none_outlined,
          //       color: Constants.supportChatBackground,
          //       size: 25.0,
          //     )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ChatBloc>(),
      child: Scaffold(
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
            'Support',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Constants.kTextColor,
              fontSize: 15,
            ),
          ),
          centerTitle: true,
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
                  visitor = VisitorModel.fromJson(jsonDecode(snapshot.data))
                      .toEntity();
                }
                if (jsonDecode(snapshot.data)['collection'] ==
                    'stream-room-messages') {
                  final message =
                      MessageModel.fromJson(jsonDecode(snapshot.data))
                          .toEntity();
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
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: Column(
                  children: [
                    //!haveMessages
                    // ? Expanded(
                    //     child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           "لطفا بخش مورد نظر را انتخاب نمایید",
                    //           textDirection: TextDirection.rtl,
                    //           style: TextStyle(
                    //             color: Constants.kTextColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //         const SizedBox(
                    //           height: 20,
                    //         ),
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
                    //],
                    //),
                    //)
                    Expanded(
                      child: StickyGroupedListView<Message, String>(
                        elements: messages,
                        groupBy: (Message element) => DateTime(
                          DateTime.fromMillisecondsSinceEpoch(element.date)
                              .year,
                          DateTime.fromMillisecondsSinceEpoch(element.date)
                              .month,
                          DateTime.fromMillisecondsSinceEpoch(element.date).day,
                        ).toString(),
                        groupSeparatorBuilder: (Message element) {
                          var date = Jalali.fromDateTime(
                              DateTime.fromMillisecondsSinceEpoch(
                                  element.date.toInt()));
                          final f = date.formatter;
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 2.5, horizontal: 5),
                            child: Text(
                              '${f.d} ${f.mN}',
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.kFocusedBorderColor,
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                        indexedItemBuilder: (context, Message element, index) {
                          var date = DateTime.fromMillisecondsSinceEpoch(
                              element.date.toInt());
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: element.userId == visitor!.id
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 7),
                                    decoration: BoxDecoration(
                                      color: element.userId == visitor!.id
                                          ? Constants.customerChatBackground
                                          : Constants.supportChatBackground,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(8),
                                      ),
                                    ),
                                    child: element.images?.isEmpty ?? true
                                        ? Text(
                                            element.body,
                                            //textDirection: TextDirection.rtl,
                                            style: TextStyle(
                                              color:
                                                  element.userId == visitor!.id
                                                      ? Constants.kTextColor
                                                      : Colors.white,
                                            ),
                                          )
                                        : Image.network(SokcetData.url +
                                            element.images!.first.link)),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    '${date.hour}:${date.minute}',
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: Constants.kFocusedBorderColor),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        initialScrollIndex: messages.length,
                        order: StickyGroupedListOrder.ASC,
                        reverse: false,
                        floatingHeader: true,
                        stickyHeaderBackgroundColor:
                            Colors.transparent, // optional
                      ),
                    ),
                    _buildMessageComposer(context),
                  ],
                ),
              );
            }),
      ),
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
