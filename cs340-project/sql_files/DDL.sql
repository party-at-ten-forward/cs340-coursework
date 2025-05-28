DROP PROCEDURE  IF EXISTS sp_load_steakdb;
DELIMITER //
CREATE PROCEDURE sp_load_steakdb()
BEGIN

    -- CREATE DATABASE IF NOT EXISTS `steakdb`;
    -- USE `steakdb`;

    SET FOREIGN_KEY_CHECKS=0;
    SET AUTOCOMMIT = 0;

    -- ~~~~~~~~~~~~~~~ Create tables ~~~~~~~~~~~~~~~
    DROP TABLE IF EXISTS `Loyalty_Tiers`;
    CREATE OR REPLACE TABLE Loyalty_Tiers
    (
        loyalty_tier_id int NOT NULL AUTO_INCREMENT,
        tier_name varchar(20) NOT NULL UNIQUE,
        min_spend int UNIQUE,
        discount decimal(10,2) UNIQUE,
        PRIMARY KEY (loyalty_tier_id)
    );

    DROP TABLE IF EXISTS `Customers`;
    CREATE OR REPLACE TABLE Customers
    (
        customer_id int NOT NULL AUTO_INCREMENT,
        company_name varchar(50) NOT NULL UNIQUE,
        address varchar(150) NOT NULL,
        is_local tinyint(1) NOT NULL DEFAULT 0,
        buyer_name varchar(100) NOT NULL,
        buyer_email varchar(150) NOT NULL UNIQUE,
        buyer_phone varchar(20) UNIQUE,
        loyalty_tier_id int NOT NULL,
        PRIMARY KEY (customer_id),
        FOREIGN KEY (loyalty_tier_id) REFERENCES Loyalty_Tiers(loyalty_tier_id)
    );

    DROP TABLE IF EXISTS `Suppliers`;
    CREATE OR REPLACE TABLE Suppliers
    (
        supplier_id int NOT NULL AUTO_INCREMENT,
        ranch varchar(50) NOT NULL UNIQUE,
        country varchar(50) NOT NULL,
        rep_name varchar(100) NOT NULL,
        rep_email varchar(150) NOT NULL UNIQUE,
        rep_phone varchar(20) UNIQUE,
        PRIMARY KEY (supplier_id)
    );

    DROP TABLE IF EXISTS `Products`;
    CREATE OR REPLACE TABLE Products
    (
        product_id int NOT NULL AUTO_INCREMENT,
        name varchar(50) NOT NULL UNIQUE,
        description varchar(150) NOT NULL,
        is_organic tinyint(1) NOT NULL DEFAULT 1,
        supplier_id int NOT NULL,
        PRIMARY KEY (product_id),
        FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
    );

    DROP TABLE IF EXISTS `Purchase_Orders`;
    CREATE OR REPLACE TABLE Purchase_Orders
    (
        purchase_order_id int NOT NULL AUTO_INCREMENT,
        supplier_id int NOT NULL,
        order_date date NOT NULL,
        total decimal(10,2) NOT NULL,
        PRIMARY KEY (purchase_order_id),
        FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
    );

    DROP TABLE IF EXISTS `Cust_Prod_Orders`;
    CREATE OR REPLACE TABLE Cust_Prod_Orders
    (
        cust_prod_order_id int NOT NULL AUTO_INCREMENT,
        customer_id int NOT NULL,
        product_id int NOT NULL,
        price decimal(10,2) NOT NULL,
        quantity int UNSIGNED NOT NULL DEFAULT 1,
        needs_delivery tinyint(1) NOT NULL DEFAULT 0,
        recurring tinyint(1) NOT NULL DEFAULT 0,
        PRIMARY KEY (cust_prod_order_id),
        FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE NO ACTION,
        FOREIGN KEY (product_id) REFERENCES Products(product_id) ON DELETE NO ACTION
    );

    DROP TABLE IF EXISTS `Product_Purchases`;
    CREATE OR REPLACE TABLE Product_Purchases
    (
        prod_purchase_id int NOT NULL AUTO_INCREMENT,
        product_id int NOT NULL,
        purchase_order_id int NOT NULL,
        cost decimal(10,2) NOT NULL,
        quantity int UNSIGNED NOT NULL DEFAULT 1,
        PRIMARY KEY (prod_purchase_id),
        FOREIGN KEY (product_id) REFERENCES Products(product_id),
        FOREIGN KEY (purchase_order_id) REFERENCES Purchase_Orders(purchase_order_id)
    );

    -- ~~~~~~~~~~~~~~~ Insert Example Data ~~~~~~~~~~~~~~~

    INSERT INTO Loyalty_Tiers
    (
        tier_name, 
        min_spend, 
        discount
    )
    VALUES
    ('Bronze', 0, 0.00),
    ('Silver', 5000, 2.50),
    ('Gold', 15000, 5.00);

    INSERT INTO Customers
    (
        company_name, 
        address, 
        is_local, 
        buyer_name, 
        buyer_email, 
        buyer_phone, 
        loyalty_tier_id
    )
    VALUES
    (
        'Arby Has Taken The Meats', 
        '123 Longhorn Rd, El Paso, TX', 
        1, 
        'John Smith', 
        'jsmith@arbys.com', 
        '911-911-9111',
        (SELECT loyalty_tier_id FROM Loyalty_Tiers WHERE tier_name = 'Silver')
    ),
    (
        'Mick Donald', 
        '456 Cactus Ln, Santa Fe, NM', 
        0, 
        'Mick Jagger', 
        'mjag@oldmick.com', 
        '123-456-7890',
        (SELECT loyalty_tier_id FROM Loyalty_Tiers WHERE tier_name = 'Gold')
    ),
    (
        'Big Hoss BBQ', 
        '789 Ribeye Ave, Amarillo, TX', 
        1, 
        'Hoss Cartwright', 
        'hoss@bighoss.com', 
        '999-888-7777',
        (SELECT loyalty_tier_id FROM Loyalty_Tiers WHERE tier_name = 'Bronze')
    );


    INSERT INTO Suppliers
    (
        ranch, 
        country, 
        rep_name, 
        rep_email, 
        rep_phone
    )
    VALUES
    (
        'Weenie Hut Seniors', 
        'Antarctica', 
        'The Thing', 
        'kurtrussell@whs.an', 
        '800-867-5309'
    ),
    (
        'Black Mesa Farms', 
        'USA', 
        'Gordon Freeman', 
        'gfree@blackmesa.com', 
        '806-555-2233'
    ),
    (
        'Big Boot Bill', 
        'Canada', 
        'Bill Nye', 
        'bill@nye.ca', 
        '555-321-4567'
    );

    INSERT INTO Products 
    (
        name, 
        description, 
        is_organic, 
        supplier_id
    ) 
    VALUES
    (
        'Dubious Cut', 
        'Some sort of meat we think.', 
        0,
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Weenie Hut Seniors')
    ),
    (
        'Headcrab Meat', 
        'In the test chamber...', 
        1,
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Black Mesa Farms')
    ),
    (
        'Science Slab', 
        'DO NOT PANIC.', 
        1,
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Big Boot Bill')
    );

    INSERT INTO Purchase_Orders
    (
        supplier_id, 
        order_date, 
        total
    ) 
    VALUES
    (
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Weenie Hut Seniors'), 
        '2025-01-15', 
        7800.00
    ),
    (
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Black Mesa Farms'), 
        '2025-02-01', 
        4500.00
    ),
    (
        (SELECT supplier_id FROM Suppliers WHERE ranch = 'Big Boot Bill'), 
        '2025-03-12', 
        6200.00
    );

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
        (SELECT customer_id FROM Customers WHERE company_name = 'Arby Has Taken The Meats'),
        (SELECT product_id FROM Products WHERE name = 'Dubious Cut'),
        60.00, 
        20, 
        1, 
        0
    ),
    (
        (SELECT customer_id FROM Customers WHERE company_name = 'Mick Donald'),
        (SELECT product_id FROM Products WHERE name = 'Headcrab Meat'),
        30.00, 
        10, 
        1, 
        1
    ),
    (
        (SELECT customer_id FROM Customers WHERE company_name = 'Big Hoss BBQ'),
        (SELECT product_id FROM Products WHERE name = 'Science Slab'),
        85.00, 
        5, 
        0, 
        1
    );


    INSERT INTO Product_Purchases
    (
        product_id, 
        purchase_order_id, 
        cost, 
        quantity
    ) 
    VALUES
    (
        (SELECT product_id FROM Products WHERE name = 'Dubious Cut'),
        (SELECT purchase_order_id FROM Purchase_Orders WHERE order_date = '2025-01-15'),
        52.00, 
        100
    ),
    (
        (SELECT product_id FROM Products WHERE name = 'Headcrab Meat'),
        (SELECT purchase_order_id FROM Purchase_Orders WHERE order_date = '2025-02-01'),
        30.00, 
        80
    ),
    (
        (SELECT product_id FROM Products WHERE name = 'Science Slab'),
        (SELECT purchase_order_id FROM Purchase_Orders WHERE order_date = '2025-03-12'),
        70.00, 
        50
    );

    SET FOREIGN_KEY_CHECKS=1;
    COMMIT;
END //

DELIMITER ;
