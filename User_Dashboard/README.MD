# 🚗 Smart Parking System - Slot Booking Web App

This is a web-based **Smart Parking Slot Booking System** built with **Django**, **Tailwind CSS**, **Alpine.js**, and **MySQL**. It allows users to search parking locations, view available parking slots, and book them in real-time.

---

## 📁 Project Structure

```bash

smartcarparking/
│
├── accounts/ # Django app
│ ├── migrations/
│ ├── templates/
│ │ └── accounts/
│ │ └── bookings/
│ │ ├── bookings.html
│ │ ├── availability.html
│ │ └── ...
│ ├── static/ # Static files (optional)
│ ├── models.py # Parking, User models
│ ├── views.py # Booking & Availability views
│ └── ...
├── smartcarparking/ # Project settings
├── manage.py
└── README.md

```

## ⚙️ Technologies Used

- **Backend**: Django (Python 3.10+)
- **Frontend**: Tailwind CSS, Alpine.js
- **Database**: MySQL Workbench
- **UI Tools**: Tailwind CDN, Popper.js (dropdowns), Alpine.js (reactivity)

---

## 🛠️ Features

- 🔒 Custom user authentication (no Django default auth)
- 📍 Location-based parking search
- 📸 Dynamic parking cards loaded from database
- 🕒 Slot booking with date/time and price calculation
- 📊 Admin-side parking management (Work in Progress)

---

## 💾 Setup Instructions

### 🔗 Prerequisites

- Python 3.10+
- pip (Python package manager)
- MySQL Server + Workbench
- Git


### ✅ Clone the Repository

```bash
git clone https://github.com/your-username/smart-parking-system.git
cd smart-parking-system
```


## 📁 Repository Structure

```bash
smartcarparking/
│
├── accounts/ # Django app
│ ├── migrations/
│ ├── templates/
│ │ └── accounts/
│ │ └── bookings/
│ │ ├── bookings.html
│ │ ├── availability.html
│ │ └── ...
│ ├── static/ # Static files (optional)
│ ├── models.py # Parking, User models
│ ├── views.py # Booking & Availability views
│ └── ...
├── smartcarparking/ # Project settings
├── manage.py
└── README.md

```

---


## 📦 Installation Guide

### 1. Arduino Code Setup

* Navigate to `Arduino_Code/`
* Open the `.ino` file in Arduino IDE
* Update Wi-Fi credentials and MQTT broker IP
* Upload to ESP32 board

### 2. Admin Dashboard (Streamlit)

* Go to `Admin_Dashboard/`
* Create a virtual environment and install requirements:

```bash
cd Admin_Dashboard
pip install -r requirements.txt
streamlit run dashboard.py
```

### 3. User Dashboard (Django) & Virtual Environment

* Navigate to `User_Dashboard/`
* Install Python requirements and run server:

```bash
python -m venv venv
source venv/bin/activate       # On Windows use: venv\Scripts\activate
pip install django mysqlclient   #for sql related queries install mysqlclient pip
cd User_Dashboard
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver
```

### 4. Database Setup

#### 🐧 MySQL Setup on Linux

```bash
sudo apt update
sudo apt install mysql-server
sudo systemctl start mysql
sudo mysql_secure_installation
```

#### 🗃️ Import Database Schema

* Log in to MySQL:

```bash
mysql -u root -p
```

* Create a new database:

```sql
CREATE DATABASE smart_parking;
USE smart_parking;
SOURCE SmartParkingSys.sql;
```


---

## 🔍 Key Features

### Admin Dashboard

* Monitor parking slots live on a map
* Control gate via MQTT
* Filter by location, availability, or admin ID
* Booking analytics & usage charts

### User Dashboard

* User login/registration
* View available slots
* Book a slot & receive QR code
* Check booking status/history

### Arduino System

* Detects car presence via IR sensors
* Sends status via MQTT
* Receives gate control commands
* Controls servo motor for gate opening/closing

---

## 🎥 Demo Video

> 🎬 Watch the full system demo on YouTube. This video demonstrates the full working of the Smart Parking System from device to dashboards. https://www.youtube.com/watch?v=gOFd1jHfPcI

---

## 🧑‍💼 Author

**Akshay Umbarge**
📧 [akshayumbarge6721@gmail.com](mailto:akshayumbarge6721@gmail.com)
🔗 [LinkedIn](https://in.linkedin.com/in/akshay-umbarge)

---


