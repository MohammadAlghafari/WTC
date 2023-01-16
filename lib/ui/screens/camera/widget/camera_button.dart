import 'package:flutter/material.dart';

class CameraButton extends StatefulWidget {
  final Function onTap;

  const CameraButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late double _scale;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animationController.value;

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: SizedBox(
        key: const ValueKey('cameraButton' 'Photo'),
        height: 70,
        width: 70,
        child: Transform.scale(
          scale: _scale,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.5),
            ),
            child: Center(
              child: Container(
                height: 35,
                width: 35,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColor.customButtonGradient),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _onTapDown(TapDownDetails details) {
    _animationController.forward();
  }

  _onTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100), () {
      _animationController.reverse();
    });

    widget.onTap.call();
  }

  _onTapCancel() {
    _animationController.reverse();
  }
}

class CameraButtonPainter extends CustomPainter {
  final bool isRecording;

  CameraButtonPainter({
    this.isRecording = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var bgPainter = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    var radius = size.width / 2;
    var center = Offset(size.width / 2, size.height / 2);
    bgPainter.color = Colors.white.withOpacity(.5);
    canvas.drawCircle(center, radius, bgPainter);

    bgPainter.color = Colors.white;
    canvas.drawCircle(center, radius - 15, bgPainter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class AppColor {
  static const LinearGradient customButtonGradient = LinearGradient(
      colors: [Color(0xff017DF5), Color(0xff5BAFFF)],
      begin: Alignment.centerRight,
      end: Alignment.centerLeft);
}
