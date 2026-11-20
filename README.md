# To-Do App

A Flutter to-do app with per-user cloud tasks: sign in, plan your day on a calendar, and swipe tasks away. Arabic and English, light and dark.

## Features

- Email registration and login with Firebase Auth
- Add tasks with a date from a bottom sheet
- Calendar timeline to browse tasks by day
- Swipe a task to edit or delete it
- Edit screen for existing tasks
- Settings tab: language (Arabic / English) and theme, saved locally
- Tasks stored per user in Cloud Firestore
- Small touches: confetti and vibration feedback

## Tech Stack

- **Flutter / Dart**
- **Backend:** firebase_auth + cloud_firestore
- **State management:** provider
- **UI:** calendar_timeline, scroll_bottom_navigation_bar, flutter_slidable, loading_animation_widget, confetti, vibration
- **Localization:** flutter_localizations + intl (ar, en)

## Getting Started

The app needs Firebase config files from your own Firebase project, then:

```bash
flutter pub get
flutter run
```
