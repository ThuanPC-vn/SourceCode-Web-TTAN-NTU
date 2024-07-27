var updateBtns = document.getElementsByClassName('update-cart');

for (var i = 0; i < updateBtns.length; i++) {
    updateBtns[i].addEventListener('click', function() {
        var productId = this.dataset.product;
        var action = this.dataset.action;
        console.log('productId:', productId, 'action:', action);
        console.log('user:', user);

        if (user === "AnonymousUser") {
            console.log('User is not authenticated');
            updateUserOrder(productId, action); // Handle non-authenticated user actions
        } else {
            updateOrder(productId, action); // Handle authenticated user actions
        }
    });
}

function updateUserOrder(productId, action) {
    // Implement handling for non-authenticated user (e.g., store in localStorage)
    console.log('Handle update for non-authenticated user');
    // Example: Save to localStorage
    var cart = JSON.parse(localStorage.getItem('cart')) || {};
    if (action === 'add') {
        cart[productId] = (cart[productId] || 0) + 1;
    } else if (action === 'remove') {
        if (cart[productId]) {
            cart[productId] -= 1;
            if (cart[productId] <= 0) {
                delete cart[productId];
            }
        }
    }
    localStorage.setItem('cart', JSON.stringify(cart));
}

function updateOrder(productId, action) {
    console.log('User is authenticated, sending data...');

    var url = '/update_item/';

    fetch(url, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'X-CSRFToken': csrftoken  // Include CSRF token for security
        },
        body: JSON.stringify({'productId': productId, 'action': action})
    })
    .then(response => response.json())
    .then(data => {
        console.log('Server response:', data);
        location.reload(); // Reload page after successful update
    })
    .catch(error => {
        console.error('Error:', error);
    });
}

