


CREATE DATABASE BanPC5
use BanPC5


-- TABLE 1
CREATE TABLE manufacturerSQLSV (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(50) NOT NULL,
    address NVARCHAR(200) NULL,
    email NVARCHAR(254) NULL,
    website NVARCHAR(200) NULL
);

-- TABLE 2
CREATE TABLE productSQLSV (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(200) NOT NULL,
    price FLOAT NOT NULL,
    image NVARCHAR(100) NULL,
    manufacturer_id INT NOT NULL,  
    FOREIGN KEY (manufacturer_id) REFERENCES manufacturerSQLSV(id)
);

-- TABLE 3
CREATE TABLE customerSQLSV (
    id INT IDENTITY(1,1) PRIMARY KEY,  
    name NVARCHAR(200) NULL,           
    email NVARCHAR(200) NULL,          
    user_id INT NULL                   
);

-- TABLE 4
CREATE TABLE orderSQLSV (
    id INT IDENTITY(1,1) PRIMARY KEY,
    date_order DATETIMEOFFSET NOT NULL,
    complete BIT NULL,
    transaction_id NVARCHAR(200) NULL,
    customer_id INT NULL,
    FOREIGN KEY (customer_id) REFERENCES CustomerSQLSV(id)
);

-- TABLE 5
CREATE TABLE orderitemSQLSV (
    id INT IDENTITY(1,1) PRIMARY KEY,
    quantity INT NOT NULL,
    date_added DATETIMEOFFSET NOT NULL,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orderSQLSV(id),
    FOREIGN KEY (product_id) REFERENCES productSQLSV(id)
);

-- TABLE 6
CREATE TABLE invoiceSQLSV (
    id INT PRIMARY KEY IDENTITY(1,1),
    order_id INT NOT NULL,
    customer_id INT NULL,
    total_amount FLOAT NOT NULL DEFAULT 0,
    date_created DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(), 
    FOREIGN KEY (order_id) REFERENCES orderSQLSV (id) ON DELETE CASCADE,
    FOREIGN KEY (customer_id) REFERENCES customerSQLSV (id) ON DELETE SET NULL
);

-- TABLE 7
CREATE TABLE shippingaddressSQLSV (
    id INT PRIMARY KEY IDENTITY(1,1),
    customer_id INT NULL,
    order_id INT NULL,
    address NVARCHAR(200) NULL,
    city NVARCHAR(200) NULL,
    state NVARCHAR(200) NULL,
    zipcode NVARCHAR(200) NULL,
    country NVARCHAR(200) NULL,
    date_added DATETIMEOFFSET NOT NULL DEFAULT SYSDATETIMEOFFSET(),
    FOREIGN KEY (customer_id) REFERENCES customerSQLSV (id) ON DELETE SET NULL,
    FOREIGN KEY (order_id) REFERENCES orderSQLSV (id) ON DELETE SET NULL
);

-- TABLE 8
CREATE TABLE pcdetailSQLSV (
    id BIGINT PRIMARY KEY IDENTITY(1,1),
    processor NVARCHAR(100) NOT NULL,
    ram NVARCHAR(50) NOT NULL,
    storage NVARCHAR(100) NOT NULL,
    graphics_card NVARCHAR(100) NOT NULL,
    operating_system NVARCHAR(50) NOT NULL,
    warranty INT NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY (product_id) REFERENCES productSQLSV (id) ON DELETE CASCADE
);





-- INSERT DATA INTO TABLE
INSERT INTO manufacturerSQLSV (name, address, email, website)
VALUES
    (N'MSI', N'123 Đường A, Thành phố X', 'info@msi.com', 'www.msi.com'),
    (N'DELL', N'456 Đường B, Thành phố Y', 'info@dell.com', 'www.dell.com'),
    (N'HP', N'789 Đường C, Thành phố Z', 'info@hp.com', 'www.hp.com'),
    (N'Asus', N'321 Đường D, Thành phố W', 'info@asus.com', 'www.asus.com'),
    (N'Acer', N'654 Đường E, Thành phố V', 'info@acer.com', 'www.acer.com'),
    (N'Apple', N'987 Đường F, Thành phố U', 'info@apple.com', 'www.apple.com'),
    (N'Lenovo', N'654 Đường G, Thành phố T', 'info@lenovo.com', 'www.lenovo.com'),
    (N'Samsung', N'321 Đường H, Thành phố S', 'info@samsung.com', 'www.samsung.com'),
    (N'Toshiba', N'789 Đường I, Thành phố R', 'info@toshiba.com', 'www.toshiba.com'),
    (N'Sony', N'123 Đường K, Thành phố Q', 'info@sony.com', 'www.sony.com');

INSERT INTO productSQLSV (name, price, image, manufacturer_id)
VALUES
    (N'Laptop MSI A', 25000000.00, 'msi_laptop_a.jpg', 1),
    (N'Laptop MSI B', 28000000.00, 'msi_laptop_b.jpg', 1),
    (N'Laptop DELL X', 30000000.00, 'dell_laptop_x.jpg', 2),
    (N'Laptop DELL Y', 32000000.00, 'dell_laptop_y.jpg', 2),
    (N'Laptop HP Z', 27000000.00, 'hp_laptop_z.jpg', 3),
    (N'Laptop HP W', 29000000.00, 'hp_laptop_w.jpg', 3),
    (N'Laptop Asus S', 26000000.00, 'asus_laptop_s.jpg', 4),
    (N'Laptop Asus R', 28000000.00, 'asus_laptop_r.jpg', 4),
    (N'Laptop Acer Q', 24000000.00, 'acer_laptop_q.jpg', 5),
    (N'Laptop Acer P', 26000000.00, 'acer_laptop_p.jpg', 5);


INSERT INTO customerSQLSV (name, email, user_id)
VALUES
    (N'Khách hàng A', 'khachhangA@example.com', 1001),
    (N'Khách hàng B', 'khachhangB@example.com', 1002),
    (N'Khách hàng C', 'khachhangC@example.com', 1003),
    (N'Khách hàng D', 'khachhangD@example.com', 1004),
    (N'Khách hàng E', 'khachhangE@example.com', 1005),
    (N'Khách hàng F', 'khachhangF@example.com', 1006),
    (N'Khách hàng G', 'khachhangG@example.com', 1007),
    (N'Khách hàng H', 'khachhangH@example.com', 1008),
    (N'Khách hàng I', 'khachhangI@example.com', 1009),
    (N'Khách hàng J', 'khachhangJ@example.com', 1010);

INSERT INTO orderSQLSV (date_order, complete, transaction_id, customer_id)
VALUES
    ('2024-07-01 12:00:00', 1, 'TRANS001', 1),
    ('2024-07-02 13:00:00', 0, 'TRANS002', 2),
    ('2024-07-03 14:00:00', 1, 'TRANS003', 3),
    ('2024-07-04 15:00:00', 0, 'TRANS004', 4),
    ('2024-07-05 16:00:00', 1, 'TRANS005', 5),
    ('2024-07-06 17:00:00', 0, 'TRANS006', 6),
    ('2024-07-07 18:00:00', 1, 'TRANS007', 7),
    ('2024-07-08 19:00:00', 0, 'TRANS008', 8),
    ('2024-07-09 20:00:00', 1, 'TRANS009', 9),
    ('2024-07-10 21:00:00', 0, 'TRANS010', 10);


INSERT INTO orderitemSQLSV (quantity, date_added, order_id, product_id)
VALUES
    (2, '2024-07-01 12:05:00', 1, 1),
    (1, '2024-07-02 13:10:00', 2, 2),
    (3, '2024-07-03 14:15:00', 3, 3),
    (2, '2024-07-04 15:20:00', 4, 4),
    (1, '2024-07-05 16:25:00', 5, 5),
    (3, '2024-07-06 17:30:00', 6, 6),
    (2, '2024-07-07 18:35:00', 7, 7),
    (1, '2024-07-08 19:40:00', 8, 8),
    (3, '2024-07-09 20:45:00', 9, 9),
    (2, '2024-07-10 21:50:00', 10, 10);

INSERT INTO invoiceSQLSV (order_id, customer_id, total_amount, date_created)
VALUES
    (1, 1, 24000000.00, '2024-07-01 12:10:00'),
    (2, 2, 26000000.00, '2024-07-02 13:15:00'),
    (3, 3, 28000000.00, '2024-07-03 14:20:00'),
    (4, 4, 30000000.00, '2024-07-04 15:25:00'),
    (5, 5, 32000000.00, '2024-07-05 16:30:00'),
    (6, 6, 34000000.00, '2024-07-06 17:35:00'),
    (7, 7, 36000000.00, '2024-07-07 18:40:00'),
    (8, 8, 38000000.00, '2024-07-08 19:45:00'),
    (9, 9, 40000000.00, '2024-07-09 20:50:00'),
    (10, 10, 42000000.00, '2024-07-10 21:55:00');

INSERT INTO pcdetailSQLSV (processor, ram, storage, graphics_card, operating_system, warranty, product_id)
VALUES
    (N'Intel Core i5', N'8GB DDR4', N'512GB SSD', N'NVIDIA GTX 1650', N'Windows 10 Home', 12, 1),
    (N'Intel Core i7', N'16GB DDR4', N'1TB SSD', N'NVIDIA RTX 3060', N'Windows 10 Pro', 24, 2),
    (N'AMD Ryzen 5', N'12GB DDR4', N'256GB SSD + 1TB HDD', N'AMD Radeon RX 5500M', N'Windows 11 Home', 18, 3),
    (N'Intel Core i9', N'32GB DDR4', N'2TB SSD', N'NVIDIA RTX 3080', N'Windows 11 Pro', 36, 4),
    (N'Intel Core i5', N'8GB DDR4', N'512GB SSD', N'Intel UHD Graphics', N'Windows 10 Home', 12, 5),
    (N'AMD Ryzen 7', N'16GB DDR4', N'512GB SSD', N'NVIDIA GTX 1660 Ti', N'Windows 10 Pro', 24, 6),
    (N'Intel Core i7', N'16GB DDR4', N'1TB SSD', N'NVIDIA RTX 3070', N'Windows 11 Home', 18, 7),
    (N'Intel Core i9', N'64GB DDR4', N'4TB SSD', N'NVIDIA RTX 3090', N'Windows 11 Pro', 36, 8),
    (N'AMD Ryzen 5', N'12GB DDR4', N'1TB SSD', N'AMD Radeon RX 5600M', N'Windows 10 Home', 12, 9),
    (N'Intel Core i7', N'32GB DDR4', N'2TB SSD', N'NVIDIA GTX 1650 Ti', N'Windows 10 Pro', 24, 10);

INSERT INTO shippingaddressSQLSV (customer_id, order_id, address, city, state, zipcode, country, date_added)
VALUES
    (1, 1, N'123 Đường A', N'Hà Nội', N'Quận Hoàn Kiếm', '100000', N'Việt Nam', '2024-07-01 12:15:00'),
    (2, 2, N'456 Đường B', N'Thành phố Hồ Chí Minh', N'Quận 1', '700000', N'Việt Nam', '2024-07-02 13:20:00'),
    (3, 3, N'789 Đường C', N'Đà Nẵng', N'Quận Hải Châu', '550000', N'Việt Nam', '2024-07-03 14:25:00'),
    (4, 4, N'321 Đường D', N'Hải Phòng', N'Quận Hồng Bàng', '180000', N'Việt Nam', '2024-07-04 15:30:00'),
    (5, 5, N'654 Đường E', N'Cần Thơ', N'Quận Ninh Kiều', '900000', N'Việt Nam', '2024-07-05 16:35:00'),
    (6, 6, N'987 Đường F', N'Quảng Ninh', N'Thành phố Hạ Long', '200000', N'Việt Nam', '2024-07-06 17:40:00'),
    (7, 7, N'654 Đường G', N'Bắc Ninh', N'Thành phố Bắc Ninh', '160000', N'Việt Nam', '2024-07-07 18:45:00'),
    (8, 8, N'321 Đường H', N'Thái Bình', N'Thành phố Thái Bình', '320000', N'Việt Nam', '2024-07-08 19:50:00'),
    (9, 9, N'789 Đường I', N'Nam Định', N'Thành phố Nam Định', '420000', N'Việt Nam', '2024-07-09 20:55:00'),
    (10, 10, N'123 Đường K', N'Ninh Bình', N'Thành phố Ninh Bình', '430000', N'Việt Nam', '2024-07-10 21:00:00');








---Cau 3.a: Truy vấn đơn giản: 3 câu
---Truy vấn để lấy thông tin về tất cả các sản phẩm và nhà sản xuất của chúng:
SELECT p.id AS ProductID, p.name AS ProductName, p.price AS Price, m.name AS ManufacturerName
FROM productSQLSV p
JOIN manufacturerSQLSV m ON p.manufacturer_id = m.id;

 
---Truy vấn để lấy thông tin về tất cả các đơn hàng của một khách hàng cụ thể, dựa trên customer_id:
SELECT o.id AS OrderID, o.date_order AS OrderDate, o.complete AS IsComplete, o.transaction_id AS TransactionID
FROM orderSQLSV o
WHERE o.customer_id = 1;  -- Thay '1' bằng `customer_id` cụ thể mà bạn muốn truy vấn



---Truy vấn để lấy tất cả các sản phẩm trong một đơn hàng cụ thể, dựa trên order_id:
SELECT oi.id AS OrderItemID, oi.quantity AS Quantity, oi.date_added AS DateAdded, p.name AS ProductName
FROM orderitemSQLSV oi
JOIN productSQLSV p ON oi.product_id = p.id
WHERE oi.order_id = 1;  -- Thay '1' bằng `order_id` cụ thể mà bạn muốn truy vấn



---Cau 3.b:Truy vấn với Aggregate Functions: 7 câu 

--Tính tổng số lượng sản phẩm được bán trong tất cả các đơn hàng:
SELECT SUM(oi.quantity) AS TotalQuantitySold
FROM orderitemSQLSV oi;

--Tính tổng doanh thu từ tất cả các đơn hàng:
SELECT SUM(oi.quantity * p.price) AS TotalRevenue
FROM orderitemSQLSV oi
JOIN productSQLSV p ON oi.product_id = p.id;

--Tính giá trị trung bình của các đơn hàng:
SELECT AVG(total_amount) AS AverageOrderValue
FROM invoiceSQLSV;

--Đếm số lượng khách hàng đã đặt hàng:
SELECT COUNT(DISTINCT o.customer_id) AS TotalCustomersWithOrders
FROM orderSQLSV o;

--Tính số lượng đơn hàng hoàn thành và chưa hoàn thành:
SELECT complete, COUNT(*) AS NumberOfOrders
FROM orderSQLSV
GROUP BY complete;

--Tính tổng số tiền theo từng khách hàng:
SELECT c.id AS CustomerID, c.name AS CustomerName, SUM(i.total_amount) AS TotalSpent
FROM customerSQLSV c
JOIN invoiceSQLSV i ON c.id = i.customer_id
GROUP BY c.id, c.name;

---Tính số lượng sản phẩm của mỗi nhà sản xuất:
SELECT m.name AS ManufacturerName, COUNT(p.id) AS NumberOfProducts
FROM manufacturerSQLSV m
JOIN productSQLSV p ON m.id = p.manufacturer_id
GROUP BY m.name;




--Cau 3:

--Tính tổng doanh thu từ tất cả các đơn hàng và chỉ hiển thị các khách hàng đã chi tiêu trên 1,000 đơn vị tiền tệ:
SELECT c.id AS CustomerID, c.name AS CustomerName, SUM(i.total_amount) AS TotalSpent
FROM customerSQLSV c
JOIN invoiceSQLSV i ON c.id = i.customer_id
GROUP BY c.id, c.name
HAVING SUM(i.total_amount) > 1000;


--Tính số lượng sản phẩm của mỗi nhà sản xuất và chỉ hiển thị các nhà sản xuất có trên 5 sản phẩm:
SELECT m.name AS ManufacturerName, COUNT(p.id) AS NumberOfProducts
FROM manufacturerSQLSV m
JOIN productSQLSV p ON m.id = p.manufacturer_id
GROUP BY m.name
HAVING COUNT(p.id) > 5;


--Tính tổng số lượng sản phẩm được bán trong tất cả các đơn hàng và chỉ hiển thị các sản phẩm đã bán được trên 50 đơn vị:
SELECT p.name AS ProductName, SUM(oi.quantity) AS TotalQuantitySold
FROM orderitemSQLSV oi
JOIN productSQLSV p ON oi.product_id = p.id
GROUP BY p.name
HAVING SUM(oi.quantity) > 50;


--Tính giá trị trung bình của các đơn hàng theo ngày và chỉ hiển thị các ngày có giá trị trung bình đơn hàng trên 500 đơn vị tiền tệ:
SELECT CAST(o.date_order AS DATE) AS OrderDate, AVG(i.total_amount) AS AverageOrderValue
FROM orderSQLSV o
JOIN invoiceSQLSV i ON o.id = i.order_id
GROUP BY CAST(o.date_order AS DATE)
HAVING AVG(i.total_amount) > 500;


--Tính tổng số lượng đơn hàng của mỗi khách hàng và chỉ hiển thị các khách hàng có trên 10 đơn hàng:
SELECT c.id AS CustomerID, c.name AS CustomerName, COUNT(o.id) AS NumberOfOrders
FROM customerSQLSV c
JOIN orderSQLSV o ON c.id = o.customer_id
GROUP BY c.id, c.name
HAVING COUNT(o.id) > 10;


--cau 4:Truy vấn lớn nhất, nhỏ nhất: 3 câu

--Tìm sản phẩm có giá cao nhất và giá thấp nhất:
-- Sản phẩm có giá cao nhất
SELECT TOP 1 p.id AS ProductID, p.name AS ProductName, p.price AS Price
FROM productSQLSV p
ORDER BY p.price DESC;

-- Sản phẩm có giá thấp nhất
SELECT TOP 1 p.id AS ProductID, p.name AS ProductName, p.price AS Price
FROM productSQLSV p
ORDER BY p.price ASC;

--Tìm đơn hàng có tổng giá trị cao nhất và thấp nhất:
-- Đơn hàng có tổng giá trị cao nhất
SELECT TOP 1 o.id AS OrderID, SUM(oi.quantity * p.price) AS TotalOrderValue
FROM orderSQLSV o
JOIN orderitemSQLSV oi ON o.id = oi.order_id
JOIN productSQLSV p ON oi.product_id = p.id
GROUP BY o.id
ORDER BY TotalOrderValue DESC;

-- Đơn hàng có tổng giá trị thấp nhất
SELECT TOP 1 o.id AS OrderID, SUM(oi.quantity * p.price) AS TotalOrderValue
FROM orderSQLSV o
JOIN orderitemSQLSV oi ON o.id = oi.order_id
JOIN productSQLSV p ON oi.product_id = p.id
GROUP BY o.id
ORDER BY TotalOrderValue ASC;


--Tìm khách hàng có tổng chi tiêu cao nhất và thấp nhất:
-- Khách hàng có tổng chi tiêu cao nhất
SELECT TOP 1 c.id AS CustomerID, c.name AS CustomerName, SUM(i.total_amount) AS TotalSpent
FROM customerSQLSV c
JOIN invoiceSQLSV i ON c.id = i.customer_id
GROUP BY c.id, c.name
ORDER BY TotalSpent DESC;

-- Khách hàng có tổng chi tiêu thấp nhất
SELECT TOP 1 c.id AS CustomerID, c.name AS CustomerName, SUM(i.total_amount) AS TotalSpent
FROM customerSQLSV c
JOIN invoiceSQLSV i ON c.id = i.customer_id
GROUP BY c.id, c.name
ORDER BY TotalSpent ASC;

---Cau 5:Truy vấn Không/chưa có: (Not In và left/right join): 7 câu
--Tìm sản phẩm chưa có đơn hàng nào:
SELECT p.id AS ProductID, p.name AS ProductName
FROM productSQLSV p
LEFT JOIN orderitemSQLSV oi ON p.id = oi.product_id
WHERE oi.product_id IS NULL;
--Tìm khách hàng chưa đặt đơn hàng nào:

SELECT c.id AS CustomerID, c.name AS CustomerName
FROM customerSQLSV c
LEFT JOIN orderSQLSV o ON c.id = o.customer_id
WHERE o.customer_id IS NULL;


--Tìm các nhà sản xuất chưa có sản phẩm nào:
SELECT m.id AS ManufacturerID, m.name AS ManufacturerName
FROM manufacturerSQLSV m
LEFT JOIN productSQLSV p ON m.id = p.manufacturer_id
WHERE p.manufacturer_id IS NULL;


---Tìm các đơn hàng chưa có chi tiết đơn hàng:
SELECT o.id AS OrderID, o.date_order AS OrderDate
FROM orderSQLSV o
LEFT JOIN orderitemSQLSV oi ON o.id = oi.order_id
WHERE oi.order_id IS NULL;


---Tìm các sản phẩm không thuộc bất kỳ nhà sản xuất nào (không có nhà sản xuất hợp lệ):
SELECT p.id AS ProductID, p.name AS ProductName
FROM productSQLSV p
LEFT JOIN manufacturerSQLSV m ON p.manufacturer_id = m.id
WHERE m.id IS NULL;


---Tìm khách hàng không có hóa đơn nào:
SELECT c.id AS CustomerID, c.name AS CustomerName
FROM customerSQLSV c
LEFT JOIN invoiceSQLSV i ON c.id = i.customer_id
WHERE i.customer_id IS NULL;


--Tìm các đơn hàng không có địa chỉ giao hàng:
SELECT o.id AS OrderID, o.date_order AS OrderDate
FROM orderSQLSV o
LEFT JOIN shippingaddressSQLSV sa ON o.id = sa.order_id
WHERE sa.order_id IS NULL;


--Cau 6:
--Truy vấn hợp (UNION):
--Lấy tất cả các sản phẩm từ hai bảng khác nhau, ví dụ productSQLSV và pcdetailSQLSV.
SELECT p.id AS ProductID, p.name AS ProductName
FROM productSQLSV p
UNION
SELECT pd.id AS ProductID, pd.processor AS ProductName
FROM pcdetailSQLSV pd;


--Truy vấn giao (INTERSECT):
--Lấy các sản phẩm xuất hiện trong cả hai bảng productSQLSV và pcdetailSQLSV.
SELECT p.id AS ProductID, p.name AS ProductName
FROM productSQLSV p
INTERSECT
SELECT pd.product_id AS ProductID, pd.processor AS ProductName
FROM pcdetailSQLSV pd;


--Truy vấn trừ (EXCEPT):
--Lấy các sản phẩm có trong bảng productSQLSV nhưng không có trong bảng orderitemSQLSV.
SELECT p.id AS ProductID, p.name AS ProductName
FROM productSQLSV p
EXCEPT
SELECT oi.product_id AS ProductID, p.name AS ProductName
FROM orderitemSQLSV oi
JOIN productSQLSV p ON oi.product_id = p.id;

--Cau 7: Truy vấn Update, Delete:  7 câu


--Cập nhật giá của một sản phẩm cụ thể:
UPDATE productSQLSV
SET price = 500.0
WHERE id = 1;  -- Thay 1 bằng ID của sản phẩm bạn muốn cập nhật
--Cập nhật trạng thái hoàn thành của một đơn hàng:
UPDATE orderSQLSV
SET complete = 1
WHERE id = 2;  -- Thay 2 bằng ID của đơn hàng bạn muốn cập nhật
--Cập nhật địa chỉ email của một khách hàng:
UPDATE customerSQLSV
SET email = 'newemail@example.com'
WHERE id = 3;  -- Thay 3 bằng ID của khách hàng bạn muốn cập nhật
--Cập nhật địa chỉ giao hàng cho một đơn hàng cụ thể:
UPDATE shippingaddressSQLSV
SET address = '123 New Address', city = 'New City', state = 'New State', zipcode = '12345'
WHERE order_id = 4;  -- Thay 4 bằng ID của đơn hàng bạn muốn cập nhật
--Cập nhật số lượng của một mục trong đơn hàng:
UPDATE orderitemSQLSV
SET quantity = 10
WHERE id = 5;  -- Thay 5 bằng ID của mục đơn hàng bạn muốn cập nhật
--Truy vấn DELETE
--Xóa một sản phẩm cụ thể:

DELETE FROM productSQLSV
WHERE id = 1;  -- Thay 1 bằng ID của sản phẩm bạn muốn xóa
--Xóa một khách hàng cụ thể:
DELETE FROM customerSQLSV
WHERE id = 3;  -- Thay 3 bằng ID của khách hàng bạn muốn xóa


--------------------------------------------------------------------------------------------------------------
---C4: Tạo ít nhất 5 thủ tục/hàm và 3 trigger

---Thủ tục để lấy thông tin chi tiết đơn hàng dựa trên ID đơn hàng:
CREATE PROCEDURE GetOrderDetails
    @orderID INT
AS
BEGIN
    SELECT oi.id AS OrderItemID, oi.quantity, p.name AS ProductName
    FROM orderitemSQLSV oi
    JOIN productSQLSV p ON oi.product_id = p.id
    WHERE oi.order_id = @orderID;
END;

---Thủ tục để cập nhật giá của một sản phẩm:
CREATE PROCEDURE UpdateProductPrice
    @productID INT,
    @newPrice FLOAT
AS
BEGIN
    UPDATE productSQLSV
    SET price = @newPrice
    WHERE id = @productID;
END;

---Thủ tục để tính tổng doanh thu từ các đơn hàng của một khách hàng:
CREATE PROCEDURE CalculateCustomerRevenue
    @customerID INT,
    @totalRevenue FLOAT OUTPUT
AS
BEGIN
    SELECT @totalRevenue = SUM(i.total_amount)
    FROM invoiceSQLSV i
    WHERE i.customer_id = @customerID;
END;

---Thủ tục để xóa tất cả đơn hàng của một khách hàng:
CREATE PROCEDURE DeleteCustomerOrders
    @customerID INT
AS
BEGIN
    DELETE FROM orderSQLSV
    WHERE customer_id = @customerID;
END;

---Thủ tục để thêm mới một sản phẩm vào cơ sở dữ liệu:
CREATE PROCEDURE InsertProduct
    @productName NVARCHAR(200),
    @price FLOAT,
    @manufacturerID INT
AS
BEGIN
    INSERT INTO productSQLSV (name, price, manufacturer_id)
    VALUES (@productName, @price, @manufacturerID);
END;


---Hàm (Function)
---Hàm để tính tổng số lượng sản phẩm đã bán của một sản phẩm:
CREATE FUNCTION CalculateTotalSoldQuantity
    (@productID INT)
RETURNS INT
AS
BEGIN
    DECLARE @totalQuantity INT;
    SELECT @totalQuantity = SUM(oi.quantity)
    FROM orderitemSQLSV oi
    WHERE oi.product_id = @productID;
    RETURN ISNULL(@totalQuantity, 0);
END;


---Hàm để lấy tên của một nhà sản xuất dựa trên ID:
CREATE FUNCTION GetManufacturerName
    (@manufacturerID INT)
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @manufacturerName NVARCHAR(50);
    SELECT @manufacturerName = name
    FROM manufacturerSQLSV
    WHERE id = @manufacturerID;
    RETURN @manufacturerName;
END;


---Hàm để tính tổng giá trị đơn hàng dựa trên ID đơn hàng:
CREATE FUNCTION dbo.CalculateOrderTotal
    (@orderID INT)
RETURNS FLOAT
AS
BEGIN
    DECLARE @orderTotal FLOAT;
    SELECT @orderTotal = SUM(oi.quantity * p.price)
    FROM orderitemSQLSV oi
    JOIN productSQLSV p ON oi.product_id = p.id
    WHERE oi.order_id = @orderID;
    RETURN ISNULL(@orderTotal, 0);
END;


---Trigger
---Trigger để cập nhật tổng giá trị đơn hàng sau khi thêm hoặc cập nhật chi tiết đơn hàng:
CREATE TRIGGER UpdateOrderTotal
ON orderitemSQLSV
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @orderID INT;
    SELECT @orderID = order_id FROM inserted;

    UPDATE invoiceSQLSV
    SET total_amount = dbo.CalculateOrderTotal(@orderID)
    WHERE order_id = @orderID;
END;

---Trigger để tự động xóa các chi tiết đơn hàng khi đơn hàng được xóa:
CREATE TRIGGER DeleteOrderItemsOnOrderDelete
ON orderSQLSV
AFTER DELETE
AS
BEGIN
    DECLARE @orderID INT;
    SELECT @orderID = id FROM deleted;

    DELETE FROM orderitemSQLSV
    WHERE order_id = @orderID;
END;

---Trigger để cập nhật số lượng sản phẩm còn lại sau khi đơn hàng được thêm vào hoặc cập nhật:
CREATE TRIGGER UpdateProductQuantityOnOrderChange
ON orderitemSQLSV
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    DECLARE @productID INT;
    DECLARE @quantity INT;

    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        SELECT @productID = product_id, @quantity = quantity FROM inserted;
    END
    ELSE
    BEGIN
        SELECT @productID = product_id, @quantity = quantity FROM deleted;
        SET @quantity = -@quantity;  -- Điều chỉnh số lượng khi xóa
    END

    UPDATE productSQLSV
    SET quantity = quantity + @quantity
    WHERE id = @productID;
END;


------------------------------------------------------------------------------------------------------------------------------
---Tạo 3 người dùng và cấp quyền cho mỗi người dùng với các quyền khác nhau.
---Tao nguoi dung
-- Tạo người dùng User1
CREATE LOGIN User1 WITH PASSWORD = 'User1Password';
CREATE USER User1 FOR LOGIN User1;

-- Tạo người dùng User2
CREATE LOGIN User2 WITH PASSWORD = 'User2Password';
CREATE USER User2 FOR LOGIN User2;

-- Tạo người dùng User3
CREATE LOGIN User3 WITH PASSWORD = 'User3Password';
CREATE USER User3 FOR LOGIN User3;

---Cấp quyền cho mỗi người dùng


----- Cấp quyền chỉ đọc (SELECT) cho User1 trên một số bảng
GRANT SELECT ON dbo.productSQLSV TO User1;
GRANT SELECT ON dbo.customerSQLSV TO User1;


---- Cấp quyền chỉnh sửa (INSERT, UPDATE, DELETE) cho User2 trên các bảng đơn hàng và chi tiết đơn hàng
GRANT INSERT, UPDATE, DELETE ON dbo.orderSQLSV TO User2;
GRANT INSERT, UPDATE, DELETE ON dbo.orderitemSQLSV TO User2;


---- Cấp quyền quản trị viên (ALTER, DROP, CREATE) cho User3 trên cơ sở dữ liệu
GRANT ALTER, DROP, CREATE TABLE TO User3;
GRANT ALTER, DROP, CREATE PROCEDURE TO User3;
GRANT ALTER, DROP, CREATE FUNCTION TO User3;

