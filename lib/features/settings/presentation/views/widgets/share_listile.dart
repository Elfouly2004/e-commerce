import 'package:flutter/material.dart';



class ShareListile extends StatelessWidget {
  const ShareListile({super.key, this.title, this.leading, this.trailing, this.onTap, this.text, this.text2});
  final Widget? title;
  final  Widget? leading;
  final Widget? trailing;
  final void Function()? onTap;
  final String? text;
  final String? text2;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        Card(
          child: GestureDetector(
            onTap:onTap ,
            child: ListTile(

              leading: leading,

              title: title,

              trailing: trailing,

            ),
          ),
        ),
      ],
    );
  }
}