------------------------------------------------------------
------------------------------------------------------------
-- Customers
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    Customers.customer_id,
    Customers.company_name, 
    Customers.address, 
    IF(Customers.is_local = 1, 'Yes', 'No') AS is_local,
    Customers.buyer_name, 
    Customers.buyer_email, 
    Customers.buyer_phone, 
    Loyalty_Tiers.tier_name AS tier_name
FROM Customers
INNER JOIN Loyalty_Tiers ON Customers.loyalty_tier_id = Loyalty_Tiers.loyalty_tier_id;


------------------------------------------------------------
------------------------------------------------------------
-- Loyalty_Tiers
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    loyalty_tier_id,
    tier_name, 
    min_spend, 
    discount
FROM Loyalty_Tiers;


------------------------------------------------------------
------------------------------------------------------------
-- Products
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    Products.product_id,
    Products.name, 
    Products.description, 
    IF(Products.is_organic = 1, 'Yes', 'No') AS is_organic,
    Suppliers.ranch AS supplier_name
FROM Products
INNER JOIN Suppliers ON Products.supplier_id = Suppliers.supplier_id;


------------------------------------------------------------
------------------------------------------------------------
-- Suppliers
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    supplier_id,
    ranch, 
    country, 
    rep_name, 
    rep_email, 
    rep_phone
FROM Suppliers;



------------------------------------------------------------
------------------------------------------------------------
-- Purchase_Orders
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    Purchase_Orders.purchase_order_id,
    Suppliers.ranch AS supplier_name,
    Purchase_Orders.order_date, 
    Purchase_Orders.total 
FROM Purchase_Orders
INNER JOIN Suppliers ON Purchase_Orders.supplier_id = Suppliers.supplier_id;


------------------------------------------------------------
------------------------------------------------------------
-- Product_Purchases
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------
SELECT
    Product_Purchases.prod_purchase_id,
    Products.name AS product_name,
    Product_Purchases.purchase_order_id, 
    Product_Purchases.cost, 
    Product_Purchases.quantity
FROM Product_Purchases
INNER JOIN Products ON Product_Purchases.product_id = Products.product_id;


------------------------------------------------------------
------------------------------------------------------------
-- Cust_Prod_Orders
------------------------------------------------------------
------------------------------------------------------------

------------------
-- Get Data
------------------

-- Get Data for table view
SELECT
    Cust_Prod_Orders.cust_prod_order_id,
    Customers.company_name,
    Products.name AS product_name,
    Cust_Prod_Orders.price,
    Cust_Prod_Orders.quantity,
    IF(Cust_Prod_Orders.needs_delivery = 1, 'Yes', 'No') AS needs_delivery,
    IF(Cust_Prod_Orders.recurring = 1, 'Yes', 'No') AS recurring
FROM Cust_Prod_Orders
INNER JOIN Customers ON Cust_Prod_Orders.customer_id = Customers.customer_id
INNER JOIN Products ON Cust_Prod_Orders.product_id = Products.product_id;

-- Get Data for dropdowns

-- customer dropdown
SELECT company_name FROM Customers;

-- product dropdown
SELECT name FROM Products;

-- order to update dropdown
SELECT cust_prod_order_id FROM Cust_Prod_Orders;


------------------
-- Insert Data
------------------
-- populate list of customers for dropdown
SELECT company_name FROM Customers;
-- populate list of products for dropdown
SELECT name FROM Products;
-- insert based on selections
INSERT INTO Cust_Prod_Orders 
(
    customer_id, 
    product_id, 
    price, 
    quantity, 
    needs_delivery, 
    recurring
) 
VALUES
(
    (SELECT customer_id FROM Customers WHERE company_name = %customer_selection),
    (SELECT product_id FROM Products WHERE name = %product_selection),
    %price_input, 
    %quantity_input, 
    %needs_delivery_selection, 
    %recurring_selection
);

------------------
-- Update Data
------------------

UPDATE Cust_Prod_Orders
SET
    customer_id = %customer_id_from_customer_name,
    product_id = %product_id_from_product_name,
    price = %price_input, 
    quantity = %quantity_input, 
    needs_delivery = %needs_delivery_selection, 
    recurring = %recurring_selection
WHERE cust_prod_order_id = %cust_prod_id_selection

------------------
-- Delete Data
------------------

DELETE FROM Cust_Prod_Orders WHERE cust_prod_order_id = %cust_prod_id_selection