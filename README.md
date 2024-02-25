# Apple Shop
![mokcup](assets/mockup.png)

## Overview 
This is an enormous online shop project designed for apple products. It fetches data from API and lists all different types of categories, Products and more. Each product has a detail screen to show the product's all specifications, Comments, Gallery, Description, Price and even all the variants. Each of these products could be added to shopping cart and Hive database is responsible for storing all the user's prefrences. User can also log in or sign up to his/her account and will be able to comment by his/her specific id. User is also gonna have the ablity to be directed to payment section.

## Features 
 - **Main Activity** : Works just like an online shop with different types of categories and products.
 - **Product Detail** : Each product has gallery, specification, description, comment section and variants.
 - **Shopping Cart** : each product can be added to this section. the total price is calculated and can direct user to payment section.
 - **Authentication** : User can also choose to log in or sign up at first in the application tpo recieve a unique token to have access to application.
 - **Other Features** : User can also choose to log out, Check different types of categories and more.
   

## Project Structure 
The project follows bloc architecture for the separation of layers to keep everything clean:

 - BLoC : To handle the logic and send different states for the unique event being received.
 - Data : To handle 3 important layers when working with API :
   - Model : which is the entity of the app and there are 10 different models.
   - DataSource : To keep a list of API models rquested before and also store user prefrences with hive database (works just like usecases).
   - Repositoy : To get data from datasource and handle whether an error occurred or the list has been taken (similar to adapter layer).
 - UI : Infrastructure layer that is aware of the bloc and can send certain events to it.

## Depandancies 
  - loading_indicator (loading animation)
  - dotted_line 
  - just_the_tooltip 
  - intl
  - lottie (for animations)
  - cached_network_image (to store all the pictures)
  - smooth_page_indicator
  - zarinpal
  - uni_links
  - url_launcher
  - get_it
  - shared_preferences
  - bloc
  - flutter_bloc
  - dartz
  - dio

  
## Project Setup
To run the application do the following :

 1. Clone the repository or download it.
 2. Open the project in Android Studio / VScode.
 3. Build and run the app on an Android emulator or physical device by your choice.
