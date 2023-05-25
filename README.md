# GeeMobile_Task

## iOS App that displays a list of users where we can tap and go to user profile.The list of users is cached incase there is no internet.

#### How to install :
- Make sure you have Xcode 14.3 or above
- Open GeoMobileTask.xcodeproj
- Run project to simulator or real device using `cmd + R`


 #### Requirement:

- [x] First start of the app: With an existing internet connection the data is displayed in a list. The images are displayed and you can open a detail view. The detail view shows the same data as in the cell with a different layout.
- [x] Second start of the app with a switched off internet connection:  The app displays the saved data. The images are not displayed.

#### Solution:(video attached)
![contain](https://github.com/frodo10messi/GeeMobile_Task/assets/28492677/dcf652ee-5d64-488c-a7de-29109ea72b74)

![contain](https://github.com/frodo10messi/GeeMobile_Task/assets/28492677/17198b6d-4f51-4880-9825-58f6136306cf)

## App Architecture :

<img width="1025" alt="architecture_diagram" src="https://github.com/frodo10messi/GeeMobile_Task/assets/28492677/ea0a4bb3-b00f-4003-b3bb-479c3e3b408c">

I applied clean architecture in all my modules. you can see that the app is including the following modules:
 - API module
 - Cache module
 - Feature/Domain module
 - UI and Presentation module

For the ***API module*** I used **URLSession** to handle the HTTP calls, Of course, the app has been implemented in a way that we can use any framework or third parties like **Alamofire**.

For the ***Cache module*** I used **FileManager** to cache content, Of course, the app has been implemented in a way that we can use any framework or third parties like **Realm** or **CoreData**.

For the ***Presentation module*** I used **MVVM** Design pattern, and I've tried to decouple all my modules using protocols, so you can find that I hide the implementation details by using protocols. 

For the ***Feature/Domain module*** here the business logic or model for the feature is written which is completely agnostic of the presentation layer and the data layers(api/cache) .

Finally, I composed all the module inside the **RootView**.

#### Improvements and feedback:
- Unit Testing for entire app 
- add snapshot tests to test ui layout
- add dark mode (✓)
- improve UI for landscape(✓)
- adding refresh control for reloading(✓)
- adding retry incase of failure(✓)
- adding timestamp for user to know when the data was last updated.(✓)




 

 


 


 
