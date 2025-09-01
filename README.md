# BetterCRUD

BetterCRUD is a simple Swift application demonstrating the MVVM (Model-View-ViewModel) architecture pattern for basic CRUD (Create, Read, Update, Delete) operations. This project is designed as an exploration of MVVM in Swift, with automated tests included.

## Features

- **MVVM Architecture:** Clean separation of concerns using Models, ViewModels, and Views.
- **CRUD Operations:** Manage items and tasks with create, read, update, and delete functionality.
- **Persistence Layer:** Includes mock and preview data containers for testing and development.
- **Automated Testing:** Unit and UI tests provided for reliability and maintainability.

## Project Structure

```
BetterCRUD/
├── Models/           # Data models (Item, Task)
├── ViewModels/       # Business logic (ItemViewModel, TaskViewModel)
├── Views/            # SwiftUI views (List, Row, Create/Edit screens)
├── Persistences/     # Data containers (AppModelContainer, MockDataContainer, PreviewDataContainer)
├── BetterCRUDTests/  # Unit tests
├── BetterCRUDUITests/# UI tests
├── Assets.xcassets/  # App icons and colors
├── Info.plist        # App configuration
└── BetterCRUDApp.swift # App entry point
```

## Getting Started

1. Open `BetterCRUD.xcodeproj` in Xcode.
2. Build and run the app on a simulator or device.
3. Explore the MVVM implementation and CRUD features.

## Testing

- Run unit tests in the `BetterCRUDTests` folder.
- Run UI tests in the `BetterCRUDUITests` folder.

## Motivation

This project is mainly an exploration of MVVM in Swift, focusing on best practices for structuring code and automated testing.
