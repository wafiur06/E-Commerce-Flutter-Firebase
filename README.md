# 🛒 E-Commerce App Flutter Firebase Firestore

A modern, full-featured E-Commerce application built with **Flutter** and **Firebase**. This project demonstrates a complete shopping workflow, from product discovery to secure checkout.

## 🚀 Features

* **User Authentication:** Secure Sign Up, Login, and Logout using Firebase Authentication (Email/Password).
* **Product Management:** Real-time product listing and category filtering powered by Cloud Firestore.
* **Shopping Cart:** Add, remove, and update item quantities with real-time price calculations.
* **Wishlist:** Save favorite items for future purchases.
* **Search Functionality:** Quickly find products using a dedicated search bar.
* **Order History:** Track previous purchases and order status.
* **Profile Management:** Update user details and delivery addresses.
* **Image Hosting:** Product images stored and retrieved via Firebase Storage.

---

## 🛠️ Tech Stack

* **Frontend:** [Flutter](https://flutter.dev/) (Framework) / [Dart](https://dart.dev/) (Language)
* **Backend:** [Firebase](https://firebase.google.com/)
    * **Authentication:** For user identity management.
    * **Cloud Firestore:** NoSQL database for products and user data.
    * **Firebase Storage:** For high-quality product images.
* **State Management:** Provider / BLoC / GetX (as implemented)

---

## 🏗️ Architecture & Workflow

The app follows a modular architecture to ensure scalability:

1.  **UI Layer:** Clean and responsive Material Design components.
2.  **Logic Layer:** State management handles the interaction between the UI and Data layers.
3.  **Data Layer:** Services communicate with Firebase for real-time synchronization.

**Workflow:**
* **Authentication:** User authenticates -> Access Token stored -> Redirect to Home.
* **Product Flow:** Firestore Streams -> UI Updates -> User adds to Cart.
* **Checkout:** Cart Data -> Order Collection Creation -> Clear Cart.

---

## ⚙️ Installation & Setup

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/wafiur06/E-Commerce-Flutter-Firebase.git](https://github.com/wafiur06/E-Commerce-Flutter-Firebase.git)
    cd E-Commerce-Flutter-Firebase
    ```

2.  **Install Dependencies:**
    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration:**
    * Create a new project on the [Firebase Console](https://console.firebase.google.com/).
    * Add Android/iOS apps to the project.
    * Download `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
    * Place them in the respective `android/app/` or `ios/Runner/` directories.

4.  **Run the App:**
    ```bash
    flutter run
    ```


## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
