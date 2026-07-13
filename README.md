# Green Minds

![Green Minds Thumbnail](assets/thumbnail.png)

Green Minds is a Flutter-based mobile application designed to help farmers and agricultural enthusiasts make smarter crop decisions. The app provides a simple, friendly interface for entering soil and climate conditions and getting a crop recommendation through an integrated machine learning prediction flow.

## Overview

Green Minds combines modern mobile UI with practical agricultural intelligence. Users can:

- Explore a polished splash and home experience
- Enter key environmental parameters such as nitrogen, phosphorus, potassium, temperature, humidity, pH, and rainfall
- Send those inputs to a prediction backend
- Receive a crop suggestion based on the trained model

This project is ideal for showcasing how Flutter can be used for real-world agriculture and smart farming solutions.

## Features

- Beautiful and responsive mobile interface
- Easy-to-use crop prediction form
- Support for numeric environmental inputs
- Smooth navigation between splash, home, and prediction screens
- Integration with a backend prediction endpoint
- Lightweight and beginner-friendly project structure

## Tech Stack

- Flutter
- Dart
- Material Design UI
- HTTP networking for API communication
- Optional backend integration using a Python/Flask prediction service

## Project Structure

- lib/main.dart – app entry point and route setup
- lib/screens/home.dart – landing screen with app intro and start button
- lib/screens/perdict_screen.dart – crop input form and prediction UI
- lib/controllers/controller.dart – prediction logic and API request handling
- assets/ – app images and UI assets

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK
- Android Studio / VS Code with Flutter extensions
- A device emulator or physical device

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/green_minds.git
   cd green_minds
   ```

2. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Backend Requirement

The current Flutter app sends prediction requests to a local backend endpoint at:

```text
http://127.0.0.1:5000/predict
```

Ensure that your prediction backend is running and reachable before testing the crop prediction feature.

## Usage

1. Launch the app.
2. Tap Start from the home screen.
3. Enter the required agricultural values.
4. Press Predict to receive a crop recommendation.

## Screens

- Splash screen with branding
- Home screen with app introduction
- Crop input form with environmental measurements
- Prediction result display

## Future Improvements

Possible enhancements for the project include:

- Adding a more advanced machine learning model
- Displaying confidence scores for predictions
- Supporting multiple languages
- Enhancing the UI with charts and visual insights
- Deploying the backend to the cloud

## License

This project is open for educational and personal use.

## Contact

If you would like to contribute or improve the app, feel free to open an issue or submit a pull request.
