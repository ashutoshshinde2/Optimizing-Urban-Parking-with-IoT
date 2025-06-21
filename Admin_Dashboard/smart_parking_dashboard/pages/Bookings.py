import streamlit as st
import mysql.connector
import pandas as pd
from datetime import datetime

if "logged_in" not in st.session_state or not st.session_state.logged_in:
    st.warning("🔒 Please log in to view your dashboard.")
    st.stop()

st.title("📖 All Bookings")

# MySQL connection
def get_connection():
    return mysql.connector.connect(
        host="18.223.180.12",
        user="root",
        password="Parking@123",
        database="SmartParkingSys"
    )

# Search input
search_query = st.text_input("🔍 Search by name, parking address, or status")

# Fetch booking data
conn = get_connection()
cursor = conn.cursor(dictionary=True)

# Booking and payment details
cursor.execute("""
    SELECT b.booking_id, u.first_name, u.last_name, p.address, b.start_time, b.end_time, b.status AS booking_status,
           pm.payment_id, pm.amount, pm.payment_method, pm.payment_time
    FROM bookings b
    JOIN users u ON b.user_id = u.user_id
    JOIN parkings p ON b.parking_id = p.parking_id
    LEFT JOIN payments pm ON b.booking_id = pm.booking_id AND pm.status = 'completed'
    WHERE p.admin_id = %s
    ORDER BY b.booking_id DESC
""", (st.session_state.user['user_id'],))
bookings = cursor.fetchall()

# Past month booking count and earnings
cursor.execute("""
    SELECT COUNT(*) AS count, IFNULL(SUM(pm.amount), 0) AS earnings
    FROM bookings b
    JOIN parkings p ON b.parking_id = p.parking_id
    LEFT JOIN payments pm ON b.booking_id = pm.booking_id AND pm.status = 'completed'
    WHERE MONTH(b.booking_time) = MONTH(CURRENT_DATE - INTERVAL 1 MONTH) AND p.admin_id = %s
""", (st.session_state.user['user_id'],))
past = cursor.fetchone()

# Current month booking count and earnings
cursor.execute("""
    SELECT COUNT(*) AS count, IFNULL(SUM(pm.amount), 0) AS earnings
    FROM bookings b
    JOIN parkings p ON b.parking_id = p.parking_id
    LEFT JOIN payments pm ON b.booking_id = pm.booking_id AND pm.status = 'completed'
    WHERE MONTH(b.booking_time) = MONTH(CURRENT_DATE) AND p.admin_id = %s
""", (st.session_state.user['user_id'],))
current = cursor.fetchone()

cursor.close()
conn.close()

# Show metrics
col1, col2 = st.columns(2)
col1.metric("📆 Past Month Bookings", past['count'])
col1.metric("💵 Past Month Earnings (₹)", past['earnings'])
col2.metric("📆 Current Month Bookings", current['count'])
col2.metric("💵 Current Month Earnings (₹)", current['earnings'])

# Convert to DataFrame
df = pd.DataFrame(bookings)
df['Name'] = df['first_name'] + ' ' + df['last_name']
df.drop(columns=['first_name', 'last_name'], inplace=True)

# Filter results
if search_query:
    df = df[df.apply(lambda row: search_query.lower() in str(row['Name']).lower() 
                                  or search_query.lower() in str(row['address']).lower() 
                                  or search_query.lower() in str(row['booking_status']).lower(), axis=1)]

# Display results
if not df.empty:
    df.rename(columns={
        'booking_id': 'Booking ID',
        'address': 'Parking Address',
        'start_time': 'Start Time',
        'end_time': 'End Time',
        'booking_status': 'Booking Status',
        'payment_id': 'Payment ID',
        'amount': 'Amount Paid (₹)',
        'payment_method': 'Payment Method',
        'payment_time': 'Payment Time'
    }, inplace=True)
    st.dataframe(df, use_container_width=True)
else:
    st.info("No bookings match your search.")
