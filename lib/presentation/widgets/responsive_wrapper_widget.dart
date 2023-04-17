import 'package:flutter/material.dart';

class ResponsiveWrapperWidget extends StatelessWidget {
  final Widget child;
  final bool? verticalPadding;

  const ResponsiveWrapperWidget({
    Key? key,
    required this.child,
    this.verticalPadding = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.03,
              vertical: verticalPadding! ? size.height * 0.02 : 0,
            ),
            child: child,
          );
        }
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.15,
            vertical: verticalPadding! ? size.height * 0.02 : 0,
          ),
          child: child,
        );
      },
    );
  }
}
