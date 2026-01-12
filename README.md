# Wayza - Location Tracking App

Wayza is a mobile location tracking application that allows you to record and visualize your routes in real-time. Track your walks, runs, bike rides, or any journey and view them on an interactive map.

## Features

### 📍 Real-Time Location Tracking
- **Background tracking**: Continue recording your location even when the app is in the background
- **Customizable intervals**: Configure tracking frequency (time-based and distance-based)
- **High accuracy**: Uses GPS for precise location recording
- **Battery efficient**: Optimized tracking settings to balance accuracy and battery life

### 🗺️ Interactive Map Visualization
- **Route display**: View your recorded routes on an interactive map
- **Multiple map styles**: Switch between light and dark map themes
- **Route statistics**: See distance, duration, and coordinate count for each route
- **Auto-fit bounds**: Automatically zoom to show your entire route

### 📊 Route Management
- **Create routes**: Start new tracking sessions with custom names
- **Edit routes**: Rename your routes anytime
- **Delete routes**: Remove unwanted routes with confirmation
- **Continue routes**: Resume tracking on existing routes
- **Route list**: Browse all your saved routes with details

### 💾 Data Management
- **Local storage**: All data stored locally using SQLite database
- **Export data**: Export your routes and coordinates for backup or analysis
- **Import data**: Restore previously exported data
- **Clear data**: Remove all tracking data when needed

### 🎨 User Experience
- **Dark mode**: Full dark mode support with automatic theme switching
- **Modern UI**: Clean, intuitive interface with smooth animations
- **Haptic feedback**: Tactile responses for better interaction
- **Permission handling**: Clear permission requests with explanatory dialogs
- **Error handling**: Graceful error handling with user-friendly messages

### ⚙️ Customizable Settings
- **Tracking intervals**: Adjust time-based tracking (1-60 seconds)
- **Distance threshold**: Set minimum distance between points (1-100 meters)
- **Theme preferences**: Choose between light, dark, or system theme
- **Data management**: Easy access to export, import, and clear functions

## Technology Stack

- **React Native**: Cross-platform mobile development
- **MapLibre**: Open-source map rendering
- **SQLite**: Local database for coordinate storage
- **Expo**: Development and build tooling
- **TypeScript**: Type-safe code

## Getting Started

### Prerequisites
- Node.js (v18 or higher)
- npm or yarn
- Android Studio (for Android) or Xcode (for iOS)

### Installation

1. Install dependencies:

```bash
npm install
```

2. Run on Android:

```bash
npm run android
```

3. Run on iOS:

```bash
npm run ios
```

## Permissions

The app requires the following permissions:
- **Location (Always)**: To track your location in the background
- **Location (When In Use)**: To track your location when the app is open
- **Foreground Service**: To maintain tracking while the app is in the background (Android)

## Project Structure

```
├── app/                    # Main application screens
│   ├── index.tsx          # Home screen with route list
│   ├── tracking.tsx       # Active tracking screen
│   ├── map.tsx           # Route visualization screen
│   └── settings.tsx      # Settings and preferences
├── components/            # Reusable components
│   └── modals/           # Modal dialogs
├── lib/                  # Core functionality
│   └── database.ts       # SQLite database operations
├── contexts/             # React contexts
│   ├── ThemeContext.tsx  # Theme management
│   └── PermissionContext.tsx  # Permission handling
├── utils/                # Utility functions
└── constants/            # App constants and styles
```

## Database Schema

The app uses SQLite to store:
- **Routes**: Route metadata (name, creation date, last updated)
- **Coordinates**: GPS coordinates with timestamps
- **Settings**: User preferences and tracking configuration

## License

This project is private and proprietary.
