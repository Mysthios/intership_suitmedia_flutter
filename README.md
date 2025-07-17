# intership_suitmedia_flutter

A Flutter application that checks for palindromes, displays user information, and fetches user data from an API. The app uses Provider for state management and features a clean, responsive UI with three main screens.

Features
First Screen: Input name and check if a sentence is a palindrome with a pop-up result.
Second Screen: Displays the entered name and selected user name, with navigation to choose a user.
Third Screen: Fetches and displays a list of users from the Reqres API, supports pull-to-refresh and infinite scrolling.
State Management: Uses Provider to manage app state, including user data and loading status.
UI: Custom background image, Poppins font, and responsive design with Material components.
Dependencies
provider: For state management.
http: For API requests.
pull_to_refresh: For pull-to-refresh functionality.
How to Run
Clone the repository.
Run flutter pub get to install dependencies.
Ensure the assets/Background.png file is added to the project.
Run the app with flutter run.
API
Uses Reqres API to fetch user data.
Notes
Ensure an internet connection for API calls.
The app uses a custom background image (Background.png) in the assets folder.
