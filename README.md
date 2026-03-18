# SkyPeek

> A beautiful weather app with hourly forecasts, severe weather alerts, and interactive radar maps.

---

## Overview

SkyPeek is a React Native weather app that delivers clean, accurate weather data for any location. Users see current conditions, hourly and 7-day forecasts, rainfall and UV index, and a live radar map — with push alerts for severe weather in saved locations.

---

## Problem

Stock weather apps on phones are functional but uninspiring, and third-party options are often cluttered with ads, require accounts for basic features, or bury the detailed data (hourly breakdowns, UV, air quality) behind paywalls or confusing UIs.

---

## Solution

SkyPeek surfaces rich weather data in an elegant, fast mobile UI. It uses the OpenWeatherMap API for live data, caches forecasts locally for offline viewing, and sends push alerts for thunderstorms, frost, or high UV without requiring the app to be open.

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | React Native 0.74 (TypeScript) + Expo SDK 51 |
| Weather API | OpenWeatherMap One Call API 3.0 |
| Geocoding | OpenWeatherMap Geocoding API |
| Maps | react-native-maps + OpenWeatherMap tile layer |
| Notifications | Expo Notifications (scheduled + push) |
| Local Cache | AsyncStorage + MMKV |
| Location | expo-location |
| Navigation | Expo Router v3 |
| Charts | Victory Native XL |
| UI | NativeWind |
| Background Refresh | Expo Background Fetch |

---

## Features

**Core**
- Current conditions: temperature, feels like, humidity, wind speed/direction, pressure, visibility
- Hourly forecast: 48-hour breakdown with temperature and precipitation probability per hour
- 7-day forecast with daily high/low, weather description, sunrise/sunset times
- UV index with safety rating and exposure recommendations
- Air quality index (AQI) with PM2.5 and ozone breakdown
- Moon phase indicator

**Backend & API Integration**
- OpenWeatherMap One Call API 3.0 fetches current + hourly + daily + air quality in a single request
- Geocoding API converts city name search to lat/lon for any saved location
- API key stored in Expo SecureStore, never bundled in plain config
- All API responses cached to MMKV (JSON) with a TTL of 30 minutes; stale data displayed immediately while a fresh fetch runs in background
- Expo Background Fetch task runs every 30 minutes (iOS permitted background time) to update alert-monitored locations without opening the app
- Expo Notifications: if the background fetch detects a thunderstorm, frost (<2°C), or UVI >8 for a user's saved location, it fires a local push notification
- No user account or backend server required — all logic runs on-device with OpenWeatherMap as the only external dependency

**Locations & Maps**
- Save up to 10 favourite locations with drag-to-reorder
- Auto-detect current location via expo-location with fallback to last known location offline
- Interactive radar map layer: OpenWeatherMap precipitation tile layer overlaid on react-native-maps
- Location search with debounced geocoding query and result list

**UX**
- Dynamic background gradient that shifts from midnight blue to amber based on time of day and conditions
- Weather condition animations (animated rain, sun rays, cloud drift) using React Native Animated API
- Temperature unit toggle (°C / °F) persisted in MMKV
- Swipe between saved locations on the home screen
- Widget-like compact view for home screen (Expo Widgets — planned)

**Offline**
- MMKV persisted cache serves full forecast data offline
- Stale indicator shown if data is older than TTL; explicit "Refresh" button always available

---

## Challenges

- Background Fetch on iOS is not guaranteed to run on schedule — alert notifications may be delayed on low-battery or restricted devices
- Merging the tile layer for radar precipitation onto react-native-maps without performance degradation on lower-end Android devices
- Animating weather backgrounds smoothly while rendering complex chart data simultaneously without frame drops

---

## Screenshots

_Current Conditions · Hourly Forecast · Radar Map · Saved Locations_
