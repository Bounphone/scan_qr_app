<h1 align="center">Hi 👋, Handsome and beautiful developers Welcome to Scan QR</h1>
<h3 align="center">"Scan QR is a project that introduces MVVM architecture and project structure approaches to developing Flutter apps".</h3>

# Note

- **All API Path we store in assets/.env**

# Require knowledge

Before you get start to implement this repository you must have these knowledges.

- **Local storage with Hive** 
- **State management with Provider**
- **HTTP client with Dio**
- **A little knowledge about Software Development with MVVM Architecture**

# Before you get start

- **Change Application ID (Android and IOS)**
- **Change App version**

## How to Use

**Step 1:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get 
```

**Step 2:**

Connect emulator and type `flutter run` to run this project

```
flutter run
```

# Module Structure

<p align="center">
  <img src="https://camo.githubusercontent.com/a5485a38e6af7aa1055807a47e1833fc9a35eb7b997940b26936dcffae760623/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f3737322f302a73664344456235373157442d374566502e6a7067" />
</p>

There are 3 main modules to help separate the code. They are Data, Domain, and Application.

- **Data** contains Local Storage, APIs, Data objects (Request/Response object, DB objects), and the repository implementation.

- **Domain** contains UseCases, Domain Objects/Models, and Repository Interfaces

- **Application** contains UI, View Objects, Widgets, etc. Can be split into separate modules itself if needed. For example, we could have a module called Device handling things like camera, location, etc.

## Project Structure

Our project base on MVVM pattern (Model View ViewModel) like this:

```
lib/
|- constants
|- local_storage
|- models
|- screens
|- services
|- utils
|- view_models
|- widgets
 - main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1 - constants -  All the application level constants are defined in this directory with-in their respective files. This directory contains the constants.
2 - local_storage - Connect data from Local DB.
3 - models - Contains model for parsing data from API, argruments, and other data.
4 - screens(view) - Updates UI, Knows about the ViewModel and Observes changes to ViewModel.
5 - services - Connect data from API.
6 - view_models - Organizes data and holds View state.
7 - widgets - Contains the common widgets for your applications. For example, Button, TextField etc.
8 - utils - Contains the utilities/common functions of your application.
9 - main.dart - This is the starting point of the application. All the application level configurations are defined in this file
```
