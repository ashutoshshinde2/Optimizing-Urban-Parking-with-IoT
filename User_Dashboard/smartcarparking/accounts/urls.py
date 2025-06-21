# accounts/urls.py
from django.urls import path
from .views import welcome_view, signup_view, login_view, logout_view, bookings_view;

urlpatterns = [
    
    path('signup/', signup_view, name='signup'),
    path('login/', login_view, name='login'),
    path('logout/', logout_view, name='logout'),
    path('bookings/', bookings_view, name='bookings'),  # must have this!
    # path('bookings/availability/', availability_view, name='availability'),
    # path('bookings/confirmation/', confirmation_view, name='confirmation'),
    # path('bookings/payment/', payment_view, name='payment'),
    # path('bookings/payment/success/', payment_success_view, name='payment_success'),
    # path('bookings/history/', bookings_history_view, name='bookings_history'),
    # path('gate/entry/', gate_entry_view, name='gate_entry'),
    path('', welcome_view, name='welcome'),
]