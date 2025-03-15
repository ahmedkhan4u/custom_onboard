# Custom Onboarding Component for Flutter

This project provides a customizable onboarding component for Flutter apps. It allows you to create onboarding screens with flexible design and behavior options.

https://github.com/user-attachments/assets/898c952c-290d-4076-a091-3287a8fbe61f

## Features
- Multiple onboarding screens
- Customizable dot indicators
- Optional skip, next, and finish buttons
- Customizable text and button styles
- Animation support
- Callback functions for skip and finish actions

## Usage

```dart
import 'package:custom_onboard/custom_onboard.dart';

CustomOnboard(
  pages: [
    PageModel(
      title: "Onboarding 1",
      body: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
      imagePath: "assets/images/onboard1.png",
    ),
    PageModel(
      title: "Onboarding 2",
      body: "Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
      imagePath: "assets/images/onboard2.png",
    ),
    PageModel(
      title: "Onboarding 3",
      body: "An unknown printer took a galley of type and scrambled it to make a type specimen book.",
      imagePath: "assets/images/onboard3.png",
    ),
  ],
  finishButtonText: "Get Started",
  activeDotColor: Colors.deepPurple,
  onFinishClick: () {
    debugPrint('Onboarding completed');
    // Navigate to your desired page here.
  },
  onSkipClick: () {
    debugPrint('Onboarding skipped');
    // Navigate to your desired page here.
  },
)
```

## Parameters

| Parameter              | Type                    | Default          | Description                           |
|-----------------------|------------------------|------------------|---------------------------------------|
| `pages`                | `List<PageModel>`       | Required         | Onboarding pages data                 |
| `showDots`             | `bool?`                | `true`           | Show or hide dot indicators           |
| `activeDotColor`       | `Color?`               | `Colors.black`   | Color of the active dot               |
| `inactiveDotColor`     | `Color?`               | `Colors.grey`    | Color of inactive dots                |
| `skipButtonText`       | `String?`              | `null`           | Text for the skip button              |
| `nextButtonText`       | `String?`              | `null`           | Text for the next button              |
| `finishButtonText`     | `String?`              | `null`           | Text for the finish button            |
| `showSkipButton`       | `bool?`                | `true`           | Show or hide the skip button          |
| `onSkipClick`          | `void Function()?`     | `null`           | Callback when skip button is clicked  |
| `onFinishClick`        | `void Function()?`     | `null`           | Callback when finish button is clicked|
| `showAnimation`        | `bool`                 | `true`           | Enable or disable page animation      |

## PageModel

| Property        | Type      | Description                  |
|----------------|-----------|------------------------------|
| `title`         | `String?` | Title of the onboarding page |
| `body`          | `String?` | Body text of the page        |
| `imagePath`     | `String?` | Path to the page image       |
| `pageColor`     | `Color?`  | Background color of the page |
| `titleTextColor`| `Color?`  | Color of the title text      |
| `bodyTextColor` | `Color?`  | Color of the body text       |

## Example

```dart
PageModel(
  title: "Welcome",
  body: "Discover amazing features with our app.",
  imagePath: "assets/images/welcome.png",
  pageColor: Colors.blueAccent,
  titleTextColor: Colors.white,
  bodyTextColor: Colors.white70,
)
```

## License
This project is licensed under the MIT License.


