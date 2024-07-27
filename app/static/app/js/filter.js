// filter.js
function filterProducts(manufacturer) {
    let productItems = document.querySelectorAll('.item1'); // Sử dụng class item1 thay cho product-item
    
    productItems.forEach(item => {
        let itemManufacturer = item.getAttribute('data-manufacturer');
        
        if (manufacturer === '' || itemManufacturer === manufacturer) {
            item.style.display = 'block'; // Hiển thị sản phẩm
        } else {
            item.style.display = 'none'; // Ẩn sản phẩm
        }
    });
}
