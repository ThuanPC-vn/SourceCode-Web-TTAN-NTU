from django.db import models
from django.contrib.auth.models import User
from django.contrib.auth.forms import UserCreationForm
from django.shortcuts import render, redirect
from django.dispatch import receiver
from django.db.models.signals import post_save




#  CreateUserForm sử dụng tính của UserCreationForm của Django để lấy dữ liệu nhập
class CreateUserForm(UserCreationForm):
    class Meta:
        model = User
        fields = ['username', 'email', 'first_name', 'last_name', 'password1', 'password2']
    

class Customer(models.Model):
    id = models.AutoField(primary_key=True)
    user =  models.OneToOneField(User,on_delete=models.SET_NULL,null=True,blank=False)
    name = models.CharField(max_length=200,null=True)
    email = models.CharField(max_length=200,null=True)

    def __str__(self):
        if self.name:
            return self.name
        else:
            return "Unknown Customer" 
        





class Product(models.Model):
    id = models.AutoField(primary_key=True)
    name = models.CharField(max_length=200,null=True)
    manufacturer = models.CharField(max_length=50, null=True)
    price = models.FloatField()
    digital = models.BooleanField(default=False,null=True,blank=False)
    image = models.ImageField(null=True,blank=True)

    def __str__(self):
        return self.name
    @property
    def ImageURL(self):
        try:
            url =self.image.url
        except:
            url =''
        return url



    
class Order(models.Model):
    id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer,on_delete=models.SET_NULL,blank=True, null =True)
    date_order = models.DateTimeField(auto_now_add=True)
    complete = models.BooleanField(default=False,null=True,blank=False)
    trasaction_id =models.CharField(max_length=200,null=True)


    def __str__(self):
        if self.id is not None:
            return str(self.id)
        else:
            return "Không có ID"
    

    @property
    def get_cart_items(self):
        orderitems = self.orderitem_set.all()
        total = sum([item.quantity for item in orderitems ])
        return total
    @property
    def get_cart_total(self):
        orderitems = self.orderitem_set.all()
        total = sum([item.get_total for item in orderitems ])
        return total


        
class OrderItem(models.Model):
    id = models.AutoField(primary_key=True)
    product = models.ForeignKey(Product,on_delete=models.SET_NULL,blank=True, null =True)
    order = models.ForeignKey(Order,on_delete=models.SET_NULL,blank=True, null =True)
    quantity = models.IntegerField(default=0,null=True,blank=True)
    date_added = models.DateTimeField(auto_now_add=True)
    @property
    def get_total(self):
        if self.product and self.product.price:
            total = self.product.price * self.quantity
        else:
            total = 0  # Hoặc giá trị mặc định khác nếu không có product hoặc price
        return total
    

    
class ShippingAddress(models.Model):
    id = models.AutoField(primary_key=True)
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, blank=True, null=True)
    order = models.ForeignKey(Order, on_delete=models.SET_NULL, blank=True, null=True)
    address = models.CharField(max_length=200, null=True)
    city = models.CharField(max_length=200, null=True)
    state = models.CharField(max_length=200, null=True)
    zipcode = models.CharField(max_length=200, null=True)
    country = models.CharField(max_length=200, null=True)
    date_added = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.address
    




class PCDetail(models.Model):
    product = models.OneToOneField(Product, on_delete=models.CASCADE, related_name='pc_detail')
    processor = models.CharField(max_length=100)
    ram = models.CharField(max_length=50)
    storage = models.CharField(max_length=100)
    graphics_card = models.CharField(max_length=100)
    operating_system = models.CharField(max_length=50)
    warranty = models.IntegerField(help_text='Warranty period in months')

    def __str__(self):
        return f"Details for {self.product.name}"

class Invoice(models.Model):
    id = models.AutoField(primary_key=True)
    order = models.OneToOneField(Order, on_delete=models.CASCADE)
    customer = models.ForeignKey(Customer, on_delete=models.SET_NULL, null=True)
    total_amount = models.FloatField(default=0)
    date_created = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Invoice #{self.id} - {self.date_created}"

    @property
    def total_items(self):
        return self.order.get_cart_items()

    @property
    def total_cost(self):
        return self.total_amount  # Điều chỉnh logic tính tổng tiền tùy theo yêu cầu của bạn

    class Meta:
        verbose_name = 'Invoice'
        verbose_name_plural = 'Invoices'