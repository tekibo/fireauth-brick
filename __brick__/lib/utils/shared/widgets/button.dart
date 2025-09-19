import 'package:flutter/material.dart';

enum ButtonState { idle, loading }

enum ButtonType { elevated, outlined, text, fancy }

class Button extends StatefulWidget {
  /// Content inside the button when the button state is idle.
  final Widget child;

  /// Content inside the button when the button state is loading.
  final Widget loadingWidget;

  /// The button type.
  final ButtonType type;

  /// Whether or not to animate the width of the button. Default is `true`.
  ///
  /// If this is set to `false`, you might want to set the `useEqualLoadingStateWidgetDimension` parameter to `true`.
  final bool useWidthAnimation;

  /// Whether or not to force the `loadingWidget` to have equal dimension.
  ///
  /// This is useful when you are using `CircularProgressIndicator` as the `loadingWidget`.
  ///
  /// This parameter might also be useful when you set the `useWidthAnimation` parameter to `true` combined with `CircularProgressIndicator` as the value for `loadingWidget`.
  final bool useEqualLoadingStateWidgetDimension;

  /// The button width.
  final double width;

  /// Width of the loading widget
  /// (when `useWidthAnimation` and `useEqualLoadingStateWidgetDimension` are set to `true`,
  /// this will be used as the target width to shrink animate to).
  final double? loadingWidth;

  /// The button height.
  final double height;

  /// The gap between button and it's content.
  ///
  /// This will be ignored when the `type` parameter value is set to `ButtonType.text`
  final double contentGap;

  /// The visual border radius of the button.
  final double borderRadius;

  /// The elevation of the button.
  ///
  /// This will only be applied when the `type` parameter value is `ButtonType.elevated`
  final double elevation;

  /// Color for the button.
  ///
  /// For [`ButtonType.elevated`]: This will be the background color.
  ///
  /// For [`ButtonType.outlined`]: This will be the border color.
  ///
  /// For [`ButtonType.text`]: This will be the text color.
  final Color buttonColor;
  final Color buttonColorLoading;

  /// The initial state of the button.
  final ButtonState state;

  /// Function to run when button is pressed.
  /// Can return a VoidCallback, FormFieldValidator, or Future.
  /// If external state control is needed, use a StatefulWidget parent
  /// to manage the state and rebuild this widget with different state values.
  final Function onPressed;

  const Button({
    super.key,
    required this.onPressed,
    required this.child,
    this.loadingWidget = const CircularProgressIndicator(),
    this.type = ButtonType.elevated,
    this.useWidthAnimation = true,
    this.useEqualLoadingStateWidgetDimension = true,
    this.width = double.infinity,
    this.loadingWidth,
    this.height = 40.0,
    this.contentGap = 0.0,
    this.borderRadius = 0.0,
    this.elevation = 0.0,
    this.buttonColor = Colors.blueAccent,
    this.buttonColorLoading = Colors.blueAccent,
    this.state = ButtonState.idle,
  });

  @override
  State createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  final GlobalKey _globalKey = GlobalKey();

  Animation? _anim;
  AnimationController? _animController;
  final Duration _duration = const Duration(milliseconds: 250);
  late double _width;
  late double _height;
  late double _borderRadius;
  late ButtonState _currentState;

  @override
  dispose() {
    if (_animController != null) {
      _animController!.dispose();
    }

    super.dispose();
  }

  @override
  void deactivate() {
    _reset();
    super.deactivate();
  }

  @override
  void initState() {
    _reset();
    _currentState = widget.state;
    super.initState();
  }

  @override
  void didUpdateWidget(Button oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Update internal state when widget state changes externally
    if (oldWidget.state != widget.state) {
      setState(() {
        _currentState = widget.state;
      });
    }
  }

  void _reset() {
    _width = widget.width;
    _height = widget.height;
    _borderRadius = widget.borderRadius;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(_borderRadius),
      child: SizedBox(
        key: _globalKey,
        height: _height,
        width: _width,
        child: _buildChild(context),
      ),
    );
  }

  Widget _buildChild(BuildContext context) {
    var padding = EdgeInsets.all(widget.contentGap);
    var buttonColor = widget.buttonColor;
    var buttonColorLoading = widget.buttonColorLoading;
    var shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
    );
    var border = BorderSide(
      color: _currentState == ButtonState.loading
          ? buttonColorLoading.withAlpha(128)
          : buttonColor.withAlpha(128),
    );

    final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      padding: padding,
      backgroundColor: _currentState == ButtonState.loading
          ? buttonColorLoading
          : buttonColor,
      elevation: widget.elevation,
      shape: shape,
    );

    final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
      padding: padding,
      shape: shape,
      side: BorderSide(
        color: _currentState == ButtonState.loading
            ? buttonColorLoading
            : buttonColor,
      ),
    );

    final ButtonStyle textButtonStyle = TextButton.styleFrom(padding: padding);

    final ButtonStyle fancyButtonStyle = TextButton.styleFrom(
      padding: padding,
      backgroundColor: _currentState == ButtonState.loading
          ? buttonColorLoading.withAlpha(86)
          : buttonColor.withAlpha(86),
      elevation: widget.elevation,
      shape: shape,
      side: border,
    );

    switch (widget.type) {
      case ButtonType.elevated:
        return ElevatedButton(
          style: elevatedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case ButtonType.outlined:
        return TextButton(
          style: outlinedButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case ButtonType.text:
        return TextButton(
          style: textButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
      case ButtonType.fancy:
        return TextButton(
          style: fancyButtonStyle,
          onPressed: _onButtonPressed(),
          child: _buildChildren(context),
        );
    }
  }

  Widget _buildChildren(BuildContext context) {
    double contentGap = widget.type == ButtonType.text
        ? 0.0
        : widget.contentGap;
    Widget contentWidget;

    switch (_currentState) {
      case ButtonState.idle:
        contentWidget = widget.child;

        break;
      case ButtonState.loading:
        contentWidget = widget.loadingWidget;

        if (widget.useEqualLoadingStateWidgetDimension) {
          if (widget.loadingWidth != null) {
            contentWidget = SizedBox(
              width: widget.loadingWidth,

              child: Center(child: widget.loadingWidget),
            );
          } else {
            contentWidget = SizedBox.square(
              dimension: widget.height - (contentGap * 2),
              child: widget.loadingWidget,
            );
          }
        }

        break;
    }

    return contentWidget;
  }

  VoidCallback _onButtonPressed() {
    return _manageLoadingState;
  }

  Future _manageLoadingState() async {
    // If external state control is being used, don't manage state internally
    if (widget.state != ButtonState.idle) {
      // Just call the onPressed function without state management
      dynamic result = await widget.onPressed();
      if (result != null &&
          (result is VoidCallback || result is FormFieldValidator)) {
        result();
      }
      return;
    }

    if (_currentState != ButtonState.idle) {
      return;
    }

    // The result of widget.onPressed() will be called as VoidCallback after button status is back to default.
    dynamic onIdle;

    if (widget.useWidthAnimation) {
      _toProcessing();
      _forward((status) {
        if (status == AnimationStatus.dismissed) {
          _toDefault();
          if (onIdle != null &&
              (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
            onIdle();
          }
        }
      });
      onIdle = await widget.onPressed();
      _reverse();
    } else {
      _toProcessing();
      onIdle = await widget.onPressed();
      _toDefault();
      if (onIdle != null &&
          (onIdle is VoidCallback || onIdle is FormFieldValidator)) {
        onIdle();
      }
    }
  }

  void _toProcessing() {
    setState(() {
      _currentState = ButtonState.loading;
    });
  }

  void _toDefault() {
    if (mounted) {
      setState(() {
        _currentState = ButtonState.idle;
      });
    } else {
      _currentState = ButtonState.idle;
    }
  }

  void _forward(AnimationStatusListener stateListener) {
    double initialWidth = _globalKey.currentContext!.size!.width;
    double initialBorderRadius = widget.borderRadius;
    double targetWidth = widget.loadingWidth ?? _height;
    double targetBorderRadius = _height / 2;

    _animController = AnimationController(duration: _duration, vsync: this);
    _anim = Tween(begin: 0.0, end: 1.0).animate(_animController!)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - targetWidth) * _anim!.value);
          _borderRadius =
              initialBorderRadius -
              ((initialBorderRadius - targetBorderRadius) * _anim!.value);
        });
      })
      ..addStatusListener(stateListener);

    _animController!.forward();
  }

  void _reverse() {
    _animController!.reverse();
  }
}
