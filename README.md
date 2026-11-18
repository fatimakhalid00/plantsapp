<img width="2400" height="1500" alt="fofo" src="https://github.com/user-attachments/assets/1bc7191f-6cbb-4f88-900e-fe2a024e984b" />

# 🌱 Planto

A simple iOS app that helps you remember to water your plants. Add a reminder for each plant, get a notification when it is time, and check plants off as you water them.

# ✨ Main Features

- Add a plant reminder with a name, room, light level, watering days and water amount
- Today Reminder list: tap a plant's circle to mark it as watered and watch the progress bar fill
- Edit a plant by tapping it, or delete it by swiping or with the Delete Reminder button
- Local notification reminders: "Hey! Let's water your plant!"

# 🏗️ Architecture (MVVM)

The app follows the MVVM design pattern to keep the code clean and organized.

- **Model:** `Plant` holds the plant data (name, room, light, watering days, water amount, and done state).
- **ViewModel:** `PlantsViewModel` holds the plants list and all the logic (add, edit, delete, mark as watered, and progress). `NotificationManager` schedules and cancels the watering reminders.
- **Views:** The screens only display data and call ViewModel functions. One shared ViewModel keeps all screens in sync.

# 🛠️ Technologies Used

- Swift
- SwiftUI
- MVVM architecture (Model, ViewModel, View) using `@Observable`
- UserNotifications for local reminders
- Xcode and iOS 26 (Liquid Glass buttons)
- Sketch for the UI design

# 👩🏻‍💻 Author

Made by **Fatima**


