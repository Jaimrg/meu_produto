import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class DrawerHeaderC extends StatelessWidget {
  const DrawerHeaderC({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 35,
          backgroundImage: NetworkImage(
            FirebaseAuth.instance.currentUser!.photoURL==null?'https://www.gravatar.com/avatar/205e460b479e2e5b48aec07710c08d50.jpg':FirebaseAuth.instance.currentUser!.photoURL!,
          ),
        ),
        Padding(padding: EdgeInsets.only(
                    left: (10))),
        Text(          
          FirebaseAuth.instance.currentUser!.displayName==null?'Jaime':FirebaseAuth.instance.currentUser!.displayName!,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}