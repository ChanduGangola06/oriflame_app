# Oriflame App

A Flutter application for Oriflame products and services.

## Prerequisites

- Flutter SDK (version ^3.7.0)
- Dart SDK
- Android Studio / VS Code with Flutter extensions
- Git

## Getting Started

1. Clone the repository:
```bash
git clone [repository-url]
cd oriflame_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Project Structure

- `lib/` - Contains the main source code
- `assets/` - Contains images and SVG files
- `test/` - Contains test files
- Platform-specific folders (android/, ios/, web/, etc.)

## Dependencies

The project uses the following main dependencies:
- `image_picker: ^1.1.2` - For image selection functionality
- `url_launcher: ^6.3.1` - For handling external URLs
- `dots_indicator: ^4.0.1` - For pagination indicators

## Assumptions and Improvements

1. **Platform Support**: The app is configured to run on multiple platforms including Android, iOS, web, Windows, Linux, and macOS.

2. **Asset Management**: The project includes organized asset directories for images and SVG files.

3. **Code Quality**: The project uses `flutter_lints` for code quality enforcement.

4. **Development Environment**: The project assumes the use of either Android Studio or VS Code as the development environment.

## Contributing

1. Create a new branch for your feature
2. Make your changes
3. Submit a pull request

## License

This project is proprietary and not intended for public distribution.
