# Recipe App - Flutter
Flutter Application Recipe App built with Bloc, Dio, Clean Architecture, Secure Storage, Token Refresh, and Offline-First caching.

This project demonstrates real-world Flutter development practices including authentication, API integration, state management, token handling, and local caching.

# App ID and Password
id: emilys,
Password: emilyspass

# Features
## Authentication
Log in with username/password  
Secure token storage  
Persistent login session  
Auto login after app restart  
Logout functionality  
Access token management  
Refresh token mechanism  

## Recipe Module
Fetch recipes from API  
Recipe list/grid view  
Recipe detail screen 
Pull-to-refresh  
Loading state  
Error state  
Empty state  

## Offline First
Cache recipes locally  
Load cached data without internet  
Background API synchronization  
Instant app loading experience 

## Security
Tokens stored using flutter_secure_storage  
No hardcoded tokens  
Dio interceptor for authentication  
Automatic token refresh  

# Architecture
The project follows Feature Based Clean Architecture.

# Packages Used
flutter_bloc: State management,
dio: API communication,
flutter_secure_storage: Secure token storage,
shared_preferences: Offline cache,
equatable: Bloc state comparison,
logger: API logging.

# APIs Used
Authentication:
https://dummyjson.com/auth

Recipes:
https://dummyjson.com/recipes

# Scan QR for the Mobile application in Browser Emulators

<img width="311" height="297" alt="image" src="https://github.com/user-attachments/assets/89eae130-a445-4934-a49d-d9979df56097" />

