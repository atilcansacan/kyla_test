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
  double _topCircleValue = 0.4;
  late double _height;
  late double _midScreen;
  late double _bottomLineForButton;
  late double _midPointOfDrag;
  late AnimationController _colorController;
  late Animation _colorAnimation;
  late AnimationController _bottomAnimationController;
  late Animation<double> _bottomAnimation;
  late AnimationController _controllerForButton;
  late Animation<double> _animationForButton;
  late AnimationController _widthController;
  late Animation<double> _widthAnimation;
  final int _duration = 1000;
  bool _updateButton = false;
  double _bottomWidth = 0.4;
  bool _isHeightZero = false;
  Color _backgroundColor = Colors.white;

  bool _isTapped = false;

  late AnimationController _topCircleController;
  late Animation<double> topCircleAnimation;

  @override
  void initState() {
    super.initState();
    _setColorController();
    _setBottomController();
    _setButtonController();
    _setTopCircleAnimation();
    _setWidthAnimation();
  }

  _onDragStarted(DragStartDetails details) {
    /* if (yPosition == _midScreen) {
      _midPointOfDrag = _height * 0.3;
    }
    if (yPosition == _bottomLineForButton) {
      _midPointOfDrag = _height * 0.7;
      */ /* setBottomAnimationValues();
      _startAnimation();
      animateBottomShape(); */ /*
    }*/
  }

  _onDragEnd(value) {
    /*   if (yPosition < _midPointOfDrag) {
      setState(() {
        yPosition = _midScreen;
        _value = 1.0;
      });
    }
    if (yPosition >= _midPointOfDrag) {
      setState(() {
        yPosition = _bottomLineForButton;
        _value = 0.0;
      });
    }
    if (yPosition == _midScreen) {
      setState(() {
        _bottomWidth = _bottomWidth;
        _topCircleValue = _topCircleValue;
      });
    }*/
  }

  _onDragUpdate(DragUpdateDetails dragDetails) {
    /*setState(() {
      yPosition = yPosition + dragDetails.delta.dy;
      _bottomAnimationController.value = yPosition / _height;
      print(yPosition);
    });

     if (_isTapped == false) {
      setState(() {

        yPosition = dragDetails.localPosition.dy
            .clamp(_midScreen, _bottomLineForButton);
      });

      print((dragDetails.localPosition.dy));
    } else {
      print('RUNNING::: $_isTapped ');
      setState(() {
        yPosition = (yPosition + dragDetails.delta.dy)
            .clamp(_midScreen, _bottomLineForButton);
      });
    }
    _updateOpacity();*/
  }

  _onTap() {
    print(_height * _bottomAnimation.value);
    print(_bottomAnimation.value);
    /* animateBottomShape();

    if (yPosition == _midScreen) {
      resetControllers();
      setBottomAnimationValues();
      setState(() {
        yPosition = _bottomLineForButton;
        _value = 0.0;
      });
    } else {
      _colorController.forward();
      _startAnimation();
      setState(() {
        yPosition = _midScreen;
      });
    }

    setState(() {
      _isTapped = !_isTapped;
    });*/
  }

  _updateOpacity() {
    if (yPosition <= _height * 0.8) {
      _value = 1.0;
    } else {
      _value = (_midScreen / yPosition);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Stack(
          children: <Widget>[
            const CenteredText(),
            const Positioned(
                bottom: 30, right: 0, left: 0, child: BottomNavBar()),
            AnimatedBuilder(
              animation: _colorController,
              builder: (context, child) {
                return Container(
                  color: mainBackgroundColor.withOpacity(_value),
                  child: yPosition == _midScreen
                      ? const MenuWidget()
                      : Container(),
                );
              },
            ),
            _isHeightZero == true
                ? Container()
                : Align(
                    alignment: Alignment.bottomCenter,
                    child: BottomAnimation(
                      animation: _bottomAnimation,
                      controller: _bottomAnimationController,
                      height:
                          yPosition.clamp(_height * 0.65, _bottomLineForButton),
                      topCircle: _topCircleValue,
                      width: _widthController.value,
                    ),
                  ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              top: yPosition.clamp(_midScreen, _bottomLineForButton),
              left: (size.width / 2) - (buttonSize / 2),
              child: Draggable(
                  axis: Axis.vertical,
                  feedback: Container(),
                  feedbackOffset: Offset.zero,
                  dragAnchorStrategy: childDragAnchorStrategy,
                  onDragEnd: (dragUpdateDetails) {
                    _setDragCancelBehaviour();
                  },
                  onDragUpdate: (dragUpdateDetails) {
                    setState(() {
                      _bottomAnimationController.value =
                          (dragUpdateDetails.globalPosition.dy /
                              _bottomLineForButton);
                      yPosition = dragUpdateDetails.globalPosition.dy;

                      _widthController.forward();
                    });
                    print('Controller :: ${_widthController.value}');
                    print('HEIGHT :: ${yPosition}');
                  },
                  child: animatedButton()),
            ),
          ],
        ),
      ),
    );
  }

  Widget animatedButton() {
    return AnimatedButton(
      yPosition: yPosition,
      animation: _animationForButton,
      duration: 1500,
      color: mainBackgroundColor,
      /*_updateButton && yPosition == _midScreen
          ? Colors.white
          : yPosition <= _height * 0.65 && yPosition != _midScreen
              ? Colors.transparent
              : mainBackgroundColor,*/
      icon: _updateButton
          ? Icon(
              Icons.close,
              color: mainBackgroundColor,
            )
          : const Icon(
              Icons.add,
              color: Colors.white,
            ),
    );
  }

  void _setBottomController() {
    _bottomAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 2000),
    )..addListener(() {
        final double bottomAnimationValue = _bottomAnimation.value;
        final bool isHeightBelowThreshold =
            bottomAnimationValue <= 0.59 || yPosition <= 0.6;
        if (isHeightBelowThreshold) {
          _bottomAnimationController.reverse();
          _topCircleController.reverse();
          _widthController.reverse();
        }

        /* if (_bottomAnimationController.isCompleted) {
          setState(() {
            _bottomWidth = 0.5;
            _topCircleValue = 0.5;
            _isHeightZero = true;
          });
        }*/
      });

    _bottomAnimation = TweenSequence<double>(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.92, end: 0.6)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 2,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.6, end: 0.92)
              .chain(CurveTween(curve: Curves.linear)),
          weight: 3,
        ),
      ],
    ).animate(_bottomAnimationController);
  }

  _setButtonController() {
    // Initialize the animation controller
    _controllerForButton = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
      reverseDuration: const Duration(milliseconds: 2000),
    )..addListener(() {
        //  print(_bottomAnimation.value);
      });

    // Create the animation
    _animationForButton =
        Tween<double>(begin: 0, end: 1).animate(_controllerForButton);
    _animationForButton.addListener(() {
      _animationForButton.value > 0.8
          ? setState(() {
              _updateButton = true;
            })
          : setState(() {
              _updateButton = false;
            });
    });
  }

  _setColorController() {
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _value = _colorAnimation.value;
          _backgroundColor =
              Color.lerp(Colors.white, mainBackgroundColor, _value)!;
        });
      });

    _colorAnimation = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(
        parent: _colorController,
        curve: Curves.easeInOut,
      ),
    );
  }

  _setTopCircleAnimation() {
    _topCircleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _topCircleValue = topCircleAnimation.value;
        });
      });

    topCircleAnimation = Tween<double>(begin: 0.4, end: 0.48).animate(
      CurvedAnimation(
        parent: _topCircleController,
        curve: Curves.easeInOut,
      ),
    );
  }

  _setWidthAnimation() {
    _widthController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..addListener(() {
        setState(() {
          _bottomWidth = _widthAnimation.value;
        });
      });

    _widthAnimation = Tween<double>(begin: 0.4, end: 0.45).animate(
      CurvedAnimation(
        parent: _widthController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startAnimation() {
    _bottomAnimationController.reset();
    _bottomAnimationController.forward();
  }

  void _setDragCancelBehaviour() {
    if (yPosition < _midPointOfDrag) {
      setState(() {
        yPosition = _midScreen;
        _value = 1.0;
      });
    }
    if (yPosition >= _midPointOfDrag) {
      setState(() {
        yPosition = _bottomLineForButton;
        _value = 0.0;
      });
    }
  }

  animateBottomShape() {
    _controllerForButton.forward();
    _topCircleController.forward();
    _widthController.forward();
  }

  reverseBottomShape() {
    _bottomAnimationController.reverse();
    _topCircleController.reverse();
    _widthController.reverse();
  }

  resetControllers() {
    _colorController.reset();
    _bottomAnimationController.reset();
    _controllerForButton.reset();
    _topCircleController.reset();
    _widthController.reset();
  }

  noneBottomAnimationValues() {
    setState(() {
      _bottomWidth = 0.4;
      _topCircleValue = 0.5;
      _isHeightZero = true;
    });
  }

  setBottomAnimationValues() {
    setState(() {
      _bottomWidth = 0.4;
      _topCircleValue = 0.4;
      _isHeightZero = false;
    });
  }

  @override
  void didChangeDependencies() {
    _height = MediaQuery.of(context).size.height;
    yPosition = _height * _bottomAnimation.value;

    _midScreen = menuItems.length <= 5 ? _height / 2 : _height * 0.2;
    _bottomLineForButton = _height * 0.92;
    _midPointOfDrag = menuItems.length <= 5
        ? _midScreen + (_bottomLineForButton - _midScreen) / 2
        : _height * 0.7;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _colorController.dispose();
    _bottomAnimationController.dispose();
    _controllerForButton.dispose();
    _topCircleController.dispose();
    _widthController.dispose();
    super.dispose();
  }
}
