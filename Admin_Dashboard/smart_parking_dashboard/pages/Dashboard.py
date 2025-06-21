import streamlit as st
import mysql.connector
import pandas as pd
from datetime import datetime
import plotly.express as px
import plotly.graph_objects as go

# Check login status
if "logged_in" not in st.session_state or not st.session_state.logged_in:
    st.warning("🔒 Please log in to view your dashboard.")
    st.stop()

admin = st.session_state.user
st.title("📊 Admin Dashboard")
st.subheader(f"Welcome, {admin['first_name']} {admin['last_name']}")

# MySQL connection
def get_connection():
    return mysql.connector.connect(
        host="18.223.180.12",
        user="root",
        password="Parking@123",
        database="SmartParkingSys"
    )

# Fetch data
conn = get_connection()
cursor = conn.cursor(dictionary=True)

# Queries
cursor.execute("SELECT COUNT(*) as count FROM parkings WHERE admin_id = %s", (admin['user_id'],))
parking_count = cursor.fetchone()['count']

cursor.execute("""
    SELECT COUNT(*) as bookings FROM bookings b
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE DATE(b.booking_time) = CURDATE() AND p.admin_id = %s
""", (admin['user_id'],))
todays_bookings = cursor.fetchone()['bookings']

cursor.execute("""
    SELECT IFNULL(SUM(pm.amount), 0) as earnings FROM payments pm
    JOIN bookings b ON pm.booking_id = b.booking_id
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE DATE(pm.payment_time) = CURDATE() AND p.admin_id = %s AND pm.status = 'completed'
""", (admin['user_id'],))
todays_earnings = cursor.fetchone()['earnings']

cursor.execute("""
    SELECT MONTH(pm.payment_time) as month, SUM(pm.amount) as earnings
    FROM payments pm
    JOIN bookings b ON pm.booking_id = b.booking_id
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE p.admin_id = %s AND pm.status = 'completed'
    GROUP BY MONTH(pm.payment_time)
    ORDER BY month
""", (admin['user_id'],))
monthly_earnings = cursor.fetchall()

cursor.execute("""
    SELECT status, COUNT(*) as count FROM bookings b
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE p.admin_id = %s
    GROUP BY status
""", (admin['user_id'],))
booking_status_data = cursor.fetchall()

cursor.execute("""
    SELECT b.booking_id, u.first_name, u.last_name, b.start_time, b.end_time FROM bookings b
    JOIN users u ON b.user_id = u.user_id
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE b.start_time > NOW() AND p.admin_id = %s
    ORDER BY b.start_time ASC
    LIMIT 5
""", (admin['user_id'],))
upcoming_bookings = cursor.fetchall()

cursor.execute("""
    SELECT u.first_name, u.last_name, pm.amount, pm.payment_time FROM payments pm
    JOIN bookings b ON pm.booking_id = b.booking_id
    JOIN users u ON b.user_id = u.user_id
    JOIN parkings p ON b.parking_id = p.parking_id
    WHERE pm.status = 'completed' AND p.admin_id = %s
    ORDER BY pm.payment_time DESC
    LIMIT 5
""", (admin['user_id'],))
recent_payments = cursor.fetchall()

cursor.execute("""
    SELECT address, available_slots FROM parkings
    WHERE available_slots < 3 AND admin_id = %s
""", (admin['user_id'],))
low_slots = cursor.fetchall()

cursor.close()
conn.close()

# Layout Cards in Columns
st.markdown("""
<style>
.metric-box {
    background-color: #f0f2f6;
    padding: 15px;
    border-radius: 12px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.05);
    text-align: center;
    font-weight: bold;
}
</style>
""", unsafe_allow_html=True)

col1, col2, col3 = st.columns(3)
with col1:
    if st.button(f"🅿️\n**My Parkings ({parking_count})**", help="Click to view your parkings"):
        st.session_state.current_page = "parkings"
        st.experimental_rerun()
with col2:
    st.metric("📅 Today's Bookings", todays_bookings)
with col3:
    st.metric("💸 Today's Earnings (₹)", todays_earnings)

col4, col5 = st.columns(2)

with col4:
    st.subheader("📈 Monthly Earnings Overview")
    if monthly_earnings:
        df = pd.DataFrame(monthly_earnings)
        df['month'] = df['month'].apply(lambda x: datetime(1900, x, 1).strftime('%B'))
        fig = px.line(df, x='month', y='earnings', markers=True)
        st.plotly_chart(fig, use_container_width=True)
    else:
        st.info("📉 No earnings data available to display.")

with col5:
    st.subheader("📊 Booking Status Overview")
    if booking_status_data:
        df_status = pd.DataFrame(booking_status_data)
        fig2 = px.pie(df_status, names='status', values='count')
        st.plotly_chart(fig2, use_container_width=True)

col6, col7 = st.columns(2)

with col6:
    with st.expander("📅 View Upcoming Bookings", expanded=False):
        if upcoming_bookings:
            df_upcoming = pd.DataFrame(upcoming_bookings)
            df_upcoming.rename(columns={
                'first_name': 'First Name',
                'last_name': 'Last Name',
                'start_time': 'Start Time',
                'end_time': 'End Time'
            }, inplace=True)
            st.table(df_upcoming)
        else:
            st.info("No upcoming bookings found.")

with col7:
    with st.expander("💳 View Recent Payments", expanded=False):
        if recent_payments:
            df_recent = pd.DataFrame(recent_payments)
            df_recent.rename(columns={
                'first_name': 'First Name',
                'last_name': 'Last Name',
                'amount': 'Amount',
                'payment_time': 'Payment Time'
            }, inplace=True)
            st.table(df_recent)
        else:
            st.info("No recent payments available.")

st.markdown("---")

with st.expander("⚠️ Low Slot Availability Alerts", expanded=False):
    if low_slots:
        for slot in low_slots:
            st.error(f"{slot['address']} — Only {slot['available_slots']} slots left!")
    else:
        st.success("All slots have sufficient availability.")
