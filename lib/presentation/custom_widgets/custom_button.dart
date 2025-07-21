import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CustomButton extends StatefulWidget
{
  final VoidCallback? onTapBut;
  final double height, width, circleRedus;
  final bool isIcon;
  final String text;
  final Color? colorBackground;
  CustomButton(this.text, {super.key, this.onTapBut, this.height = 100, this.width = 100, this.isIcon = false, this.circleRedus = 13.0, this.colorBackground});
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
     return InkWell(
       onTap:widget.onTapBut,
       child: Container(
         height: widget.height,
         width: widget.width,
         decoration: BoxDecoration(
           color: widget.colorBackground??Colors.blue,
           borderRadius: BorderRadius.circular(widget.circleRedus),
         ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             if(widget.isIcon)
               ...[  const Icon(
                 Icons.add,
                 color: Colors.white,
               ),
                 SizedBox(width: ScreenUtil().setSp(10)),],


             Text(
              widget.text,
               style: const TextStyle(
                 color: Colors.white,
                 fontSize: 18,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ],
         ),
       ),
     );
  }
}