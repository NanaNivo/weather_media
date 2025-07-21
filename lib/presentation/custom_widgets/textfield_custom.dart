import 'package:flutter/material.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';




class TextfieldCustom extends StatefulWidget {
  final String? hintText;
  final bool onValidation;
  final ValueChanged<String>? onValueChanged;

  const TextfieldCustom({super.key, this.hintText, this.onValueChanged, this.onValidation = true});

  @override
  State<TextfieldCustom> createState() => _TextfieldCustomState();
}

class _TextfieldCustomState extends State<TextfieldCustom> {
  final TextEditingController _textController = TextEditingController();
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  final homeBloc = locator<HomeBloc>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 19),
        // height: MediaQuery.of(context).size.height/20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: locator<AppThemeColors>().black,
          ),
        ),

          child: TextFormField(
            controller: _textController,
            style: const TextStyle(fontWeight: FontWeight.bold),
            decoration: InputDecoration(
//contentPadding: EdgeInsetsDirectional.zero,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                  color: locator<AppThemeColors>().black,
                  fontWeight: FontWeight.bold),
              border: InputBorder.none,

              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            onChanged: (String value) async {
              widget.onValueChanged?.call(value);
            },
            validator: (String? value) {


                // if (!widget.onValidation) {
                //   return null;
                // } else if (value.isEmpty && widget.hintText.isEmpty) {
                //   return 'the field is Required';
                // }

              return null;
            },
          ),
        );
  }


}
