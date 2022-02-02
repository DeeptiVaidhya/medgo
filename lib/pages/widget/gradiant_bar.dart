// Copyright 2015 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
// modified by https://bluemix.github.io

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';

const double _kLinearProgressIndicatorHeight = 6.0;
const int _kIndeterminateLinearDuration = 1800;

class MyGradientProgressIndicator extends StatefulWidget {
  const MyGradientProgressIndicator({
    this.key,
    this.value,
    this.gradient = Gradients.hotLinear,
  }) : super(key: key);

  @override
  final Key key;
  final double value;
  final LinearGradient gradient;

  @override
  _MyGradientProgressIndicatorState createState() =>
      _MyGradientProgressIndicatorState();
}

class _MyGradientProgressIndicatorState
    extends State<MyGradientProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> pAnimation;
  List<Color> colors = [];

  double prevValue = 0.0;

  CurvedAnimation curvedAnimation;

  @override
  void initState() {
    super.initState();

    assert(widget.gradient != null, 'Please set the gradient!');
    assert(widget.gradient.colors.length == 3,
        'gradient must have two colors only');

    _setColorsArray();

    _controller = AnimationController(
      duration: const Duration(milliseconds: _kIndeterminateLinearDuration),
      vsync: this,
    );

    _setControllerListener();

    curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);
    pAnimation = Tween<double>(begin: prevValue, end: widget.value ?? 1.0)
        .animate(curvedAnimation);
    prevValue = widget.value ?? 0;

    _controller.forward();
  }

  void _setColorsArray() {
    colors.clear();
    colors.addAll(widget.gradient.colors);
    colors.add(Color(0xffCCD1D9));
    //print(widget.gradient.colors);
  }

  void _setControllerListener() {
    if (widget.value == null) {
      _controller.addStatusListener((status) {
        if (status == AnimationStatus.dismissed && widget.value == null) {
          _controller.forward();
        } else if (status == AnimationStatus.completed &&
            widget.value == null) {
          _controller.reverse();
        }
      });
    }
  }

  @override
  void didUpdateWidget(MyGradientProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    _setColorsArray();

    _setControllerListener();

    if (widget.value == null && !_controller.isAnimating) {
      _controller.reset();
    } else if (widget.value != null) {
      pAnimation = Tween<double>(begin: prevValue, end: widget.value)
          .animate(curvedAnimation);
      _controller
        ..reset()
        ..forward();
      prevValue = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void stopAnimation() {
    _controller.stop();
  }

  Widget _buildIndicator(BuildContext context, double animationValue) {
    return Container(
      constraints: const BoxConstraints.tightFor(
        width: double.infinity,
        height: _kLinearProgressIndicatorHeight,
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          gradient: LinearGradient(
              begin: widget.gradient.begin,
              end: widget.gradient.end,
              stops: <double>[
                0.2,
                0.5,
                animationValue,
                widget.value == null ? 1.0 : animationValue + 0.01,
              ],
              colors: colors)),
    );
  }

  @override
  Widget build(BuildContext context) {
//    final TextDirection textDirection = Directionality.of(context);
    return AnimatedBuilder(
      animation: pAnimation,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(context, pAnimation.value);
      },
    );
  }
}