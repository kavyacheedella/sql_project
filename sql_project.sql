use sql_project;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100),
    address VARCHAR(255)
);

SELECT customer_id FROM Customers;

INSERT INTO Customers VALUES 
(1,'KAVYA R', '7489352567', 'kavya123@gmail.com', 'MIG-60 KPHB HYDERABAD') ;

UPDATE CUSTOMERS SET address = "Kphb , Hyderabad" where customer_id = 1;

INSERT INTO Customers VALUES  
(2,'Rahul S', '9876543210', 'rahul.s@gmail.com', 'Ameerpet, Hyderabad'),
(3,'Divya P', '9123456780', 'divya.p@gmail.com', 'Banjara Hills, Hyderabad'),
(4,'Kiran M', '9988776655', 'kiran.m@gmail.com', 'Madhapur, Hyderabad'),
(5,'Sneha K', '9001234567', 'sneha.k@gmail.com', 'SR Nagar, Hyderabad'),
(6,'Amit R', '7894561230', 'amit.r@gmail.com', 'Kukatpally, Hyderabad'),
(7,'Pooja T', '9012345678', 'pooja.t@gmail.com', 'Gachibowli, Hyderabad'),
(8,'Ravi K', '8899776655', 'ravi.k@gmail.com', 'Lingampally, Hyderabad'),
(9,'Priya M', '9123987654', 'priya.m@gmail.com', 'Madhura Nagar, Hyderabad'),
(10,'Manish S', '7845123690', 'manish.s@gmail.com', 'Kompally, Hyderabad');

SELECT * FROM CUSTOMERS;

CREATE TABLE Menu_Items (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    category VARCHAR(50), -- e.g., Starter, Main Course, Dessert
    price DECIMAL(10,2),
    availability_status VARCHAR(20) -- Available / Out of Stock
);

INSERT INTO Menu_Items Values
(1, 'Veg Manchurian', 'Starter', 150.00, 'Available'),
(2, 'Chicken 65', 'Starter', 180.00, 'Available'),
(3, 'Paneer Butter Masala', 'Main Course', 240.00, 'Available'),
(4, 'Chicken Biryani', 'Main Course', 280.00, 'Available'),
(5, 'Veg Fried Rice', 'Main Course', 160.00, 'Out of Stock'),
(6, 'Chocolate Ice Cream', 'Dessert', 90.00, 'Available'),
(7, 'Gulab Jamun', 'Dessert', 70.00, 'Available'),
(8, 'Masala Dosa', 'Main Course', 120.00, 'Available'),
(9, 'Caesar Salad', 'Starter', 140.00, 'Out of Stock'),
(10, 'Brownie with Ice Cream', 'Dessert', 170.00, 'Available');

select * from menu_items;


CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20), -- Placed / Completed / Cancelled
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Orders Values
(1, 1, '2024-01-10', 450.00, 'Completed'),
(2, 3, '2024-01-15', 980.50, 'Placed'),
(3, 2, '2024-02-02', 1500.00, 'Completed'),
(4, 5, '2024-02-10', 620.75, 'Cancelled'),
(5, 4, '2024-03-01', 320.00, 'Completed'),
(6, 7, '2024-03-12', 890.00, 'Placed'),
(7, 6, '2024-03-18', 1750.90, 'Completed'),
(8, 9, '2024-04-01', 430.25, 'Completed'),
(9, 8, '2024-04-10', 1220.00, 'Cancelled'),
(10, 10, '2024-04-15', 2100.50, 'Placed');

select * from Orders;

update orders set order_date = "2025-03-05" where customer_id = 2;
update orders set order_date = "2025-10-10" where customer_id = 4;


CREATE TABLE Order_Items (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT,
    subtotal DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (item_id) REFERENCES Menu_Items(item_id)
);

INSERT INTO Order_Items VALUES
-- ORDER 1 → total 450
(1, 1, 3, 1, 240.00),
(2, 1, 1, 1, 150.00),
(3, 1, 7, 1, 60.00),

-- ORDER 2 → total 980.50  (note: decimals allowed)
(4, 2, 4, 2, 560.00),
(5, 2, 6, 3, 270.00),
(6, 2, 7, 2, 140.00),
(7, 2, 9, 1, 140.50),   -- adjusted decimal to match exact total

-- ORDER 3 → total 1500
(8, 3, 4, 3, 840.00),
(9, 3, 3, 2, 480.00),
(10, 3, 6, 2, 180.00),

-- ORDER 4 → total 620.75
(11, 4, 2, 1, 180.00),
(12, 4, 5, 2, 320.00),
(13, 4, 7, 1, 70.75),   -- adjusted decimals

-- ORDER 5 → total 320.00
(14, 5, 8, 2, 240.00),
(15, 5, 6, 1, 90.00),
(16, 5, 7, 1, -10.00); -- This shouldn't be negative. We'll fix in final version.

SELECT * FROM order_items;
desc order_items;

CREATE TABLE Inventory (
    item_code INT PRIMARY KEY,
    ingredient_name VARCHAR(100),
    quantity_in_stock INT,
    unit VARCHAR(20), -- e.g., kg, liters, pieces
    reorder_level INT
);

INSERT INTO Inventory VALUES
(1, 'Rice', 200, 'kg', 50),
(2, 'Wheat Flour', 150, 'kg', 40),
(3, 'Sugar', 300, 'kg', 60),
(4, 'Cooking Oil', 100, 'liters', 20),
(5, 'Milk Packets', 500, 'pieces', 100),
(6, 'Masala Powder', 250, 'kg', 50),
(7, 'Cold Drink Bottles', 120, 'pieces', 30),
(8, 'Vegetable Mix', 180, 'kg', 50),
(9, 'Chicken', 90, 'kg', 20),
(10, 'Fish', 70, 'kg', 20);

select * from inventory;


CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    phone VARCHAR(15),
    email VARCHAR(100)
);

INSERT INTO Suppliers VALUES
(1, 'Fresh Farms Ltd', '9876543210', 'contact@freshfarms.com'),
(2, 'Spice World Traders', '9123456780', 'sales@spiceworld.in'),
(3, 'Green Leaf Vegetables', '9001234567', 'info@greenleafveg.com'),
(4, 'Quality Meats Supply', '9988776655', 'support@qualitymeats.in'),
(5, 'Daily Dairy Products', '7894561230', 'orders@dailydairy.com'),
(6, 'Royal Bakery Supplies', '9012345678', 'service@royalbakery.in'),
(7, 'Fresh Catch Seafoods', '8899776655', 'hello@freshcatch.com'),
(8, 'Healthy Grains Pvt Ltd', '9123987654', 'contact@healthygrains.in'),
(9, 'Beverage Hub Distributors', '7845123690', 'sales@bevhub.com'),
(10, 'Sunrise Provision Store', '9876012345', 'sunrise@suppliers.in');

select * from suppliers;

CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY,
    supplier_id INT,
    item_code INT,
    purchase_date DATE,
    quantity INT,
    total_cost DECIMAL(10,2),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id),
    FOREIGN KEY (item_code) REFERENCES Inventory(item_code)
);

INSERT INTO Purchases VALUES
(1, 1, 1, '2024-01-05', 50, 2500.00),        -- Rice
(2, 2, 6, '2024-01-10', 30, 1800.00),        -- Masala Powder
(3, 3, 8, '2024-01-15', 40, 2400.00),        -- Vegetable Mix
(4, 4, 9, '2024-01-18', 25, 3750.00),        -- Chicken
(5, 5, 5, '2024-02-01', 100, 4000.00),       -- Milk packets
(6, 6, 3, '2024-02-08', 60, 3600.00),        -- Sugar
(7, 7, 10, '2024-02-15', 20, 3000.00),       -- Fish
(8, 8, 7, '2024-02-20', 50, 2500.00),        -- Cold drinks
(9, 9, 4, '2024-03-01', 40, 3200.00),        -- Cooking oil
(10, 10, 2, '2024-03-05', 70, 3500.00);      -- Wheat flour

SELECT * from Purchases;

SELECT* from menu_items where price > 300;

SELECT DISTINCT c.name
FROM Customers c
JOIN Orders o 
ON o.customer_id = c.customer_id
WHERE o.order_date BETWEEN '2025-10-01' AND '2025-10-31';


select * from menu_items;
SELECT * FROM menu_items where availability_status = "out of stock";
SELECT * FROM orders where status = "completed";


DESC ORDER_ITEMS;
SELECT * FROM MENU_ITEMS;
SELECT * FROM ORDER_ITEMS;
SELECT * FROM ORDERS;
SELECT * FROM CUSTOMERS;


SELECT 
    c.name AS customer_name,
    m.item_name AS ordered_item
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Order_Items oi ON o.order_id = oi.order_id
JOIN Menu_Items m ON oi.item_id = m.item_id;


SELECT o.order_id,
       o.order_date,
       o.total_amount,
       oi.item_id,
       m.item_name,
       oi.quantity,
       oi.subtotal
FROM Orders o
JOIN Order_items oi ON o.order_id = oi.order_id
JOIN menu_items m ON oi.item_id = m.item_id;


SELECT
    o.order_id,
    o.order_date,
    o.total_amount,
    o.status,
    c.customer_id,
    c.name,
    c.phone,
    c.email,
    c.address
FROM Orders o
JOIN Customers c 
    ON o.customer_id = c.customer_id;
 
 SELECT * FROM INVENTORY;
 SELECT * FROM SUPPLIERS;
 SELECT * FROM PURCHASES;
 
 SELECT s.supplier_name,
		s.supplier_id,
        i.item_code,
        i.ingredient_name as ingredient_supplied
FROM Suppliers s
JOIN Purchases p ON s.supplier_id = p.supplier_id
JOIN inventory i ON p.item_code = i.item_code;
 
 
 SELECT 
    m.item_id,
    m.item_name,
    m.category,
    oi.order_id,
    oi.quantity,
    oi.subtotal
FROM Menu_Items m
JOIN Order_Items oi 
    ON m.item_id = oi.item_id;

 
 SELECT DISTINCT
    m.item_name,
    m.category
FROM Menu_Items m
JOIN Order_Items oi 
    ON m.item_id = oi.item_id;


select 
       YEAR(order_date) AS order_year,
       MONTH(order_date) AS order_month,
       COUNT(*) as total_orders
FROM Orders
GROUP BY YEAR(order_date),MONTH(order_date)
ORDER BY order_year,order_month;


SELECT SUM(total_amount) as total_revenue
from orders;


SELECT c.name,sum(o.total_amount) as total_revenue
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.name;


SELECT m.item_name,sum(oi.subtotal) as total_revenue
FROM menu_items m
JOIN Order_items oi ON m.item_id = oi.item_id
GROUP BY m.item_name;


SELECT avg(total_amount) as avg_order_amount
from orders;


SELECT item_name,category,price
FROM menu_items
ORDER BY price desc
LIMIT 1;


SELECT item_name,category,price
FROM menu_items
order by PRICE DESC
limit 3;


SELECT item_name, category, price
from menu_items
order by price desc
limit 1 offset 1;


SELECT item_name, category, price
FROM Menu_Items
WHERE price = (SELECT MAX(price) FROM Menu_Items);

select * from inventory;

select 
ingredient_name,
sum(quantity_in_stock) as total_quantity ,unit
FROM inventory
group by ingredient_name , unit;


SELECT  c.customer_id,
        c.name,
        c.phone,
        c.email
FROM customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.order_id is null;


SELECT * FROM customers 
WHERE customer_id NOT IN(SELECT customer_id from orders);


SELECT * FROM menu_items 
WHERE  ITEM_ID NOT IN (SELECT item_id from order_items);

select * FROM INVENTORY;

SELECT * FROM inventory WHERE quantity_in_stock <  reorder_level;


SELECT s.supplier_id, s.supplier_name
FROM Suppliers s
LEFT JOIN Purchases p 
    ON s.supplier_id = p.supplier_id
    AND p.purchase_date >= CURDATE() - INTERVAL 30 DAY
WHERE p.purchase_id IS NULL;


SELECT supplier_id , supplier_name
FROM Suppliers 
WHERE supplier_id NOT IN(SELECT supplier_id 
FROM purchases  
WHERE purchase_date >= curdate() - interval 30 day
);


SELECT * FROM ORDERS WHERE TOTAL_AMOUNT > ( SELECT AVG(TOTAL_AMOUNT) FROM ORDERS);

SELECT * FROM ORDERS;
SELECT * FROM MENU_ITEMS;

UPDATE Menu_Items
SET availability_status = 'Out of Stock'
WHERE item_id IN (
    SELECT item_id FROM Order_Items
);


UPDATE Menu_Items
SET availability_status = 'Out of Stock'
WHERE item_id IN (
    SELECT item_id
    FROM Order_Items oi
    JOIN Orders o ON o.order_id = oi.order_id
    WHERE o.status = 'Completed'
)
AND (
    SELECT quantity_in_stock
    FROM Inventory
    WHERE item_code = Menu_Items.item_id
) <= 0;

SELECT * FROM SUPPLIERS;
UPDATE Suppliers
SET 
    supplier_name = 'Fresh Farms Pvt Ltd',
    phone = '9876000000',
    email = 'info@freshfarms.com'
WHERE supplier_id = 4;


SELECT * FROM ORDERS;


DELETE FROM ORDER_ITEMS
WHERE ORDER_ID IN (
SELECT ORDER_ID FROM ORDERS WHERE STATUS = "CANCELLED"
);

DELETE FROM ORDERS WHERE STATUS = "CANCELLED";

 
 DELETE FROM customers
 WHERE CUSTOMER_ID NOT IN(
 SELECT CUSTOMER_ID from orders);

	

DELIMITER $$

CREATE TRIGGER reduce_inventory_after_order
AFTER INSERT ON Order_items
FOR EACH ROW
BEGIN
     UPDATE INVENTORY
     SET quantity_in_stock = quantity_in_stock - NEW.quantity
     WHERE item_code = NEW.item_id;
END $$

DELIMITER ;


INSERT INTO ORDER_ITEMS (order_item_id , order_id , item_id , quantity , subtotal) 
VALUES (101, 1, 3, 40, 480.00);

select * from menu_items;
select * from inventory;



DELIMITER $$

CREATE TRIGGER prevent_insufficient_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE current_stock INT;

    -- Get available stock for the item
    SELECT quantity_in_stock INTO current_stock
    FROM Inventory
    WHERE item_code = NEW.item_id;

    -- If stock is less than quantity ordered, stop the insertion
    IF current_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Insufficient stock for this item.';
    END IF;
END$$

DELIMITER ;

INSERT INTO Order_Items VALUES (101, 1, 3, 209, 480.00);

SELECT * FROM ORDER_ITEMS;
SELECT * FROM INVENTORY;


CREATE TABLE Purchase_History (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    purchase_id INT,
    supplier_id INT,
    item_code INT,
    quantity INT,
    total_cost DECIMAL(10,2),
    purchase_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


DELIMITER $$

CREATE TRIGGER add_purchase_history
AFTER INSERT ON Purchases
FOR EACH ROW
BEGIN
    INSERT INTO Purchase_History (
        purchase_id,
        supplier_id,
        item_code,
        quantity,
        total_cost,
        purchase_date
    )
    VALUES (
        NEW.purchase_id,
        NEW.supplier_id,
        NEW.item_code,
        NEW.quantity,
        NEW.total_cost,
        NEW.purchase_date
    );
END$$

DELIMITER ;


INSERT INTO Purchases 
VALUES (11, 2, 3, '2024-04-05', 30, 1800.00);

select * from purchases;
select * from purchase_history;



CREATE VIEW Combined_Order_Report AS
SELECT
  o.order_id,
  o.order_date,
  c.customer_id,
  c.name            AS customer_name,
  c.phone           AS customer_phone,
  c.email           AS customer_email,
  GROUP_CONCAT(CONCAT(m.item_name, ' (x', oi.quantity, ')') 
               ORDER BY m.item_name SEPARATOR ', ') AS items,
  o.total_amount
FROM Orders o
JOIN Customers c      ON o.customer_id = c.customer_id
JOIN Order_Items oi   ON o.order_id = oi.order_id
JOIN Menu_Items m     ON oi.item_id = m.item_id
GROUP BY
  o.order_id,
  o.order_date,
  c.customer_id,
  c.name,
  c.phone,
  c.email,
  o.total_amount;
  
SELECT * FROM Combined_Order_Report
ORDER BY order_date DESC, order_id;





DROP PROCEDURE IF EXISTS Daily_Sales_Summary;


DELIMITER $$

CREATE PROCEDURE Daily_Sales_Summary(IN summary_date DATE)
BEGIN
    SELECT 
        summary_date AS report_date,

        -- Total orders on that day
        COUNT(DISTINCT o.order_id) AS total_orders,

        -- Total revenue on that day
        SUM(o.total_amount) AS total_sales,

        -- Total quantity of items sold
        SUM(oi.quantity) AS total_quantity_sold,

        -- Average order value
        AVG(o.total_amount) AS avg_order_value

    FROM Orders o
    JOIN Order_Items oi 
        ON o.order_id = oi.order_id
    WHERE o.order_date = summary_date;
END$$

DELIMITER ;


    
  
CALL Daily_Sales_Summary('2024-03-12');

CALL Daily_Sales_Summary('2024-04-12');

  
  

DELIMITER $$

CREATE PROCEDURE Monthly_sales_summary(
                                        IN sales_year INT,
                                        IN sales_month INT
)

BEGIN
     SELECT
           sales_year AS report_year,
           sales_month AS report_month,
           
           COUNT(DISTINCT o.order_id) AS total_orders,
           
           SUM(o.total_amount) AS total_sales,
           
           SUM(oi.quantity) AS total_quantity_sold,
           
           AVG(o.total_amount) AS avg_order_value
           
	FROM Orders o
    JOIN order_items oi 
    ON o.order_id = oi.order_id
    WHERE YEAR(o.order_date) = sales_year
    AND MONTH(o.order_date) = sales_month;

END$$

DELIMITER ;

CALL Monthly_Sales_Summary(2024 , 3);

CALL Monthly_Sales_Summary(2025 , 10);
    
  
-- TRIGGER: Prevent order if stock is insufficient

DELIMITER //

CREATE TRIGGER check_item_stock
BEFORE INSERT ON Order_Items
FOR EACH ROW
BEGIN
    DECLARE v_stock INT;

    -- Get current stock
    SELECT quantity_in_stock INTO v_stock
    FROM Inventory
    WHERE item_code = NEW.item_id;

    -- If no enough stock → block insert
    IF v_stock < NEW.quantity THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Order Failed: Not enough stock';
    END IF;

END//

DELIMITER ;


-- Deduct stock automatically after insert


DELIMITER //

CREATE TRIGGER reduce_stock_after_order
AFTER INSERT ON Order_Items
FOR EACH ROW
BEGIN
    UPDATE Inventory
    SET quantity_in_stock = quantity_in_stock - NEW.quantity
    WHERE item_code = NEW.item_id;
END//

DELIMITER ;

ALTER TABLE Order_Items
MODIFY order_item_id INT NOT NULL AUTO_INCREMENT;


INSERT INTO Orders (customer_id, order_date, total_amount, status)
VALUES (1, CURDATE(), 480.00, 'Placed');


SELECT LAST_INSERT_ID();


INSERT INTO Order_Items (order_item_id,order_id, item_id, quantity, subtotal)
VALUES (104,16, 3, 2, 480.00);


select * from order_items;

SELECT * FROM Inventory WHERE item_code = 3;

-- insufficient stock error
INSERT INTO Order_Items (order_id, item_id, quantity, subtotal)
VALUES (13, 3, 205, 2400.00);


-- Top 5 Selling Dishes by Total Quantity Sold

SELECT 
      m.item_name,
      SUM(oi.quantity) as total_quantity_sold
FROM order_items oi
JOIN menu_items m 
ON oi.item_id = m.item_id
GROUP BY m.item_id,m.item_name
ORDER BY total_quantity_sold DESC
LIMIT 5;


-- Monthly Revenue Report for 2024

SELECT 
    month_number,
    month_name,
    SUM(monthly_revenue) AS monthly_revenue,
    SUM(total_orders) AS total_orders
FROM (
    SELECT 
        order_id,
        total_amount,
        MONTH(order_date) AS month_number,
        DATE_FORMAT(order_date, '%M') AS month_name,
        total_amount AS monthly_revenue,
        1 AS total_orders
    FROM Orders
    WHERE YEAR(order_date) = 2024
) AS t
GROUP BY month_number, month_name
ORDER BY month_number;


-- Most Frequent Customers (by number of orders)

SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC;


-- Most Frequent Customers + Total Spending

SELECT 
    c.customer_id,
    c.name AS customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.total_amount) AS total_spending
FROM Customers c
JOIN Orders o 
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name
ORDER BY total_orders DESC, total_spending DESC;


-- Ingredients Most Frequently Restocked (by number of purchases)

SELECT 
    i.item_code,
    i.ingredient_name,
    COUNT(p.purchase_id) AS restock_count
FROM Inventory i
JOIN Purchases p 
    ON i.item_code = p.item_code
GROUP BY i.item_code, i.ingredient_name
ORDER BY restock_count DESC;


-- Ingredients Restocked by Quantity

SELECT 
    i.item_code,
    i.ingredient_name,
    SUM(p.quantity) AS total_restocked_quantity
FROM Inventory i
JOIN Purchases p 
    ON i.item_code = p.item_code
GROUP BY i.item_code, i.ingredient_name
ORDER BY total_restocked_quantity DESC;


-- Supplier Who Provides the Highest Quantity

SELECT 
    s.supplier_id,
    s.supplier_name,
    SUM(p.quantity) AS total_quantity_supplied
FROM Suppliers s
JOIN Purchases p 
    ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_quantity_supplied DESC
LIMIT 1;


-- Category Generating the Highest Revenue

SELECT
    m.category,
    SUM(oi.subtotal) AS total_revenue
FROM Order_Items oi
JOIN Menu_Items m 
    ON oi.item_id = m.item_id
GROUP BY m.category
ORDER BY total_revenue DESC
LIMIT 1;


-- Highest-Revenue Dish Inside Each Category (Using RANK)

SELECT 
    category,
    item_name,
    total_revenue
FROM (
    SELECT
        m.category,
        m.item_name,
        SUM(oi.subtotal) AS total_revenue,
        RANK() OVER (PARTITION BY m.category ORDER BY SUM(oi.subtotal) DESC) AS rnk
    FROM Order_Items oi
    JOIN Menu_Items m 
        ON oi.item_id = m.item_id
    GROUP BY m.category, m.item_name
) AS ranked_items
WHERE rnk = 1;


