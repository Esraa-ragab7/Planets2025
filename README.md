# Planets
Planets is an educational app designed to share detailed information about the planets in our solar system. 

## Architecture pattern
* MVVM(Model View ViewModel) + Clean Architecture concepts

## Run Requirements
- **Minimum iOS Version**: 15
- **Minimum Xcode Version**: 13
- **Framework**: SwiftUI

## Installation 
1. Clone this repository:
   ```bash
   git clone https://github.com/Esraa-ragab7/Planets2025.git
   
2. Navigate to the project directory::
   ```bash
   cd Planets

3. Open the project in Xcode:
   ```bash
   open Planets.xcodeproj
   
4- Build and run the project on the iOS Simulator or a connected device.


### Dark Mode Screenshots (portrait and Landscape orientation)
![Simulator Screenshot - iPhone 11 - 2025-01-17 at 14 48 45](https://github.com/user-attachments/assets/f7417705-4702-4ebc-8d0a-8205ba4756c7)
![Simulator Screenshot - iPhone 11 - 2025-01-17 at 14 45 15](https://github.com/user-attachments/assets/41d02de4-b131-4c5c-b5ed-86a05543ac74)


### Light Mode Screenshots (portrait and Landscape orientation)
![Simulator Screenshot - iPhone 11 - 2025-01-17 at 14 45 00](https://github.com/user-attachments/assets/7b7d3418-5dfa-4311-affc-3ef5808f496b)
![Simulator Screenshot - iPhone 11 - 2025-01-17 at 14 44 54](https://github.com/user-attachments/assets/28ffc00b-fdcc-401a-93c7-7b695228f7d2)




## App Layers

#### MVVM Concepts
##### Presentation Logic
* `View` - Handles user interaction and displays data. For example, a PlanetsListView displays a list of planets and sends user actions (e.g., taps) to the ViewModel.
* `View Model` - Contains the presentation logic and transforms data from the UseCase into a format suitable for the View. It observes state changes and updates the View.
* `Router` - Manages navigation between views. For example, it determines how to navigate from a list of planets to a planet's detail view.

#### Clean Architecture Concepts
##### Application Logic

* `UseCase / Interactor` - Contains business rules and application logic. For example, a FetchPlanetsUseCase retrieves data from a repository and processes it.
* `Entity` - Core models representing the app's data. For example, the Planet struct holds attributes like name, gravity, and population.

##### Repository & Framework Logic

* `Repository` - Provides data from various sources, such as APIs or local databases. It acts as an abstraction layer, isolating data retrieval logic.
* `Persistence / API Entities` - Represents database models or API response objects that map to the app's Entity layer.
