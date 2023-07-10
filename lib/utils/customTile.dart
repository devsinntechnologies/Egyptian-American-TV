import 'package:flutter/material.dart';

Widget customTile(
    {var title,
    var subtitle,
    var icon,
    var child,
    tileTap,
    iconTap,
    iconColor}) {
  return Container(
    // decoration: BoxDecoration(),
    decoration: BoxDecoration(
      // shape: BoxShape.circle,
      border: Border(
        bottom: BorderSide(),
      ),
    ),
    child: ListTile(
      // minVerticalPadding:,
      //     shape: BeveledRectangleBorder( //<-- SEE HERE
      //   side: BorderSide(width: 2),
      //   borderRadius: BorderRadius.circular(20),
      // ),
      minVerticalPadding: 25,
      onTap: tileTap,
      tileColor: Colors.grey[200],
      leading: Container(
        width: 50,
        height: 60,
        child: child,
        decoration: BoxDecoration(
            color: Colors.grey[400],
            // shape: BoxShape.circle,
            borderRadius: BorderRadius.circular(15)),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        color: iconColor,
        splashRadius: 20,
        splashColor: Colors.red,
        onPressed: iconTap,
        icon: Icon(icon),
      ),
    ),
  );
}
