from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.hashers import make_password, check_password
import mysql.connector
from django.http import HttpResponse
from datetime import datetime, timedelta
from django.contrib.auth.decorators import login_required
from django.contrib import messages

# Utility function to get database connection
def get_db_connection():
    return mysql.connector.connect(
        host="18.223.180.12",
        user="root",
        password="Parking@123",
        database="SmartParkingSys"
    )

# welcome Views
def welcome_view(request):
    return render(request, 'accounts/welcome.html')


def bookings_view(request):
    # Check authentication
    print(f"DEBUG: Redirecting to Redirected")

    if not request.session.get('user_id'):
        messages.error(request, "Please login to book parking")
        return redirect('login')

    # Handle form submission
    if request.method == "POST":
        try:
            location = request.POST.get('location', '').strip()
            vehicle_type = request.POST.get('vehicleType', 'Car')
            start_time = request.POST.get('startTime')
            end_time = request.POST.get('endTime')
            
            # Validate inputs
            if not all([location, start_time, end_time]):
                messages.error(request, "All fields are required")
                return render(request, "accounts/bookings/bookings.html")

            # Calculate duration and price
            start_dt = datetime.fromisoformat(start_time)
            end_dt = datetime.fromisoformat(end_time)
            duration_hours = (end_dt - start_dt).total_seconds() / 3600
            price = round(duration_hours * 30, 2)  # ₹30 per hour

            # Save booking to database
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
            
            cursor.execute("""
                INSERT INTO bookings 
                (user_id, location, vehicle_type, start_time, end_time, price, status)
                VALUES (%s, %s, %s, %s, %s, %s, 'pending')
            """, (
                request.session['user_id'],
                location,
                start_time,
                end_time,
                price
            ))
            
            booking_id = cursor.lastrowid
            conn.commit()
            
            # Get slot availability (matching your frontend data)
            if location.lower() == 'pune':
                cursor.execute("""
                    SELECT * FROM parking_slots 
                    WHERE location LIKE %s 
                    AND status = 'available'
                    LIMIT 3
                """, (f"%{location}%",))
                slots = cursor.fetchall()
            else:
                slots = []
            
            return render(request, "bookings/bookings.html", {
                'success': True,
                'price': price,
                'slots': slots or [
                    {
                        'name': 'Phoenix Marketcity Pune',
                        'image': 'Phoenix Marketcity.jpg',
                        'rating': '8 Km Away · ⭐ 4.8',
                        'address': 'Phoenix Marketcity, Viman Nagar, Pune, Maharashtra'
                    },
                    {
                        'name': 'Seasons Mall Pune',
                        'image': 'Seasons Mall.jpg',
                        'rating': '6 Km Away · ⭐ 4.5',
                        'address': 'Magarpatta, Hadapsar, Pune, Maharashtra'
                    }
                ]
            })

        except Exception as e:
            messages.error(request, f"Booking error: {str(e)}")
            return render(request, "bookings/bookings.html")

        finally:
            cursor.close()
            conn.close()

    # Default GET request
    return render(request, "accounts/bookings/bookings.html", {
        'user_full_name': request.session.get('full_name', 'Guest'),
        'user_email': request.session.get('email', 'guest@example.com')
    })

def signup_view(request):
    if request.method == "POST":
        # Get form data
        first_name = request.POST.get("first_name", "").strip()
        last_name = request.POST.get("last_name", "").strip()
        mobileno = request.POST.get("mobileno", "").strip()
        email = request.POST.get("email", "").strip().lower()
        password = request.POST.get("password", "")
        confirm_password = request.POST.get("confirm_password", "")

        # Validate inputs
        if not all([first_name, last_name, email, password, confirm_password]):
            messages.error(request, "All fields are required")
            return render(request, "accounts/signup.html")

        if password != confirm_password:
            messages.error(request, "Passwords do not match")
            return render(request, "accounts/signup.html")

        if len(password) < 8:
            messages.error(request, "Password must be at least 8 characters")
            return render(request, "accounts/signup.html")

        try:
            conn = get_db_connection()
            cursor = conn.cursor()

            # Check if email exists
            cursor.execute("SELECT email FROM users WHERE email = %s", (email,))
            if cursor.fetchone():
                messages.error(request, "Email already registered")
                return render(request, "accounts/signup.html")

            # Insert new user
            hashed_password = make_password(password)
            cursor.execute("""
                INSERT INTO users 
                (first_name, last_name, mobileno, email, password, user_type, timestamp)
                VALUES (%s, %s, %s, %s, %s, 'user', NOW())
            """, (first_name, last_name, mobileno, email, hashed_password))

            conn.commit()
            messages.success(request, "Registration successful! Please login")
            return redirect("login")

        except Exception as e:
            messages.error(request, f"Registration error: {str(e)}")
            return render(request, "accounts/signup.html")

        finally:
            cursor.close()
            conn.close()

    return render(request, "accounts/signup.html")


def login_view(request):
    if request.method == "POST":
        email = request.POST.get("email")
        password = request.POST.get("password")

        try:
            conn = get_db_connection()
            cursor = conn.cursor(dictionary=True)
            cursor.execute("SELECT * FROM users WHERE email = %s", (email,))
            user = cursor.fetchone()

            if user and check_password(password, user['password']):
                print("DEBUG: User authenticated successfully")  # Debug
                request.session['user_id'] = user['user_id']
                request.session['email'] = user['email']
                request.session['full_name'] = f"{user['first_name']} {user['last_name']}"
                
                # Debug session storage
                print(f"DEBUG: Session after login - {dict(request.session)}")
                from django.shortcuts import redirect
                return redirect('bookings')
            
            messages.error(request, "Invalid email or password")

        except Exception as e:
            messages.error(request, f"Login error: {str(e)}")
            print(f"ERROR: {str(e)}")  # Debug
            
        finally:
            cursor.close()
            conn.close()

    # Debug GET request
    print("DEBUG: Login page GET request")
    return render(request, "accounts/login.html")



def logout_view(request):
    logout(request)
    return redirect('login')  # Redirect to login page


