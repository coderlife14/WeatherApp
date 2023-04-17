# WeatherApp
Sample Weather App

App consists of 2 screens.
1. Home Screen where the weather data is displayed for the location.
    - Weather View Controller Presenter handles making the service call and parsing data for getting weather.

2. Search Results screen where user is displayed with the list of cities as he/she searches.
    - SearchResultsPresenter handles making service and parsing the data for list of cities.


- All the services are being made via "ServiceBuilder" class.

- WeatherView is the custom view created with autolayout for displaying the Weather Details.

- Utility
    - Constants : where constants are residing with API key, base url etc.
    - UIImageViewExtension is used for downloading image via URL
    - UIViewExtension : This is to pin any view inside a container view. Basically adding constraints for left | right | top | bottom.
    
- Model
    1. Weather : WeatherData model is the main which gets all the response from the weather details.
    2. Location : model is used to map the response for the array of locations that is returned when searching any city.
    
    
    
    
TODO: Things i could do next.

1. Not 100% code coverage is done for Unit Tests. ( Added mainly the API key check and verify all the services)
2. UI - i only displayed few details like current Temp , Description , High, Low and Wind.
3. Optimizing Home Screen
    - Adding functinality for user to add more cities 
    - Adding Table for to list all the Cities user wants to add.
    - Add Details screen for City. ( When user taps on any city, it goes to next screen and fetch all the weather details and display)
        - Details Screen : We can use the 5 day forecast API for the city and display details.
5. Adding proper documentation.
6. Handling Location Manager if user selects "Don't Allow" then provide the prompt again to enable it via Settings.
7. Adding core data for storage.

 
