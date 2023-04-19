
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/chat_user.dart';

class ProfileDialog extends StatelessWidget {
  final ChatUser user;
  const ProfileDialog({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white.withOpacity(0.9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: SizedBox(
        width: mq.width * 0.6,
        height: mq.height * 0.35,
        child: Stack(
          children: [

            Positioned(
              top: mq.height * 0.075,
              left: mq.width * 0.1,
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(mq.height * 0.25),
                child: CachedNetworkImage(
                  width: mq.width * 0.5,
                  fit: BoxFit.cover,
                  imageUrl: user.image,
                  errorWidget: (context, url, error) =>
                      CircleAvatar(child: Icon(CupertinoIcons.person),),
                ),
              ),
            ),

            Positioned(
              left: mq.width * 0.04,
                top: mq.height * 0.02,
                width: mq.width * 0.55,
                child: Text(user.name, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),)),

            Positioned(
                right: 8,
                top: 6,
                child: MaterialButton(onPressed: (){
                  // Navigator.pop(context);
                  // Navigator.push(context, MaterialPageRoute(builder: (_) => ViewProfileScreen(user: user)));
                },
                    minWidth: 0,
                    padding: EdgeInsets.all(0),
                    shape: CircleBorder(),
                    child: Icon(Icons.info_outline, color: Colors.blue, size: 30,))
            ),

          ],
        ),
      ),
    );
  }
}
