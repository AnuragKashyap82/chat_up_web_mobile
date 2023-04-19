
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chat_up/widgets/profile_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../apis/apis.dart';
import '../helper/my_date_util.dart';
import '../models/chat_user.dart';
import '../models/message.dart';
import '../screens/chat_screen.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUser user;

  const ChatUserCard({Key? key, required this.user}) : super(key: key);

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  Message? _message;

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: mq.width * 0.02, vertical: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.blue.shade100,
      elevation: 0,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ChatScreen(
                          user: widget.user,
                        )));
          },
          child: StreamBuilder(
            stream: APIs.getLastMessage(widget.user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;

              final list =
                  data?.map((e) => Message.fromJson(e.data())).toList() ?? [];

              if (list.isNotEmpty) {
                _message = list[0];
              }

              return ListTile(
                // leading: const CircleAvatar(child: Icon(CupertinoIcons.person),),
                leading: InkWell(
                  onTap: (){
                    showDialog(context: context, builder: (_) => ProfileDialog(user: widget.user));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(mq.height * 0.3),
                    child: CachedNetworkImage(
                      height: mq.height * 0.055,
                      width: mq.height * 0.055,
                      imageUrl: widget.user.image,
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                ),

                title: Text(widget.user.name),

                subtitle: Text(
                  _message != null ?
                      _message!.type == Type.image? 'image' :
                  _message!.msg : widget.user.about,
                  maxLines: 1,
                ),

                // trailing: Text("12:00 PM", style: TextStyle(color: Colors.black54),),
                trailing: _message == null
                    ? null
                    : _message!.read.isEmpty &&
                            _message!.fromId != APIs.user.uid
                        ? Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                                color: Colors.greenAccent.shade400,
                                borderRadius: BorderRadius.circular(10)),
                          )
                        : Text(
                            MyDateUtil.getLastMessageTime(
                                context: context, time: _message!.sent),
                            style: TextStyle(color: Colors.black54),
                          ),
              );
            },
          )),
    );
  }
}
