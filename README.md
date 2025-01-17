# Planets
Planets is an application designed to share planets data.

## Architecture pattern
* MVVM(Model View ViewModel) + Clean Architecture concepts

## Run Requirements
* Minimum ios version: 15
* SwiftUI

## Installation 
* Clone this repo: <br/>
           `git clone `
* Open the terminal and navigate to the directory of project:  <br/>
           `cd Planets`
* Run this command to open the project directory: <br/>
          `open .`
* Open the workspace Planets.xcodeproj.
* Now you can run the project.








## App Layers

#### MVVM Concepts
##### Presentation Logic
* `View` - handle user interaction events to the `View Model` and displays data passed by the `Presenter`
* `View Model` - contains the presentation logic and tells the `View` what to present
* `Router` - contains navigation / flow logic from one scene (view controller) to another

#### Clean Architecture Concepts
##### Application Logic

* `UseCase / Interactor` - contains the application / business logic for a specific use case in your application
* `Entity` - plain `Swift` classes / structs

##### Repository & Framework Logic

* `Repository` - contains actual implementation of the protocols defined in the `Application Logic` layer
* `Persistence / API Entities` - contains framework specific representations
