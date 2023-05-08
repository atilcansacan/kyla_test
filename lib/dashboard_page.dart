import 'package:flutter/material.dart';
import 'package:kyla_test/animation_bottom.dart';
import 'package:kyla_test/widgets_const/animated_button.dart';
import 'package:kyla_test/widgets_const/bottom_navbar.dart';
import 'package:kyla_test/widgets_const/const_values.dart';
import 'package:kyla_test/widgets_const/menu_widget.dart';
import 'widgets_const/center_text.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  DashboardPageState createState() => DashboardPageState();
}

class DashboardPageState extends State<DashboardPage>
    with TickerProviderStateMixin {
  late double yPosition;
  double _value = 0.0;
  double topCircleValue = 0.4;
  Color backgroundColor = Colors.white;
  late double height;
  late double midScreen;
  late double bottomLineForButton;
  late double midPointOfDrag;
  late AnimationController _colorController;
  late Animation colorAnimation;
  late AnimationController bottomAnimationController;
  late Animation<double> bottomAnimation;
  late AnimationController controllerForButton;
  late Animation<double> animationForButton;
  late AnimationController widthController;
  late Animation<double> widthAnimation;
  int duration = 1000;
  bool updateButton = false;
  double bottomWidth = 0.4;
  bool isHeightZero = false;

  late AnimationController topCircleController;
  late Animation<double> topCircleAnimation;
  @override
  void initState() {
    super.initState();
    setColorController();
    setBottomController();
    setButtonController();
    setTopCircleAnimation();
    setWidthAnimation();
  }

  _onDragStarted() {
    if (yPosition == midScreen) {
      midPointOfDrag = height * 0.3;
    }
    if (yPosition == bottomLineForButton) {
      midPointOfDrag = height * 0.7;
      setBottomAnimationValues();
      _startAnimation();
      animateBottomShape();
    }
  }

  _onDragEnd(value) {
    if (yPosition < midPointOfDrag) {
      setState(() {
        yPosition = midScreen;
        _value = 1.0;
      });
    }
    if (yPosition >= midPointOfDrag) {
      setState(() {
        yPosition = bottomLineForButton;
        _value = 0.0;
      });
    }
    if (yPosition == midScreen) {
      setState(() {
        bottomWidth = bottomWidth;
        topCircleValue = topCircleValue;
      });
    }
  }

  _onDragUpdate(dragDetails) {
    setState(() {
      yPosition = (yPosition + dragDetails.delta.dy)
          .clamp(midScreen, bottomLineForButton);

      if (yPosition <= height * 0.8) {
        _value = 1.0;
      } else {
        _value = (midScreen / yPosition);
      }
    });
  }

  _onTap() {
    animateBottomShape();

    if (yPosition == midScreen) {
      resetControllers();
      setBottomAnimationValues();
      setState(() {
        yPosition = bottomLineForButton;
        _value = 0.0;
      });
    } else {
      _colorController.forward();
      _startAnimation();
      setState(() {
        yPosition = midScreen;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          const CenteredText(),
          const Positioned(
              bottom: 30, right: 0, left: 0, child: BottomNavBar()),
          AnimatedBuilder(
            animation: _colorController,
            builder: (context, child) {
              return Container(
                color: mainBackgroundColor.withOpacity(_value),
                child:
                    yPosition == midScreen ? const MenuWidget() : Container(),
              );
            },
          ),
          isHeightZero == true
              ? Container()
              : Align(
                  alignment: Alignment.bottomCenter,
                  child: BottomAnimation(
                    animation: bottomAnimation,
                    controller: bottomAnimationController,
                    height: isHeightZero == true
                        ? height
                        : (height * bottomAnimation.value)
                            .clamp(height * 0.6, height * 0.95),
                    topCircle: topCircleValue,
                    width: bottomWidth,
                  ),
                ),
          animatedButton(),
        ],
      ),
    );
  }

  Widget animatedButton() {
    return AnimatedButton(
      animation: animationForButton,
      yPosition: yPosition,
      duration: 1500,
      color: updateButton && yPosition == midScreen
          ? Colors.white
          : yPosition <= height * 0.65 && yPosition != midScreen
              ? Colors.transparent
              : mainBackgroundColor,
      onTap: _onTap,
      icon: updateButton
          ? Icon(
              Icons.close,
              color: mainBackgroundColor,
            )
          : const Icon(
              Icons.add,
              color: Colors.white,
            ),
      onDragStarted: _onDragStarted,
      onDragEnd: _onDragEnd,
      onDragUpdate: _onDragUpdate,
    );
  }

  setBottomController() {
    // Initialize the animation controller
    bottomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 2000),
    )..addListener(() {
        if (bottomAnimation.value <= 0.59 || yPosition <= 0.6) {
          bottomAnimationController.reverse();
          topCircleController.reverse();
          widthController.reverse();
        }

        if (bottomAnimationController.isCompleted) {
          setState(() {
            bottomWidth = 0.5;
            topCircleValue = 0.5;
            isHeightZero = true;
          });
        }
      });

    // Create the animation
    bottomAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.92, end: 0.75)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 2,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.75, end: 0.92)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 3,
        ),
      ],
    ).animate(bottomAnimationController);
  }

  setButtonController() {
    // Initialize the animation controller
    controllerForButton = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 2000),
    )..addListener(() {
        //  print(bottomAnimation.value);
      });

    // Create the animation
    animationForButton =
        Tween<double>(begin: 0, end: 1).animate(controllerForButton);
    animationForButton.addListener(() {
      animationForButton.value > 0.8
          ? setState(() {
              updateButton = true;
            })
          : setState(() {
              updateButton = false;
            });
    });
  }

  setColorController() {
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _value = colorAnimation.value;
          backgroundColor =
              Color.lerp(Colors.white, mainBackgroundColor, _value)!;
        });
      });

    colorAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _colorController,
        curve: Curves.easeInOut,
      ),
    );
  }

  setTopCircleAnimation() {
    topCircleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          topCircleValue = topCircleAnimation.value;
        });
      });

    topCircleAnimation = Tween<double>(begin: 0.4, end: 0.48).animate(
      CurvedAnimation(
        parent: topCircleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  setWidthAnimation() {
    widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          bottomWidth = widthAnimation.value;
        });
      });

    widthAnimation = Tween<double>(begin: 0.4, end: 0.45).animate(
      CurvedAnimation(
        parent: widthController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startAnimation() {
    bottomAnimationController.reset();
    bottomAnimationController.forward();
  }

  animateBottomShape() {
    controllerForButton.forward();
    topCircleController.forward();
    widthController.forward();
  }

  reverseBottomShape() {
    bottomAnimationController.reverse();
    topCircleController.reverse();
    widthController.reverse();
  }

  resetControllers() {
    _colorController.reset();
    bottomAnimationController.reset();
    controllerForButton.reset();
    topCircleController.reset();
    widthController.reset();
  }

  noneBottomAnimationValues() {
    setState(() {
      bottomWidth = 0.4;
      topCircleValue = 0.5;
      isHeightZero = true;
    });
  }

  setBottomAnimationValues() {
    setState(() {
      bottomWidth = 0.4;
      topCircleValue = 0.4;
      isHeightZero = false;
    });
  }

  @override
  void didChangeDependencies() {
    yPosition = MediaQuery.of(context).size.height * 0.92;
    height = MediaQuery.of(context).size.height;
    midScreen = menuItems.length <= 5 ? height / 2 : height * 0.2;
    bottomLineForButton = height * 0.92;
    midPointOfDrag = menuItems.length <= 5
        ? midScreen + (bottomLineForButton - midScreen) / 2
        : height * 0.7;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _colorController.dispose();
    bottomAnimationController.dispose();
    controllerForButton.dispose();
    topCircleController.dispose();
    widthController.dispose();
    super.dispose();
  }
}
