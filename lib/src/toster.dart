import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

enum MsgType {
  ERROR,
  WARNING,
  SUCESS,
  NONE,
}

OverlayEntry? entry;
bool _opened = false;

class AwesomeToster {
  showOverlay({
    required BuildContext context,
    required String msg,
    TextStyle? msgStyle,
    Color? msgColor,
    double? top,
    required MsgType? msgType,
    double? left,
    double? right,
    double? bottom,
    double? tosterHeight,
    double? tosterWidth,
    double? msgTextSize,
    EdgeInsetsGeometry? tosterPadding,
    Color? backgroundColor,
    BorderRadiusGeometry? tosterRadius,
    IconData? prefixIcon,
    Duration? timeToShow,
  }) {
    final overlay = Overlay.of(context);
    entry = null;
    entry = OverlayEntry(builder: (context) {
      return OverLayContent(
        top: top,
        msg: msg,
        backgroundColor: backgroundColor,
        bottom: bottom,
        left: left,
        msgColor: msgColor,
        msgStyle: msgStyle,
        msgTextSize: msgTextSize,
        right: right,
        tosterHeight: tosterHeight,
        tosterPadding: tosterPadding,
        tosterRadius: tosterRadius,
        tosterWidth: tosterWidth,
        msgType: msgType,
        iconData: prefixIcon,
      );
    });

    if (_opened == false) {
      Overlay.of(context)?.insert(entry!);
      _opened = true;
    }
    if (_opened == true) {
      Timer(timeToShow ?? const Duration(seconds: 1), () {
        if (entry != null && entry?.mounted == true) {
          entry?.remove();
          entry = null;

          _opened = false;
        }
      });
    }
  }
}

class OverLayContent extends StatefulWidget {
  final String msg;
  final TextStyle? msgStyle;
  final Color? msgColor;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? tosterHeight;
  final double? tosterWidth;
  final double? msgTextSize;
  final EdgeInsetsGeometry? tosterPadding;
  final Color? backgroundColor;
  final BorderRadiusGeometry? tosterRadius;
  final MsgType? msgType;
  final IconData? iconData;
  const OverLayContent(
      {Key? key,
      this.iconData,
      this.msgType,
      this.msgColor,
      this.msgTextSize,
      required this.msg,
      this.top,
      this.tosterWidth,
      this.left,
      this.right,
      this.bottom,
      this.tosterHeight,
      this.backgroundColor,
      this.tosterRadius,
      this.tosterPadding,
      this.msgStyle})
      : super(key: key);

  @override
  State<OverLayContent> createState() => _OverLayContentState();
}

class _OverLayContentState extends State<OverLayContent> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.top ?? 130,
      left: widget.left,
      right: widget.right ?? 10,
      bottom: widget.bottom,
      child: Material(
        color: Colors.transparent,
        child: SlideInRight(
          child: Dismissible(
            onDismissed: (d) {
              if (_opened) {
                if (entry != null && entry?.mounted == true) {
                  entry?.remove();
                  entry = null;
                  _opened = false;
                }
              }
            },
            key: UniqueKey(),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: widget.msgType == MsgType.ERROR
                      ? const Color(0xffFFEDED)
                      : widget.msgType == MsgType.WARNING
                          ? const Color.fromARGB(62, 255, 248, 114)
                          : widget.msgType == MsgType.SUCESS
                              ? const Color.fromARGB(255, 201, 239, 215)
                              : widget.backgroundColor,
                  borderRadius:
                      widget.tosterRadius ?? BorderRadius.circular(14)),
              height: widget.tosterHeight ?? 50,
              width: widget.tosterWidth ??
                  MediaQuery.of(context).size.width * 0.94,
              child: Padding(
                padding: widget.tosterPadding ??
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      widget.msgType == MsgType.ERROR
                          ? Icons.error
                          : widget.msgType == MsgType.WARNING
                              ? Icons.warning
                              : widget.msgType == MsgType.SUCESS
                                  ? Icons.check
                                  : widget.iconData,
                      color: widget.msgType == MsgType.ERROR
                          ? const Color(
                              0xffFF1010,
                            )
                          : widget.msgType == MsgType.WARNING
                              ? const Color(0xffF9A821)
                              : widget.msgType == MsgType.SUCESS
                                  ? const Color.fromARGB(255, 4, 173, 66)
                                  : widget.msgColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      widget.msg,
                      style: widget.msgStyle ??
                          TextStyle(
                              color: widget.msgType == MsgType.ERROR
                                  ? const Color(
                                      0xffFF1010,
                                    )
                                  : widget.msgType == MsgType.WARNING
                                      ? const Color(0xffF9A821)
                                      : widget.msgType == MsgType.SUCESS
                                          ? const Color.fromARGB(
                                              255, 4, 173, 66)
                                          : widget.msgColor,
                              fontSize: widget.msgTextSize ?? 15,
                              fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        if (entry != null && entry?.mounted == true) {
                          entry?.remove();
                          entry = null;
                          _opened = false;
                        }
                      },
                      child: Icon(Icons.close,
                          size: 20,
                          color: widget.msgType == MsgType.ERROR
                              ? const Color(
                                  0xffFF1010,
                                )
                              : widget.msgType == MsgType.WARNING
                                  ? const Color(0xffF9A821)
                                  : widget.msgType == MsgType.SUCESS
                                      ? const Color.fromARGB(255, 4, 173, 66)
                                      : widget.msgColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
