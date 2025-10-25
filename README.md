# WakeRide

WakeRide is a mobile application that functions as a location-aware alarm for commuters, allowing you to set a destination and receive an audible alert as you approach it. The app is perfect for those who tend to doze off during long journeys on buses, metros, or cabs :p

<img width="375" height="833" alt="image" src="https://github.com/user-attachments/assets/89d6d779-1be8-4917-a619-35f2db5f67b8" />

<img width="373" height="834" alt="Screenshot 2025-10-05 032409" src="https://github.com/user-attachments/assets/f60dd529-1c40-4c40-b746-81081945b71c" />


## Key Features

*   **Location-Based Alarms**: Set your destination on the map, and the app will track your location to alert you when you are nearby.
*   **Live Location Tracking**: OpenStreetMap to provide real-time location tracking on an interactive map.
*   **Customizable Ringtones**: Choose from your device's native ringtones to personalise your arrival alert. This is handled through a native Android method channel.
*   **Multiple Transport Modes**: The user interface is designed to accommodate different modes of transport, such as Bus/Metro and Cab/Auto Rickshaw.

## Technologies Used

*   **Framework**: Flutter
*   **Language**: Dart
*   **Mapping**: 
    *   `flutter_map` for OpenStreetMap integration.
    *   `flutter_map_location_marker` for displaying the user's location.
*   **Location Services**: `location` package for tracking GPS data.
*   **UI & Animations**: `lottie` and `animate_do` for animations.
*   **Native Integration**: A custom MethodChannel in `MainActivity.kt` to access and play Android system ringtones.

## Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

*   Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
*   An IDE like Android Studio or VS Code with Flutter plugins.
*   A connected device or emulator.

### Installation

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/thisisselva18/WakeRide.git
    ```

2.  **Navigate to the project directory:**
    ```sh
    cd WakeRide
    ```

3.  **Install dependencies:**
    ```sh
    flutter pub get
    ```
    
4.  **Run the application:**
    ```sh
    flutter run
    ```
    Note: The application requires location permissions to function correctly. Please grant them when prompted.


## Project Structure

The project is structured to separate concerns, making it easier to navigate and maintain.

*   `lib/main.dart`: The entry point for the Flutter application.
*   `lib/pages/`: Contains all the main screens (widgets) of the app.
    *   `home.dart`: The main landing page with transport mode selection.
    *   `openstreetmap.dart`: The screen that displays the map, user location, and handles location tracking.
    *   `bus_metro.dart` & `cab_auto.dart`: UI pages for specific transport modes.
    *   `ringtones.dart`: The page for listing and selecting system ringtones.
*   `android/app/src/main/kotlin/com/example/bus_app/MainActivity.kt`: Native Android code responsible for fetching, playing, and stopping system ringtones via a method channel.
*   `assets/`: Includes the Lottie JSON animation (`Bell_anim.json`) and custom fonts (`Gilroy`).
*   `pubspec.yaml`: Defines project dependencies, assets, and custom fonts.
