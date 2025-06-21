# Home.py

import streamlit as st
from auth import authenticate
from mqtt_qr_listener import run_listener

st.set_page_config(page_title="Smart Parking Login", layout="wide")

# Session state setup
if "logged_in" not in st.session_state:
    st.session_state.logged_in = False
if "user" not in st.session_state:
    st.session_state.user = None

st.title("🔐 Admin Login")

email = st.text_input("Email")
password = st.text_input("Password", type="password")

if st.button("Login"):
    user = authenticate(email, password)
    if user:
        st.session_state.logged_in = True
        st.session_state.user = user
        st.success("Login successful! Please open the Dashboard page from the sidebar.")
        run_listener()
    else:
        st.error("Invalid email or password.")
