# Weather App

![Weather App](screenshots/app_logo.png)

A beautiful Flutter weather application that fetches weather data from the OpenWeatherMap platform. This app uses the `http` package for API calls, `Riverpod` for state management, and follows the Clean Architecture pattern.

## Features

- Get real-time weather data for any city.
- Display weather conditions, temperature, and more.
- Handle errors gracefully with user-friendly messages.
- Search for cities with validation.

## Screenshots

![Home Screen](screenshots/home_screen.png)
![Error Screen](screenshots/error_screen.png)

## Demo Video

![Demo Video](screenshots/demo_video.gif)

## Installation

### Prerequisites

- [Flutter](https://flutter.dev/docs/get-started/install)
- An API key from [OpenWeatherMap](https://openweathermap.org/api)

### Steps

1. **Clone the repository**

    ```sh
    git clone https://github.com/Ali-2001-Eg/weather_forecast.git
    cd weather_app
    ```

2. **Get dependencies**

    ```sh
    flutter pub get
    ```

3. **Add your OpenWeatherMap API key**

    Create a file named `lib/api_key.dart` and add your API key:

    ```dart
    const String apiKey = 'YOUR_API_KEY';
    ```

4. **Run the app**

    ```sh
    flutter run
    ```

## Usage

1. **Search for a city**

    - Tap on the search button.
    - Enter the city name.
    - Press the search button to fetch and display the weather data.

2. **Error Handling**

    - If the city is not found, an error message will be displayed.
    - Ensure you have an active internet connection.

## Architecture

This application follows the Clean Architecture pattern:

- **Presentation Layer**: Flutter widgets, including the UI and state management.
- **Domain Layer**: Business logic and entities.
- **Data Layer**: Network calls and data models.

### Key Packages

- [http](https://pub.dev/packages/http) for API calls.
- [flutter_riverpod](https://pub.dev/packages/flutter_riverpod) for state management.

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes and commit them (`git commit -m 'Add new feature'`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Contact

If you have any questions or suggestions, feel free to reach out.

- Email: AliBusiness2001@outlook.com
- GitHub: [Ali-2001-Eg](https://github.com/Ali-2001-Eg/)
