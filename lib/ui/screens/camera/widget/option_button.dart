
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionButton extends StatefulWidget {
  final IconData icon;
  final Function onTapCallback;
  final AnimationController rotationController;
  final bool isEnabled;
  const OptionButton({
    Key? key,
    required this.icon,
    required this.onTapCallback,
    required this.rotationController,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _OptionButtonState createState() => _OptionButtonState();
}

class _OptionButtonState extends State<OptionButton>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();

    Tween(begin: 0.0, end: 1.0)
        .chain(CurveTween(curve: Curves.ease))
        .animate(widget.rotationController)
        .addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        //_oldOrientation = OrientationUtils.convertRadianToOrientation(_angle);
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.rotationController,
      builder: (context, child) {
        double newAngle;



        return IgnorePointer(
          ignoring: !widget.isEnabled,
          child: Opacity(
              opacity: widget.isEnabled ? 1.0 : 0.3,
              child: ClipOval(
                child: Material(
                  color: Color(0xFF4F6AFF),
                  child: InkWell(
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Icon(
                        widget.icon,
                        color: Colors.white,
                        size: 24.0,
                      ),
                    ),
                    onTap: () {
                      if (widget.onTapCallback != null) {
                        // Trigger short vibration
                        HapticFeedback.selectionClick();

                        widget.onTapCallback();
                      }
                    },
                  ),
                ),
              )),
        );
      },
    );
  }
}
