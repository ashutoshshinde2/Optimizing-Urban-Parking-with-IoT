import streamlit as st
import mysql.connector
import folium
from streamlit_folium import st_folium

# Connect to MySQL
def get_connection():
    return mysql.connector.connect(
        host="18.223.180.12",
        user="root",
        password="Parking@123",
        database="SmartParkingSys"
    )

# Fetch parking data for the logged-in admin
def fetch_parkings(admin_id):
    conn = get_connection()
    cursor = conn.cursor(dictionary=True)
    query = "SELECT * FROM parkings WHERE admin_id = %s"
    cursor.execute(query, (admin_id,))
    parkings = cursor.fetchall()

    # Get available slots dynamically from parking_slots table
    for p in parkings:
        cursor.execute("""
            SELECT COUNT(*) FROM parking_slots 
            WHERE parking_id = %s AND status = 1 AND slot_number LIKE 'SLO%%'
        """, (p["parking_id"],))
        result = cursor.fetchone()
        p["available_slots"] = result["COUNT(*)"] if result else 0

    cursor.close()
    conn.close()
    return parkings

# Check login status
if "logged_in" not in st.session_state or not st.session_state.logged_in:
    st.warning("🔒 Please log in to view your dashboard.")
    st.stop()

admin = st.session_state.user
st.title("📍 Admin Parking Dashboard")
st.subheader(f"Welcome, {admin['first_name']} {admin['last_name']}")

# Get admin-specific parking data
parking_data = fetch_parkings(admin["user_id"])

if not parking_data:
    st.info("No parkings found for your account.")
    st.stop()

# Convert string latitude/longitude to float
for p in parking_data:
    p["latitude"] = float(p["latitude"])
    p["longitude"] = float(p["longitude"])

# Map display
st.subheader("🗺️ Parking Locations Map")

map_center = [parking_data[0]["latitude"], parking_data[0]["longitude"]]
map_obj = folium.Map(location=map_center, zoom_start=12)

for parking in parking_data:
    popup_info = f"{parking['address']} ({parking['available_slots']}/{parking['total_slots']} slots)"
    folium.Marker(
        location=[parking["latitude"], parking["longitude"]],
        popup=popup_info,
        tooltip=parking["address"]
    ).add_to(map_obj)

st_folium(map_obj, width=700, height=400)

# Show cards for each parking
st.subheader("📦 Parking Details")

for p in parking_data:
    with st.container(border=True):
        st.markdown(f"### 📍 {p['address']}")
        st.write(f"📱 **Mobile No:** {p['mobileno']}")
        st.write(f"🅿️ **Total Slots:** {p['total_slots']}")
        st.write(f"🟢 **Available Slots:** {p['available_slots']}")
        st.write(f"💰 **Price/Hour:** ₹{p['prising_per_hour']}")
        st.write(f"⭐ **Rating:** {p.get('ratings', 'N/A')}")
        st.write(f"📍 **Location:** ({p['latitude']}, {p['longitude']})")
