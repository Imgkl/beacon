import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

/// A Button that can detect swiping movement with shimmering arrows on far end.
/// Button that swipe and increase its width to maximum
// ignore: must_be_immutable

// Padding(
//   padding: const EdgeInsets.only(left:15.0,right:15),
//   child: SwipingButton(
//       text: "SWIPE TO ACCEPT & BID",
//       backgroundColor: COLOR_SPLASH_BG,
//       sucessfulText: "Bid Sucessful",
//       onSwipeCallback: () {
//         print("object");
//       }),
// ),
class SwipingButton extends StatefulWidget {
  /// The text that the button will display.
  final String text;
  final String sucessfulText;
  /// with of the button
  final double height;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;

  /// Optional changes
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle buttonTextStyle;
  final EdgeInsets padding;

  SwipingButton({
    Key key,
    @required this.text,
    this.height = 55,
    @required this.onSwipeCallback,
    this.swipeButtonColor = Colors.green,
    this.backgroundColor = Colors.white,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.iconColor = Colors.transparent,
    this.buttonTextStyle,
    @required this.sucessfulText,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => StateSwipingButton(
      sucessfulText: sucessfulText,
      text: text,
      onSwipeCallback: onSwipeCallback,
      height: height,
      padding: this.padding,
      swipeButtonColor: this.swipeButtonColor,
      backgroundColor: this.backgroundColor,
      iconColor: this.iconColor,
      buttonTextStyle: this.buttonTextStyle);
}

class StateSwipingButton extends State<SwipingButton> {
  /// The text that the button will display.
  final String text;
  final String sucessfulText;
  final double height;
  bool selected;

  /// The callback invoked when the button is swiped.
  final VoidCallback onSwipeCallback;
  bool isSwiping = false;
  double opacityVal = 1;
  final Color swipeButtonColor;
  final Color backgroundColor;
  final Color iconColor;
  TextStyle buttonTextStyle;
  final EdgeInsets padding;

  StateSwipingButton({
    Key key,
    @required this.sucessfulText,
    @required this.text,
    @required this.height,
    @required this.onSwipeCallback,
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.swipeButtonColor = Colors.amber,
    this.backgroundColor = Colors.black,
    this.iconColor = Colors.white,
    this.buttonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    if (buttonTextStyle == null) {
      buttonTextStyle = TextStyle(
          fontSize: 16.0, fontWeight: FontWeight.w800, color: Colors.white);
    }
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: padding,
      child: Stack(
        children: <Widget>[
          Container(
            height: height,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(height / 2)),
            child: new Center(
              child: Text(
                text.toUpperCase(),
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          SwipeableWidget(
            height: height,
            screenSize: MediaQuery.of(context).size.width -
                (padding.right + padding.left),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: _buildContent(),
              ),
              height: height,
              decoration: BoxDecoration(
                  color: swipeButtonColor,
                  borderRadius: BorderRadius.circular(height / 2)),
            ),
            onSwipeCallback: onSwipeCallback,
            onSwipeStartcallback: (val, conVal) {
              SchedulerBinding.instance
                  .addPostFrameCallback((_) => setState(() {
                        isSwiping = val;
                        opacityVal = 1 - conVal;
                      }));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Padding(
      padding: EdgeInsets.only(left: height / 3),
      child: Text(
        sucessfulText.toUpperCase(),
        style: buttonTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildContent() {
    return Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: AnimatedOpacity(
            opacity: (opacityVal - 0.2).isNegative ? 0.0 : (opacityVal - 0.2),
            duration: Duration(milliseconds: 10),
            child: Icon(
              Icons.chevron_right,
              color: iconColor,
              size: height * 0.6,
            ),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.center,
          child: AnimatedOpacity(
            opacity: (opacityVal - 0.4).isNegative ? 0.0 : (opacityVal - 0.4),
            duration: Duration(milliseconds: 10),
            child: Icon(
              Icons.chevron_right,
              color: iconColor,
              size: height * 0.6,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: isSwiping
              ? _buildText()
              : Container(
                  width: 0,
                  height: 0,
                ),
        )
      ],
    );
  }
}

class SwipeableWidget extends StatefulWidget {
  /// The `Widget` on which we want to detect the swipe movement.
  final Widget child;

  /// The Height of the widget that will be drawn, required.
  final double height;

  /// The `VoidCallback` that will be called once a swipe with certain percentage is detected.
  final VoidCallback onSwipeCallback;

  /// The decimal percentage of swiping in order for the callbacks to get called, defaults to 0.75 (75%) of the total width of the children.
  final double swipePercentageNeeded;

  final double screenSize;

  final Function(bool, double) onSwipeStartcallback;

  SwipeableWidget(
      {Key key,
      @required this.child,
      @required this.height,
      @required this.onSwipeCallback,
      @required this.onSwipeStartcallback,
      @required this.screenSize,
      this.swipePercentageNeeded = 0.75})
      : assert(child != null &&
            onSwipeCallback != null &&
            swipePercentageNeeded <= 1.0),
        super(key: key);

  @override
  _SwipeableWidgetState createState() => _SwipeableWidgetState();
}

class _SwipeableWidgetState extends State<SwipeableWidget>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  var _dxStartPosition = 0.0;
  var _dxEndsPosition = 0.0;
  var _initControllerVal;

  @override
  void initState() {
    super.initState();
    _initControllerVal = 0.2;
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300))
      ..addListener(() {
        if (_controller.value > _initControllerVal) {
          setState(() {});
          widget.onSwipeStartcallback(
              _controller.value > _initControllerVal + 0.1, _controller.value);
        }
        if (_controller.value == _initControllerVal) {
          widget.onSwipeStartcallback(false, 0);
        }
      });
//    _controller.addStatusListener(());

    _controller.value = _initControllerVal;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onPanStart: (details) {
          setState(() {
            _dxStartPosition = details.localPosition.dx;
          });
        },
        onPanUpdate: (details) {
          final widgetSize = context.size.width;

          // will only animate the swipe if user start the swipe in the quarter half start page of the widget
          final minimumXToStartSwiping = widgetSize * 0.25;
          if (_dxStartPosition <= minimumXToStartSwiping) {
            setState(() {
              _dxEndsPosition = details.localPosition.dx;
            });

            // update the animation value according to user's pan update
            final widgetSize = context.size.width;
            if (_dxEndsPosition >= minimumXToStartSwiping) {
              _controller.value = ((details.localPosition.dx) / widgetSize);
            }
          }
//          widget.onSwipeStartcallback(_controller.value);
        },
        onPanEnd: (details) async {
          // checks if the right swipe that user has done is enough or not
          final delta = _dxEndsPosition - _dxStartPosition;
          final widgetSize = context.size.width;
          final deltaNeededToBeSwiped =
              widgetSize * widget.swipePercentageNeeded;
          if (delta > deltaNeededToBeSwiped) {
            // if it's enough, then animate to hide them
            _controller.animateTo(1.0,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
            widget.onSwipeCallback();
          } else {
            // if it's not enough, then animate it back to its full width
            _controller.animateTo(_initControllerVal,
                duration: Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn);
          }
//          widget.onSwipeStartcallback(_controller.value);
        },
        child: Container(
          height: widget.height,
          child: Align(
            alignment: Alignment.centerLeft,
            child: FractionallySizedBox(
              widthFactor: _controller.value,
              heightFactor: 1.0,
              child: widget.child,
            ),
          ),
        ));
  }
}
