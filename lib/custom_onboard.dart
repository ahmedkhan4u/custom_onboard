library custom_onboard;

export 'custom_onboard.dart';
export 'src/page_model.dart';

import 'package:custom_onboard/src/custom_button.dart';
import 'package:custom_onboard/src/page_model.dart';
import 'package:flutter/material.dart';

/// A customizable onboarding screen widget with animation, navigation buttons, and indicators.
class CustomOnboard extends StatefulWidget {
  /// List of onboarding pages.
  final List<PageModel> pages;

  /// Whether to show dots as page indicators.
  final bool? showDots;

  /// Color of the active dot indicator.
  final Color? activeDotColor;

  /// Color of inactive dot indicators.
  final Color? inactiveDotColor;

  /// Text for the skip button.
  final String? skipButtonText;

  /// Text for the next button.
  final String? nextButtonText;

  /// Text for the finish button.
  final String? finishButtonText;

  /// Whether to show the skip button.
  final bool? showSkipButton;

  /// Callback when the skip button is clicked.
  final void Function()? onSkipClick;

  /// Callback when the finish button is clicked.
  final void Function()? onFinishClick;

  /// Style for the title text.
  final TextStyle? titleTextStyle;

  /// Style for the body text.
  final TextStyle? bodyTextStyle;

  /// Text alignment for the body text.
  final TextAlign? bodyTextAlignment;

  /// Style for button text.
  final TextStyle? buttonTextStyle;

  /// Style for the skip button text.
  final TextStyle? skipButtonTextStyle;

  /// Style for the next button text.
  final TextStyle? nextButtonTextStyle;

  /// Style for the finish button text.
  final TextStyle? finishButtonTextStyle;

  /// Button Style for all text buttons buttons OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey)
  final ButtonStyle? allButtonsStyle;

  /// Button Style for skip buttons OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey)
  final ButtonStyle? skipButtonStyle;

  /// Button Style for next buttons OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey)
  final ButtonStyle? nextButtonStyle;

  /// Button Style for finish buttons OutlinedButton.styleFrom(backgroundColor: Colors.blueGrey)
  final ButtonStyle? finishButtonStyle;

  /// Color of the skip button text.
  final Color skipButtonTextColor;

  /// Color of the finish button text.
  final Color finishButtonTextColor;

  /// Color of the next button text.
  final Color nextButtonTextColor;

  /// Color of the skip button.
  final Color? skipButtonColor;

  /// Color of the finish button.
  final Color? finishButtonColor;

  /// Color of the next button.
  final Color? nextButtonColor;

  /// Whether to enable animation for onboarding elements.
  final bool showAnimation;

  /// Padding for buttons.
  final EdgeInsetsGeometry buttonPadding;

  /// Creates a `CustomOnboard` widget.

  const CustomOnboard({
    super.key,
    required this.pages,
    this.showDots = true,
    this.activeDotColor = Colors.black,
    this.inactiveDotColor = Colors.grey,
    this.skipButtonText,
    this.nextButtonText,
    this.finishButtonText,
    this.showSkipButton = true,
    this.onSkipClick,
    this.onFinishClick,
    this.titleTextStyle,
    this.bodyTextStyle,
    this.bodyTextAlignment,
    this.buttonTextStyle,
    this.skipButtonTextStyle,
    this.nextButtonTextStyle,
    this.finishButtonTextStyle,
    this.allButtonsStyle,
    this.skipButtonStyle,
    this.nextButtonStyle,
    this.finishButtonStyle,
    this.skipButtonTextColor = Colors.black,
    this.finishButtonTextColor = Colors.black,
    this.nextButtonTextColor = Colors.black,
    this.showAnimation = true,
    this.buttonPadding = const EdgeInsets.all(10.0),
    this.skipButtonColor,
    this.finishButtonColor,
    this.nextButtonColor,
  });

  @override
  State<CustomOnboard> createState() => _CustomOnboardState();
}

/// The state class for `CustomOnboard`, handling page navigation and animations.

class _CustomOnboardState extends State<CustomOnboard>
    with TickerProviderStateMixin {
  /// Animation controller for onboarding animations.
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  /// Animation for onboarding elements.

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  /// Controller for the onboarding pages.
  final PageController _pageController = PageController(initialPage: 0);

  /// Index of the current onboarding page.

  int _currentPage = 0;

  @override
  void initState() {
    if (widget.showAnimation) {
      _animationController.forward();
    }
    super.initState();
    _pageController.addListener(() {
      setState(() {
        int newPage = _pageController.page!.round();
        if (_currentPage != newPage) {
          _currentPage = newPage;
          if (widget.showAnimation) {
            _animationController.reset(); // Reset animation
            _animationController.forward(); // Start fresh
          } else {
            _animationController.stop();
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.pages.length,
          controller: _pageController,
          itemBuilder: (context, index) {
            final page = widget.pages[index];
            return Container(
              padding: const EdgeInsets.all(16),
              color: page.pageColor,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: height * 0.18),
                    SizedBox(
                      height: height * 0.3,
                      child: widget.showAnimation
                          ? ScaleTransition(
                              scale: _animation,
                              child: Visibility(
                                visible:
                                    _currentPage == widget.pages.indexOf(page),
                                child: Image.asset(
                                  page.imagePath!,
                                  height: height * 0.3,
                                  width: width * 1,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : Image.asset(
                              page.imagePath!,
                              height: height * 0.3,
                              width: width * 1,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                    SizedBox(height: height * 0.04),
                    Text(
                      page.title!,
                      // maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: widget.titleTextStyle ??
                          TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: page.titleTextColor,
                          ),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      page.body!,
                      textAlign: widget.bodyTextAlignment ?? TextAlign.center,
                      style: widget.bodyTextStyle ??
                          TextStyle(
                            fontSize: 18,
                            color: page.bodyTextColor,
                          ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: width * 1,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _currentPage != (widget.pages.length - 1) &&
                          widget.showSkipButton!
                      ? Expanded(
                          child: Align(
                          alignment: Alignment.bottomLeft,
                          child: CustomButton(
                            text: widget.skipButtonText ?? "Skip",
                            onTap: widget.onSkipClick,
                            textStyle: widget.skipButtonTextStyle,
                            textColor: widget.skipButtonTextColor,
                            buttonStyle: widget.allButtonsStyle ??
                                widget.skipButtonStyle,
                            buttonColor: widget.skipButtonColor,
                            padding: widget.buttonPadding,
                          ),
                        ))
                      : const Expanded(child: SizedBox.shrink()),
                  widget.showDots!
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(widget.pages.length,
                                      (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: _currentPage == index
                                            ? widget.activeDotColor ??
                                                Colors.blueGrey
                                            : widget.inactiveDotColor ??
                                                Colors.grey,
                                      ),
                                    );
                                  })),
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),

                  /// Next Button
                  _currentPage != (widget.pages.length - 1)
                      ? Expanded(
                          child: Align(
                          alignment: Alignment.bottomRight,
                          child: CustomButton(
                            text: widget.nextButtonText ?? "Next",
                            onTap: () {
                              if (_currentPage < widget.pages.length - 1) {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.fastOutSlowIn);
                              }
                            },
                            textStyle: widget.nextButtonTextStyle,
                            textColor: widget.nextButtonTextColor,
                            buttonStyle: widget.allButtonsStyle ??
                                widget.nextButtonStyle,
                            buttonColor: widget.nextButtonColor,
                            padding: widget.buttonPadding,
                          ),
                        ))
                      :

                      /// Finish Button
                      Expanded(
                          child: Align(
                          alignment: Alignment.bottomRight,
                          child: CustomButton(
                            text: widget.finishButtonText ?? "Finish",
                            onTap: widget.onFinishClick,
                            textStyle: widget.finishButtonTextStyle,
                            textColor: widget.finishButtonTextColor,
                            buttonStyle: widget.allButtonsStyle ??
                                widget.finishButtonStyle,
                            buttonColor: widget.finishButtonColor,
                            padding: widget.buttonPadding,
                          ),
                        )),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}
