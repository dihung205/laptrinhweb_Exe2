--1. Lấy danh sách người dùng theo thứ tự A → Z
SELECT * FROM users ORDER BY user_name ASC;
--2. Lấy 7 người đầu tiên theo thứ tự A → Z
SELECT TOP 7 * FROM users ORDER BY user_name ASC;
--3. Lấy danh sách người dùng có chứa chữ "a" trong tên
SELECT * FROM users WHERE user_name LIKE '%a%' ORDER BY user_name ASC;
--4. Lấy danh sách người dùng có tên bắt đầu bằng "m"
SELECT * FROM users WHERE user_name LIKE 'm%';
--5. Lấy danh sách người dùng có tên kết thúc bằng "i"
SELECT * FROM users WHERE user_name LIKE '%i';
--6. Lấy danh sách người dùng có email sử dụng Gmail
SELECT * FROM users WHERE user_email LIKE '%@gmail.com';
--7. Lấy danh sách người dùng có email Gmail và tên bắt đầu bằng "m"
SELECT * FROM users WHERE user_email LIKE '%@gmail.com' AND user_name LIKE 'm%';
--8. Lấy danh sách người dùng có email Gmail, tên có chữ "i", và tên dài hơn 5 ký tự
SELECT * FROM users 
WHERE user_email LIKE '%@gmail.com' 
AND user_name LIKE '%i%' 
AND LEN(user_name) > 5;
--9. Lấy danh sách người dùng có tên chứa "a", tên dài từ 5-9 ký tự, email là Gmail và email có chứa chữ "i"
SELECT * FROM users 
WHERE user_name LIKE '%a%' 
AND LEN(user_name) BETWEEN 5 AND 9 
AND user_email LIKE '%@gmail.com' 
AND user_email LIKE '%i%';
--10. Lấy danh sách người dùng có tên chứa "a", tên dài từ 5-9 ký tự hoặc chứa chữ "i", tên dưới 9 ký tự hoặc email Gmail chứa "i"
SELECT * FROM users 
WHERE (user_name LIKE '%a%' AND LEN(user_name) BETWEEN 5 AND 9) 
   OR (user_name LIKE '%i%' AND LEN(user_name) < 9) 
   OR (user_email LIKE '%@gmail.com' AND user_email LIKE '%i%');


