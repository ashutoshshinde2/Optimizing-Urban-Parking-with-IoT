# auth.py

import mysql.connector
import streamlit as st
import hashlib

def get_db_connection():
    """Connect to the SmartParkingSys database."""
    return mysql.connector.connect(
        host="18.223.180.12",
        user="root",
        password="Parking@123",
        database="SmartParkingSys"
    )

def hash_password(password):
    """Hash the password using SHA-256."""
    hashed = hashlib.sha256(password.encode()).hexdigest()
    print(f"[DEBUG] Input password hashed: {hashed}")
    return hashed

def authenticate(email, password):
    """
    Authenticate an admin by checking email and SHA-256 hashed password.
    Returns the admin's user data if valid, otherwise returns None.
    """
    try:
        print(f"[DEBUG] Attempting login for email: {email}")

        conn = get_db_connection()
        cursor = conn.cursor(dictionary=True)

        query = """
            SELECT * FROM users 
            WHERE email = %s AND user_type = 'admin'
        """
        cursor.execute(query, (email,))
        result = cursor.fetchone()

        cursor.close()
        conn.close()

        if result:
            print(f"[DEBUG] Admin user found: {result['email']}")
            hashed_input = hash_password(password)
            stored_hash = result["password"]
            print(f"[DEBUG] Stored password hash from DB: {stored_hash}")

            if hashed_input == stored_hash:
                print("[DEBUG] ✅ Password match. Authentication successful.")
                return result
            else:
                print("[DEBUG] ❌ Password mismatch.")
                return None
        else:
            print("[DEBUG] ❌ No admin found with that email.")
            return None

    except Exception as e:
        st.error(f"Database error: {e}")
        print(f"[ERROR] Database error: {e}")
        return None
