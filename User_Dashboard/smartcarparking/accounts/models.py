from django.db import models

# models.py

# class Booking(models.Model):
#     booking_id = models.AutoField(primary_key=True)
#     user_id = models.IntegerField()
#     parking_id = models.IntegerField()
#     booking_time = models.DateTimeField()
#     start_time = models.DateTimeField()
#     end_time = models.DateTimeField()
#     status = models.CharField(max_length=20)
#     checkin_time = models.DateTimeField(null=True, blank=True)
#     checkout_time = models.DateTimeField(null=True, blank=True)

#     class Meta:
#         managed = False
#         db_table = 'bookings'

# class Payment(models.Model):
#     payment_id = models.AutoField(primary_key=True)
#     booking_id = models.IntegerField()
#     amount = models.DecimalField(max_digits=10, decimal_places=2)
#     payment_method = models.CharField(max_length=50)
#     status = models.CharField(max_length=20)
#     payment_time = models.DateTimeField()

#     class Meta:
#         managed = False
#         db_table = 'payments'

# class ParkingSlot(models.Model):
#     parking_id = models.IntegerField(primary_key=True)
#     slot_number = models.CharField(max_length=50)
#     status = models.IntegerField()
#     last_updated = models.DateTimeField()

#     class Meta:
#         managed = False
#         db_table = 'parking_slots'