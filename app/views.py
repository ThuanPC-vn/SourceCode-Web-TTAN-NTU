from django.shortcuts import render, redirect
from django.http import JsonResponse, HttpResponse
from .models import Product, Order, OrderItem
import json
from django.contrib.auth.forms import UserCreationForm
from .models import *
from django.contrib.auth import authenticate, login, logout
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .models import Customer
from django.shortcuts import render, get_object_or_404






def register(request):
    if request.method == "POST":
        form = CreateUserForm(request.POST)
        if form.is_valid():
            form.save()
            return redirect('login')  # Thay thế 'success_url' bằng URL thực tế của bạn
    else:
        form = CreateUserForm()
    
    context = {'form': form}
    return render(request, 'app/register.html', context)
def loginPage(request):
    if request.user.is_authenticated:
        return redirect('home')
    if request.method == "POST":
        username = request.POST.get('username')
        password = request.POST.get('password')
        user = authenticate(request, username=username, password=password)
        if user is not None:
            login(request, user)
            return redirect('home')
        else:
            messages.info(request, 'Username or password not correct')

    context = {}
    return render(request, 'app/login.html', context)
def cart(request):
    order = None
    items = []
    cartItems = 0  # Khởi tạo cartItems

    if request.user.is_authenticated:
        customer = request.user.customer
        orders = Order.objects.filter(customer=customer, complete=False)
        
        if orders.exists():
            # Sắp xếp các đơn hàng theo thời gian tạo
            order = orders.order_by('-date_order').first()
            cartItems = order.get_cart_items  # Truy cập thuộc tính
        else:
            # Tạo mới đơn hàng nếu không có đơn hàng chưa hoàn thành
            order = Order.objects.create(customer=customer, complete=False)
            cartItems = order.get_cart_items  # Truy cập thuộc tính
        
        items = order.orderitem_set.all()

    context = {'items': items, 'order': order, 'cartItems': cartItems}
    return render(request, 'app/cart.html', context)



def checkout(request):
    order = None
    items = []

    if request.user.is_authenticated:
        customer = request.user.customer
        orders = Order.objects.filter(customer=customer, complete=False)

        if orders.exists():
            order = orders.order_by('-date_order').first()
            cartItems = order.get_cart_items
        else:
            order = Order.objects.create(customer=customer, complete=False)
            cartItems = order.get_cart_items

        items = order.orderitem_set.all()

        if request.method == "POST":
            address = request.POST.get('address')
            city = request.POST.get('city')
            state = request.POST.get('state')
            zipcode = request.POST.get('zipcode')
            country = request.POST.get('country')

            shipping_address = ShippingAddress.objects.create(
                customer=customer,
                order=order,
                address=address,
                city=city,
                state=state,
                zipcode=zipcode,
                country=country
            )

            order.complete = True
            order.save()

            return redirect('success')  # Chuyển hướng tới trang thành công

    context = {'items': items, 'order': order, 'cartItems': cartItems}
    return render(request, 'app/checkout.html', context)   

def updateItem(request):
    if request.method == 'POST':
        data = json.loads(request.body.decode('utf-8'))  # Decode request body to JSON
        productId = data.get('productId')
        action = data.get('action')

        if productId is not None and action is not None:
            try:
                product = Product.objects.get(id=productId)
                customer = request.user.customer  # Assuming user is authenticated
                order, created = Order.objects.get_or_create(customer=customer, complete=False)

                order_item, created = OrderItem.objects.get_or_create(order=order, product=product)

                if action == 'add':
                    order_item.quantity += 1
                elif action == 'remove':
                    order_item.quantity -= 1

                if order_item.quantity <= 0:
                    order_item.delete()
                else:
                    order_item.save()

                # Calculate updated cart items and total
                cart_items = order.get_cart_items
                cart_total = order.get_cart_total

                # Return JSON response with updated cart data
                return JsonResponse({'cart_items': cart_items, 'cart_total': cart_total})

            except Product.DoesNotExist:
                return JsonResponse({'error': 'Product not found'}, status=404)

        else:
            return JsonResponse({'error': 'Invalid data received'}, status=400)

    else:
        return JsonResponse({'error': 'Invalid request method'}, status=405)
    

from django.shortcuts import render
from .models import Product, Order

def home(request):
    cartItems = 0
    order = None
    items = []

    if request.user.is_authenticated:
        try:
            customer = request.user.customer
        except Customer.DoesNotExist:
            customer = Customer.objects.create(user=request.user)

        orders = Order.objects.filter(customer=customer, complete=False)

        if orders.exists():
            order = orders.order_by('-date_order').first()
            cartItems = order.get_cart_items
        else:
            order = Order.objects.create(customer=customer, complete=False)
            cartItems = order.get_cart_items

        items = order.orderitem_set.all()

    # Lấy danh sách sản phẩm
    products = Product.objects.all()

    # Lọc sản phẩm theo hãng nếu có yêu cầu
    manufacturer_filter = request.GET.get('manufacturer', None)
    if manufacturer_filter:
        products = products.filter(manufacturer__name=manufacturer_filter)

    context = {
        'products': products,
        'cartItems': cartItems
    }

    return render(request, 'app/home.html', context)



def logoutPage(request):
    logout(request)
    return redirect('home')


def success(request):
    return render(request, 'app/success.html')



from django.shortcuts import render
from .models import Product

def search(request):
    searched = ""
    keys = []
    cartItems = 0
    order = None
    items = []

    if request.method == "POST":
        searched = request.POST.get("searched", "")
        keys = Product.objects.filter(name__icontains=searched)
    if request.user.is_authenticated:
        try:
            customer = request.user.customer
        except Customer.DoesNotExist:
            customer = Customer.objects.create(user=request.user)

        orders = Order.objects.filter(customer=customer, complete=False)

        if orders.exists():
            order = orders.order_by('-date_order').first()
            cartItems = order.get_cart_items
        else:
            order = Order.objects.create(customer=customer, complete=False)
            cartItems = order.get_cart_items

        items = order.orderitem_set.all()

    # Lấy danh sách sản phẩm
    products = Product.objects.all()

   
    return render(request, 'app/search.html', {"searched": searched, "keys": keys, 'products': products, 'cartItems': cartItems})



def product_detail(request, product_id):
    product = get_object_or_404(Product, pk=product_id)
    
    try:
        pc_detail = PCDetail.objects.get(product=product)
    except PCDetail.DoesNotExist:
        pc_detail = None
    
    context = {
        'product': product,
        'pc_detail': pc_detail,
    }
    return render(request, 'app/product_detail.html', context)