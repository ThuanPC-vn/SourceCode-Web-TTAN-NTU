from django.contrib import admin
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name='home'),
    path('cart/', views.cart, name="cart"),
    path('register/', views.register, name="register"),
    path('login/', views.loginPage, name="login"),
    path('logout/', views.logoutPage, name='logout'),
    path('checkout/', views.checkout, name="checkout"),
    path('update_item/', views.updateItem, name="update_item"),
    
    path('success/', views.success, name='success'), 
    path('search/', views.search, name='search'), 
    path('product/<int:product_id>/', views.product_detail, name='product_detail'),


]
