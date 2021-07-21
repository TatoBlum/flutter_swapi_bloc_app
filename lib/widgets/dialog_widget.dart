import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget {
  final String text;
  final String description;
  final Function onPressed;
  final BuildContext context;
  final int width;
  final String btnOkText;

  AlertDialogWidget({
    @required this.text,
    @required this.onPressed,
    @required this.context,
    @required this.description,
    @required this.width,
    this.btnOkText,
  }) {
    this._dialog();
  }

  _dialog() => AwesomeDialog(
        context: context,
        dialogType: DialogType.NO_HEADER,
        headerAnimationLoop: false,
        title: this.text,
        desc: this.description,
        showCloseIcon: true,
        btnOkText: (btnOkText == null) ? 'Thanks!' : this.btnOkText,
        btnOkOnPress: this.onPressed,
        btnOkColor: Theme.of(context).primaryColor,
        btnCancelColor: Colors.grey[400],
        buttonsBorderRadius: BorderRadius.all(Radius.circular(5)),
        width: MediaQuery.of(context).size.width / 100 * this.width,
        buttonsTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18),
      )..show();
}
