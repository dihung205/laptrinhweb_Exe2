--1. Liệt kê hóa đơn của khách hàng
SELECT orders.order_id, users.user_id, users.user_name 
FROM orders 
JOIN users ON orders.user_id = users.user_id;
--2. Liệt kê số lượng đơn hàng của khách hàng
SELECT users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders 
FROM users 
LEFT JOIN orders ON users.user_id = orders.user_id 
GROUP BY users.user_id, users.user_name;
--3. Liệt kê thông tin hóa đơn (mã đơn hàng, số sản phẩm)
SELECT orders.order_id, COUNT(order_details.product_id) AS total_products 
FROM orders 
JOIN order_details ON orders.order_id = order_details.order_id 
GROUP BY orders.order_id;
--4. Liệt kê thông tin mua hàng (mã user, tên user, mã đơn hàng, tên sản phẩm)
SELECT users.user_id, users.user_name, orders.order_id, products.product_name 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
GROUP BY users.user_id, users.user_name, orders.order_id, products.product_name;
--5. Liệt kê 7 người dùng có nhiều đơn hàng nhất
SELECT TOP 7 users.user_id, users.user_name, COUNT(orders.order_id) AS total_orders 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
GROUP BY users.user_id, users.user_name 
ORDER BY total_orders DESC;
--6. Liệt kê 7 người dùng mua sản phẩm có tên Samsung hoặc Apple
SELECT DISTINCT TOP 7 users.user_id, users.user_name, orders.order_id, products.product_name 
FROM users 
JOIN orders ON users.user_id = orders.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
WHERE products.product_name LIKE '%Samsung%' OR products.product_name LIKE '%Apple%';
--7. Liệt kê tổng tiền mỗi đơn hàng
SELECT orders.order_id, users.user_id, users.user_name, SUM(products.product_price) AS total_price 
FROM orders 
JOIN users ON orders.user_id = users.user_id 
JOIN order_details ON orders.order_id = order_details.order_id 
JOIN products ON order_details.product_id = products.product_id 
GROUP BY orders.order_id, users.user_id, users.user_name;
--8. Liệt kê mỗi user chỉ chọn 1 đơn hàng có giá tiền lớn nhất
SELECT user_id, user_name, order_id, total_price 
FROM (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price,
           RANK() OVER (PARTITION BY users.user_id ORDER BY SUM(products.product_price) DESC) AS rnk
    FROM orders 
    JOIN users ON orders.user_id = users.user_id 
    JOIN order_details ON orders.order_id = order_details.order_id 
    JOIN products ON order_details.product_id = products.product_id 
    GROUP BY users.user_id, users.user_name, orders.order_id
) ranked_orders WHERE rnk = 1;
--9. Liệt kê danh sách mua hàng và chọn ra đơn hàng có giá trị nhỏ nhất của mỗi user
WITH UserOrders AS (
    SELECT users.user_id, users.user_name, orders.order_id, SUM(products.product_price) AS total_price,
           RANK() OVER (PARTITION BY users.user_id ORDER BY SUM(products.product_price) ASC) AS rank
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    JOIN products ON order_details.product_id = products.product_id
    GROUP BY users.user_id, users.user_name, orders.order_id
)
SELECT user_id, user_name, order_id, total_price 
FROM UserOrders WHERE rank = 1;
--10. Liệt kê danh sách mua hàng và chọn ra đơn hàng có nhiều sản phẩm nhất của mỗi user
WITH UserOrders AS (
    SELECT users.user_id, users.user_name, orders.order_id, COUNT(order_details.product_id) AS total_products,
           RANK() OVER (PARTITION BY users.user_id ORDER BY COUNT(order_details.product_id) DESC) AS rank
    FROM users
    JOIN orders ON users.user_id = orders.user_id
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY users.user_id, users.user_name, orders.order_id
)
SELECT user_id, user_name, order_id, total_products
FROM UserOrders WHERE rank = 1;