# Places - Wikipedia Test App

The Places repo consists of 2 app projects:
1. Places - This app allows a user to deeplink to the wikipedia places tab and show places around a specified coordinate.
2. Wikipedia iOS - This app is a fork of the public wikipedia iOS app with additions to allow coordinate based deeplinking to the Places feature.

# 1. Places

## Usage

Note: Make sure both the Wikipedia app and Places app are installed on your device.

### Deeplink from list
1. Open the Places app
2. Wait for the list of locations to load
3. Tap on any location to deeplink to it in the Wikipedia app places tab.

### Deeplink with custom location
1. Open the Places app
2. Wait for the list of locations to load
3. Tap on "Open Custom Place"
4. Enter valid latitude and longitude values
5. Tap on "Open Place" to deeplink to the coordinate in the Wikipedia app places tab.

## Architecture

The projects uses an MVVM-C architecture with repositories for the data fetching.

- Model layer: Handles all data definition & retrieval
    * Project folder: Data
- View layer: Handles all user interface definition
    * Project folder: Presentation
- ViewModel layer: Handles all communication between the View, Model and Coordinator layers
    * Project folder: Presentation
- Coordinator layer: Handles view creation and navigation
    * Project folder: Coordinator

## Frameworks

The project uses several Apple frameworks to function.
The idea was to build an app with Apple's latest tools and without using any 3rd party libraries.

- User Interface & Navigation
    * SwiftUI
- Network
    * URLSession
- Concurrency
    * async/await
    * Task
    * MainActor
- Location
    * Core Location
- Accessibility
    * SwiftUI View modifiers for improved VoiceOver output:
      * accessibilityElement
      * accessibilityLabels

## Dependency injection

Dependency injection is used in the project.

All classes on the Model & Coordinator layer have a protocol. The protocol defines the public methods.
In this way the implementation and definition are separated.
This is useful to allow for creating several implementations of a protocol for different purposes.
Because of this setup you can also create mock implementations of classes for use in testing later on.

In this project there is an actual implementation and the preview implementation for each protocol.

## SwiftUI & Previews

Previews are one of the most powerful and useful tools of SwiftUI.
So when implementing SwiftUI views I wanted to make sure that the previews give an accurate representation and are useful.
All the Model & Coordinator layer classes have a preview instance, which provide example data that is as close as possible to actual data.
These instances are used to provide data to render the view as accurately as possible in the preview canvas.

## SwiftUI navigation

This project moves away from the standard way of doing navigation in SwiftUI views with NavigationLink.
In keeping with the coordinator pattern, the navigation should be decoupled from the views.
This can be done by using UIKit and UIHostingController, but I wanted to keep the project fully in SwiftUI.

The solution was to use a SwiftUI View with a NavigationStack as the root view. This is the AppCoordinator class.
The AppCoordinator view then handles all the navigation between screens from it's NavigationStack.
The AppCoordinator itself is never displayed as the rootview of the NavigationStack can be set to a different view.

## Testing

The MVVM-C architecture works quite well for testing as it decouples the logic from the UI.
The project includes some initial ViewModel unit tests to illustrate how the logic can be tested separately from the UI.
Next to that using accessibilityIdentifiers the UI can be tested without knowing the internal implementation using UI tests. An initial example of this for the 'add custom place' error case is also added.

# 2. Wikipedia iOS modifications

Note: There is a bug with the general implementation of all deeplinks in the Wikipedia app. If the view is not already instantiated, the Wikipedia app will open but it won't navigate to the right tab and data.

The Wikipedia iOS app has code in both Objective-C and Swift, and both had to be used to get the new Places deeplinks to work.

To allow for the specific coordinate based deeplinking required, the Wikipedia project needed to be changed in 4 places:
* NSUserActivity+WMFExtensions.h
  - Reason: Declare the data type and property to retrieve the coordinate data from the deeplink.
* NSUserActivity+WMFExtensions.m
  - Reason: Identifying this new deeplink url pattern and retrieve the coordinate data for use. (Thus also implementing the declaration in the header file)
* WMFAppViewController.m
  - Reason: Gathering the retrieved coordinate data and navigating the PlacesViewController in the correct way.
* PlacesViewController.swift
  - Reason: Using the coordinate data passed from WMFAppViewController to setup the map and do a search for places around the coordinate.