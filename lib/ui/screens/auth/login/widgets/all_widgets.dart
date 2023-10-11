import 'package:flutter/material.dart';
import 'package:todo_mon_c9/ui/utils/app_colors.dart';

Widget textFF({
  required TextEditingController controller,
  required String labelText,
  bool isPass = false,
  bool isShown = true,
  IconButton? icon ,
  bool isMultiLine = false,
}) => TextFormField(
  controller: controller,
  decoration: InputDecoration(
    hintText: labelText,
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
    suffixIcon: isPass?
    icon: null,

),
  obscureText: !isShown,
  keyboardType:isMultiLine? TextInputType.multiline : null,
  maxLines:isMultiLine? 5 : 1,
);




Widget buttonElevated({
  required VoidCallback function,
  required String name,
}) => ElevatedButton(
  onPressed: function,
  style: ButtonStyle(
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(color: AppColors.primary),
      ),
    ),
  ),
  child: Padding(
    padding: EdgeInsets.symmetric(
        vertical: 16, horizontal: 12),
    child: Row(
      children: [
        Text(name, style: TextStyle(fontSize: 18),),
        Spacer(),
        Icon(Icons.arrow_forward)
      ],
    ),
  ),
);