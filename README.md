# day5
> I ❤️ VIPER architecture. It was pretty overkill for this mini project, but it was fascinating to play around with it. I may use it for my next larger app.

**day5** is a beautiful, ultra-minimalistic, and intuitive iOS timer app built using the VIPER architecture and adhering to SOLID principles. This app was created as a fun day project to practice writing clean, modular, and loosely coupled code, while also experimenting with gesture-based controls.

## Gameplay
- **day5** is a gesture-based app with no buttons. 
- Start by selecting your **work** and **rest** durations on the intro screen using a **UIPanGestureRecognizer**. Simply slide your finger up and down to adjust the time.
- **Tap once** to switch between the work and rest duration selection views.
- **Double tap** to proceed to the main timer screen.
- In the main timer screen:
  - **Tap once** to toggle the visibility of the timer label (useful if seeing the timer causes anxiety).
  - **Double tap** to start and stop the timer.
  - As the timer progresses, a circular wheel visual fills up and the theme color transitions from red to green.
  - When the work timer finishes, the background changes to purple and automatically starts the rest timer.
  - The cycle repeats, creating a seamless pomodoro experience.

https://github.com/user-attachments/assets/875886a0-6eaa-4bce-8c21-c4127c1b53d1

https://github.com/user-attachments/assets/f9bc289e-9d24-45c5-969d-dc03f114c92e

## Features
- **VIPER Architecture**: Emphasizes clean, modular code with clear separation of concerns.
- **Gesture-Based Controls**: No buttons. All actions are controlled through gestures, making for an intuitive, minimalist user experience.
- **Visual Feedback**: The color and timer wheel visually change as the timer nears completion.
- **Anxiety-Friendly**: Option to hide the timer label with a simple tap to reduce time pressure.

## How to Run the App
1. Download and install [Xcode](https://developer.apple.com/xcode/).
2. Clone this repository:
   ```bash
   git clone https://github.com/doeunkwon/day5.git
3. Open the project in Xcode:
   ```bash
   open day5.xcodeproj
4. Select your preferred iOS Simulator or connect your physical iOS device.
5. Build and run the app using the play button in Xcode.
