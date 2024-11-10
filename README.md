
# Food Item Selection App - Flutter Demo

## Overview
This Flutter application demonstrates the selection and ordering of food items using modern Flutter concepts such as state management, UI components, and performance optimizations. The app is built with `Flutter Hooks`, `Riverpod`, and various other Flutter tools to simulate a scalable, production-ready food delivery app.

## Features
- **State Management**:
    - Utilizes `StatefulHookConsumerWidget` and `ValueNotifier` to manage state efficiently.
    - `useEffect` is used for lifecycle management (similar to `initState`).
    - Centralized state using `ChangeNotifierProvider` and the `FoodDeliveryViewModel` to handle actions like item increment, total amount calculation, and adding items across screens.

- **Responsive UI**:
    - Dynamic UI components using `MediaQuery` to handle various screen sizes and ensure a responsive layout across devices.
    - `showModalBottomSheet` is used to show the cart and food item details in a bottom sheet for a smooth user experience.

- **Data Handling**:
    - The app uses a mock `food_list.json` file for food data, and a custom `FoodItems` model class to load and parse data using the `loadFoodItems` function.

- **Performance Optimization**:
    - A custom `CircularCachedNetworkImage` widget is created using the `cached_network_image` package to ensure image caching, improving app performance when loading images repeatedly.

- **Centralized Styling**:
    - Consistent styling and colors are defined in two constant files: `ColorConstants` and `StyleConstants` to maintain a uniform look across multiple screens.

## How to Run the Project

### Prerequisites
- Ensure you have **Flutter** and **Dart** installed. You can check your installation by running:
  ```bash
  flutter --version
  ```

- Install the necessary dependencies:
  ```bash
  flutter pub get
  ```

### Steps to Run

1. **Clone the Repository**:
    - Clone the repository to your local machine using Git:
      ```bash
      git clone [Insert GitHub URL]
      ```
    - Navigate to the project directory:
      ```bash
      cd [Project Directory]
      ```

2. **Run the App**:
    - Make sure you have an emulator running or a device connected.
    - Run the Flutter app:
      ```bash
      flutter run
      ```

3. **Test the App**:
    - After running the app, you should see the food item selection page.
    - Navigate through the app, interact with the cart, and explore the various features like adding items, viewing item details in a bottom sheet, and checking the total amount.

## Project Structure

```
lib/
 ├── constants/
 │    ├── color_constants.dart
 │    └── style_constants.dart
 ├── models/
 │    └── food_items.dart
 ├── providers/
 │    └── food_delivery_view_model.dart
 ├── screens/
 │    ├── food_list_screen.dart
 │    └── cart_screen.dart
 ├── widgets/
 │    ├── circular_cached_network_image.dart
 └── main.dart
```

- **constants/**: Contains files for color and style constants used across the app.
- **models/**: Contains data models, including the `FoodItems` class.
- **providers/**: Contains the `FoodDeliveryViewModel` class for state management.
- **screens/**: Contains screens like the food list page and the cart page.
- **widgets/**: Contains reusable widgets such as `CircularCachedNetworkImage`.
- **main.dart**: The entry point of the application.

## Demo

A video demo showcasing the app in action can be found here:  
[Google Drive Video Link](https://drive.google.com/file/d/1nsDeBuYA4ogZBb2X-c4hOO7srCwsU3_1/view?usp=sharing)

## GitHub Repository
You can access the source code here:  
[GitHub Repository](https://github.com/souvik2710/food_item_selection_app)

## Conclusion
This app demonstrates the use of advanced state management techniques, responsive design, and efficient data handling in Flutter. It is designed to simulate a complex food delivery app scenario while using modern Flutter tools like Riverpod, HookWidget, and more.

For any further questions or clarifications, feel free to contact me.
