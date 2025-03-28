CREATE DATABASE solution_a;
USE solution_a;

CREATE TABLE users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    user_name VARCHAR(25) NOT NULL,
    user_email VARCHAR(25) NOT NULL,
    user_pass VARCHAR(255) NOT NULL,
    updated_at DATETIME NOT NULL,
    created_at DATETIME NOT NULL
);
-- Tạo bảng products
CREATE TABLE products (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL,
    product_price DECIMAL(10,2) NOT NULL, -- Sửa DOUBLE thành DECIMAL
    product_description NVARCHAR(MAX) NOT NULL, -- Sửa TEXT thành NVARCHAR(MAX)
    updated_at DATETIME NOT NULL DEFAULT GETDATE(),
    created_at DATETIME NOT NULL DEFAULT GETDATE()
);
CREATE TABLE orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

CREATE TABLE order_details (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    updated_at DATETIME,
    created_at DATETIME,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

-- Chèn dữ liệu vào bảng users
INSERT INTO users (user_name, user_email, user_pass, updated_at, created_at) VALUES
('Alice', 'alice@gmail.com', 'pass123', GETDATE(), GETDATE()),
('Bob', 'bob@gmail.com', 'pass456', GETDATE(), GETDATE()),
('Ava', 'ava@yahoo.com', 'pass789', GETDATE(), GETDATE()),
('David', 'david@gmail.com', 'pass101', GETDATE(), GETDATE()),
('Eve', 'eve@gmail.com', 'pass202', GETDATE(), GETDATE());

-- Chèn dữ liệu vào bảng products
INSERT INTO products (product_name, product_price, product_description, updated_at, created_at) VALUES
('Laptop', 1200.50, 'A high-end laptop', GETDATE(), GETDATE()),
('Phone', 699.99, 'A smartphone', GETDATE(), GETDATE()),
('Tablet', 450.00, 'A tablet device', GETDATE(), GETDATE());

