# Marvel Characters App

The Marvel Character App is a feature-rich and complex iOS application build using a mix of both `SwiftUI` and `UIKit` that allows users to explore characters from the Marvel Universe. It offers a seamless and fast user experience, thanks to its clever use of various technologies and design patterns. This README provides an overview of the app's architecture and features.

## Features

### Theme
- The app supports both light and dark mode.

### Marvel API Integration
- The app fetches characters from the [Marvel API](https://developer.marvel.com/docs#!/public/getCreatorCollection_get_0), allowing users to explore a vast array of Marvel characters.

### List View and Carousel View
- The app offers both a list view and a carousel view that are paginated for users to browse characters, providing a versatile and engaging user experience.
- Users can toggle between these views using a convenient button.

### `CoreData` Caching
- To enhance performance and user experience, the app uses `CoreData` to cache the first 15 characters. This ensures that users can quickly access previously viewed characters without making additional API requests.

### Image Loading Optimization
- The app optimizes image loading by detecting duplicate image requests and preventing redundant fetches. This means that an image displayed in multiple places will only be fetched once, reducing network usage and improving loading times.
- Fetched images are stored in `CoreData` for caching between app sessions, ensuring that previously viewed images are readily available.
- Images are also cached using `NSCache` for rapid loading within the same session, providing a smooth user experience.

### Character Details View
- The app includes a character details view that presents essential information about each character, including their image, name, and description.
- Users can interactively explore the first 3 comics, series, events, and stories related to the character via an elegant sheet overlay.

### Home Screen Widgets
- The app extends its functionality to the iOS Home Screen by allowing users to add character widgets.
- It leverages app groups to share data seamlessly between widgets and the main app.

### MVVM Clean Architecture
- The app is built using the MVVM (Model-View-ViewModel) clean architecture, promoting separation of concerns and maintainability.
- It utilizes use cases, entities, repository interfaces in the domain layer; and sources, repository implementations, DTOs (Data Transfer Objects), mappers, and services in the framework layer.
- Views, reusable components, and ViewModels are organized in the presentation layer, ensuring a clear and scalable code structure.

### Unit Tests
- The app includes a comprehensive suite of unit tests for repositories, sources, and ViewModels, ensuring code reliability and stability.

### Swift Concurrency
- Swift Concurrency is employed to optimize asynchronous operations, enhancing performance and responsiveness.
- The app has been profiled using Instruments to identify and eliminate performance bottlenecks and hangs.

## Getting Started

To run the app locally and explore its features, follow these steps:

1. Clone the repository to your local machine.
2. Open the Xcode project.
3. Configure an app group to be used by the app. (Optional, required for widgets)
4. Open `Persistence.swift` under `Marvel Characters/Framework/CoreData` and replace `{{AppGrpup}}` with the configured group name. (Optional, required for widgets)
5. Build and run the app on your iOS simulator or physical device.
6. Explore the app's list view, carousel view, character details, and widgets.

## Dependencies

The app uses third-party libraries and frameworks for specific functionalities. These dependencies are managed via Swift Package Manager:

- [TimmysApp/DataStructDataStruct](https://github.com/TimmysApp/DataStruct)
- [TimmysApp/NetworkUI](https://github.com/TimmysApp/NetworkUI)
- [Juanpe/SkeletonView](https://github.com/Juanpe/SkeletonView)

## Preview
![Simulator Screenshot - iPhone 14 Pro Max - 2023-09-25 at 21 36 33](https://github.com/TimmysApp/MarvelCharacters/assets/69967145/023fdd45-84a4-474d-94f2-3968d04de45f)
![Simulator Screenshot - iPhone 14 Pro Max - 2023-09-25 at 21 36 41](https://github.com/TimmysApp/MarvelCharacters/assets/69967145/0793431f-d2ba-4925-8221-529343d77065)
![Simulator Screenshot - iPhone 14 Pro Max - 2023-09-25 at 21 38 01](https://github.com/TimmysApp/MarvelCharacters/assets/69967145/bc6f8297-b2b4-4584-82a3-868277f062fa)
![Simulator Screenshot - iPhone 14 Pro Max - 2023-09-25 at 21 38 05](https://github.com/TimmysApp/MarvelCharacters/assets/69967145/8e890961-e0e5-477a-8e01-afcd03c497df)
![Simulator Screenshot - iPhone 14 Pro Max - 2023-09-25 at 21 38 15](https://github.com/TimmysApp/MarvelCharacters/assets/69967145/de9166d8-00a4-4502-b1e4-30adecc7482c)
