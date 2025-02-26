library custom_onboard;

export 'custom_onboard.dart';
export 'src/page_model.dart';

import 'package:custom_onboard/src/page_model.dart';
import 'package:flutter/material.dart';

class CustomOnboard extends StatefulWidget {
  final List<PageModel> pages;
  final bool? showDots;
  final Color? activeDotColor;
  final Color? inactiveDotColor;
  final String? skipButtonText;
  final String? nextButtonText;
  final String? finishButtonText;
  final bool? showSkipButton;
  final void Function()? onSkipClick;
  final void Function()? onFinishClick;
  final TextStyle? titleTextStyle;
  final TextStyle? bodyTextStyle;
  final TextAlign? bodyTextAlignment;
  final TextStyle? buttonTextStyle;
  final TextStyle? skipButtonTextStyle;
  final TextStyle? nextButtonTextStyle;
  final TextStyle? finishButtonTextStyle;
  final BoxDecoration? buttonBoxDecoration;
  final BoxDecoration? skipButtonBoxDecoration;
  final BoxDecoration? nextButtonBoxDecoration;
  final BoxDecoration? finishButtonBoxDecoration;
  final Color skipButtonTextColor;
  final Color finishButtonTextColor;
  final Color nextButtonTextColor;
  final bool showAnimation;
  final EdgeInsetsGeometry buttonPadding;

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
    this.buttonBoxDecoration,
    this.skipButtonBoxDecoration,
    this.nextButtonBoxDecoration,
    this.finishButtonBoxDecoration,
    this.skipButtonTextColor = Colors.black,
    this.finishButtonTextColor = Colors.black,
    this.nextButtonTextColor = Colors.black,
    this.showAnimation = true,
    this.buttonPadding = const EdgeInsets.all(10.0),
  });

  @override
  State<CustomOnboard> createState() => _CustomOnboardState();
}

class _CustomOnboardState extends State<CustomOnboard> with TickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  final PageController _pageController = PageController(initialPage: 0);

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
        PageView(
          controller: _pageController,
          children: widget.pages.map((page) {
            return Container(
              padding: const EdgeInsets.all(16),
              color: page.pageColor,
              child: Column(
                children: [
                  SizedBox(height: height * 0.18),
                  SizedBox(
                    height: height * 0.3,
                    child: widget.showAnimation
                        ? ScaleTransition(
                            scale: _animation,
                            child: Visibility(
                              visible: _currentPage == widget.pages.indexOf(page),
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
            );
          }).toList(),
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
                  _currentPage != (widget.pages.length - 1) && widget.showSkipButton!
                      ? Expanded(
                          child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                              onTap: widget.onSkipClick,
                              child: Container(
                                  decoration: widget.skipButtonBoxDecoration ?? widget.buttonBoxDecoration,
                                  padding: widget.buttonPadding,
                                  child: Text(
                                    widget.skipButtonText ?? "SKIP",
                                    style: widget.skipButtonTextStyle ??
                                        widget.buttonTextStyle ??
                                        TextStyle(fontSize: 16, color: widget.skipButtonTextColor),
                                  ))),
                        ))
                      : const Expanded(child: SizedBox.shrink()),
                  widget.showDots!
                      ? Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: List.generate(widget.pages.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 4),
                                      child: Icon(
                                        Icons.circle,
                                        size: 12,
                                        color: _currentPage == index
                                            ? widget.activeDotColor ?? Colors.blueGrey
                                            : widget.inactiveDotColor ?? Colors.grey,
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
                          child: InkWell(
                              onTap: () {
                                if (_currentPage < widget.pages.length - 1) {
                                  _pageController.nextPage(
                                      duration: const Duration(milliseconds: 300), curve: Curves.fastOutSlowIn);
                                }
                              },
                              child: Container(
                                  decoration: widget.nextButtonBoxDecoration ?? widget.buttonBoxDecoration,
                                  padding: widget.buttonPadding,
                                  child: Text(
                                    widget.nextButtonText ?? "Next",
                                    style: widget.nextButtonTextStyle ??
                                        widget.buttonTextStyle ??
                                        TextStyle(fontSize: 16, color: widget.nextButtonTextColor),
                                  ))),
                        ))
                      :

                      /// Finish Button
                      Expanded(
                          child: Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                              onTap: widget.onFinishClick,
                              child: Container(
                                  decoration: widget.finishButtonBoxDecoration ?? widget.buttonBoxDecoration,
                                  padding: widget.buttonPadding,
                                  child: Text(
                                    widget.finishButtonText ?? "Finish",
                                    style: widget.finishButtonTextStyle ??
                                        widget.buttonTextStyle ??
                                        TextStyle(fontSize: 16, color: widget.finishButtonTextColor),
                                  ))),
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
