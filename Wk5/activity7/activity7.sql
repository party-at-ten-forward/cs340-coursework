/*
    ACTIVITY 7 - CREATE A CUSTOMER OBJECT TABLE

    ! NOTES !

    Anytime you see [SQUARE BRACKETS] it means something that is optional.

    Anytime you see ... three dots - it means continued iterations of the same thing.
*/



/*
    CREATE THE CUSTOMERS TABLE

    Create the table customers, replace it if it exists, defined by the columns within the parentheses.

    We can use CREATE OR REPLACE instead of putting the usual DROP IF EXISTS statements at the top of the SQL file.

    The general syntax of CREATE [OR REPLACE] (Square brackets indicates its optional) is:

    CREATE [OR REPLACE] tableName 
    (
        columnName datatype constraints,
        ...
        [[PRIMARY KEY (columnName, ...)],
        FOREIGN KEY (columnName) REFERENCES primaryTableName(primaryKey, ...)]
    );
*/

CREATE TABLE Customers (
    CustomerID int NOT NULL AUTO_INCREMENT,
    CustomerName varchar(50),
    AddressLine1 varchar(50),
    AddressLine2 varchar(50),
    City varchar(50),
    State varchar(50),
    PostalCode varchar(50),
    YTDPurchases decimal(19,2),
    PRIMARY KEY (CustomerID)
);

/*
    ADD DATA TO THE TABLE

    The general syntax of an INSERT INTO statement is:

    INSERT INTO tableName (
        column1,
        column2,
        ...
    )
    VALUES
    (
        valueForColumn1,
        valueForColumn2,
        ...
    )

    You can include multiple sets of parentheses containing values after the first set to insert multiple rows as in the code below, they just must be separated with a comma and the last set of parentheses must end with a semi-colon.
*/

INSERT INTO Customers (
    CustomerName,
    AddressLine1,
    City,
    State,
    PostalCode
)
VALUES 
(
    "Bike World",
    "60025 Bollinger Canyon Road",
    "San Ramon",
    "California",
    "94583"
),
(
    "Metro Sports",
    "482505 Warm Springs Blvd.",
    "Fremont",
    "California",
    "94536"
),
(
    "Mister Misterson",
    "1234 Cold Hill Fltwy.",
    "Atlanis",
    "Atlantisville",
    "12345"
);

SELECT * FROM Customers;

SELECT CustomerID,CustomerName FROM Customers WHERE PostalCode = "94536";


CREATE TABLE TermsCode (
    TermsCodeID varchar(50) NOT NULL,
    Description varchar(50),
    PRIMARY KEY (TermsCodeID)
);

INSERT INTO TermsCode ( 
    TermsCodeID,
    Description
)
VALUES 
(
    "NET30",
    "Payment due in 30 days."
),
(
    "NET15",
    "Payment due in 15 days."
),
(
    "210NET30",
    "2% discount in 10 days Net 30"
);


CREATE TABLE Invoices (
    InvoiceID int NOT NULL AUTO_INCREMENT,
    CustomerID int,
    InvoiceDate datetime,
    TermsCodeID varchar(50),
    TotalDue decimal(19,2),
    PRIMARY KEY (InvoiceID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (TermsCodeID) REFERENCES TermsCode(TermsCodeID)
);

INSERT INTO Invoices ( 
    CustomerID,
    InvoiceDate,
    TermsCodeID,
    TotalDue
)
VALUES 
(
    2,
    '2014-02-07',
    "NET30",
    2388.98
),
(
    1,
    '2014-02-02',
    "210NET30",
    2443.35
),
(
    1,
    '2014-02-09',
    "NET30",
    8752.32
);


CREATE TABLE Products
(
    ProductNumber varchar(50) NOT NULL,
    ProductName varchar(50),
    SafetyStockLevel int,
    ReorderPoint int,
    StandardCost decimal(19,2),
    ListPrice decimal(19,2),
    DaysToManufacture int,
    PRIMARY KEY (ProductNumber)
);


INSERT INTO `Products` (`ProductNumber`, `ProductName`, `SafetyStockLevel`, `ReorderPoint`, `StandardCost`, `ListPrice`, `DaysToManufacture`) VALUES
('BB-7421', 'LL Bottom Bracket', 500, 375, '23.97', '53.99', 1),
('BB-9108', 'HL Bottom Bracket', 500, 375, '53.94', '121.49', 1),
('BK-M18B-40', 'Mountain-500 Black, 40', 100, 75, '294.58', '539.99', 4),
('BK-M18B-42', 'Mountain-500 Black, 42', 100, 75, '294.58', '539.99', 4),
('BK-M18B-44', 'Mountain-500 Black, 44', 100, 75, '294.58', '539.99', 4),
('BK-M18B-48', 'Mountain-500 Black, 48', 100, 75, '294.58', '539.99', 4),
('BK-M18B-52', 'Mountain-500 Black, 52', 100, 75, '294.58', '539.99', 4),
('BK-M18S-40', 'Mountain-500 Silver, 40', 100, 75, '308.22', '564.99', 4),
('BK-M18S-42', 'Mountain-500 Silver, 42', 100, 75, '308.22', '564.99', 4),
('BK-M18S-44', 'Mountain-500 Silver, 44', 100, 75, '308.22', '564.99', 4),
('BK-M18S-48', 'Mountain-500 Silver, 48', 100, 75, '308.22', '564.99', 4),
('BK-M18S-52', 'Mountain-500 Silver, 52', 100, 75, '308.22', '564.99', 4),
('BK-M38S-38', 'Mountain-400-W Silver, 38', 100, 75, '419.78', '769.49', 4),
('BK-M38S-40', 'Mountain-400-W Silver, 40', 100, 75, '419.78', '769.49', 4),
('BK-M38S-42', 'Mountain-400-W Silver, 42', 100, 75, '419.78', '769.49', 4),
('BK-M38S-46', 'Mountain-400-W Silver, 46', 100, 75, '419.78', '769.49', 4),
('BK-M68B-38', 'Mountain-200 Black, 38', 100, 75, '1251.98', '2294.99', 4),
('BK-M68B-42', 'Mountain-200 Black, 42', 100, 75, '1251.98', '2294.99', 4),
('BK-M68B-46', 'Mountain-200 Black, 46', 100, 75, '1251.98', '2294.99', 4),
('BK-M68S-38', 'Mountain-200 Silver, 38', 100, 75, '1265.62', '2319.99', 4),
('BK-M68S-42', 'Mountain-200 Silver, 42', 100, 75, '1265.62', '2319.99', 4),
('BK-M68S-46', 'Mountain-200 Silver, 46', 100, 75, '1265.62', '2319.99', 4),
('BK-R19B-44', 'Road-750 Black, 44', 100, 75, '343.65', '539.99', 4),
('BK-R19B-48', 'Road-750 Black, 48', 100, 75, '343.65', '539.99', 4),
('BK-R19B-52', 'Road-750 Black, 52', 100, 75, '343.65', '539.99', 4),
('BK-R19B-58', 'Road-750 Black, 58', 100, 75, '343.65', '539.99', 4),
('BK-R64Y-38', 'Road-550-W Yellow, 38', 100, 75, '713.08', '1120.49', 4),
('BK-R64Y-40', 'Road-550-W Yellow, 40', 100, 75, '713.08', '1120.49', 4),
('BK-R64Y-42', 'Road-550-W Yellow, 42', 100, 75, '713.08', '1120.49', 4),
('BK-R64Y-44', 'Road-550-W Yellow, 44', 100, 75, '713.08', '1120.49', 4),
('BK-R64Y-48', 'Road-550-W Yellow, 48', 100, 75, '713.08', '1120.49', 4),
('BK-R79Y-40', 'Road-350-W Yellow, 40', 100, 75, '1082.51', '1700.99', 4),
('BK-R79Y-42', 'Road-350-W Yellow, 42', 100, 75, '1082.51', '1700.99', 4),
('BK-R79Y-44', 'Road-350-W Yellow, 44', 100, 75, '1082.51', '1700.99', 4),
('BK-R79Y-48', 'Road-350-W Yellow, 48', 100, 75, '1082.51', '1700.99', 4),
('BK-R89B-44', 'Road-250 Black, 44', 100, 75, '1554.95', '2443.35', 4),
('BK-R89B-48', 'Road-250 Black, 48', 100, 75, '1554.95', '2443.35', 4),
('BK-R89B-52', 'Road-250 Black, 52', 100, 75, '1554.95', '2443.35', 4),
('BK-R89B-58', 'Road-250 Black, 58', 100, 75, '1554.95', '2443.35', 4),
('BK-R89R-58', 'Road-250 Red, 58', 100, 75, '1554.95', '2443.35', 4),
('BK-T18U-44', 'Touring-3000 Blue, 44', 100, 75, '461.44', '742.35', 4),
('BK-T18U-50', 'Touring-3000 Blue, 50', 100, 75, '461.44', '742.35', 4),
('BK-T18U-54', 'Touring-3000 Blue, 54', 100, 75, '461.44', '742.35', 4),
('BK-T18U-58', 'Touring-3000 Blue, 58', 100, 75, '461.44', '742.35', 4),
('BK-T18U-62', 'Touring-3000 Blue, 62', 100, 75, '461.44', '742.35', 4),
('BK-T18Y-44', 'Touring-3000 Yellow, 44', 100, 75, '461.44', '742.35', 4),
('BK-T18Y-50', 'Touring-3000 Yellow, 50', 100, 75, '461.44', '742.35', 4),
('BK-T18Y-54', 'Touring-3000 Yellow, 54', 100, 75, '461.44', '742.35', 4),
('BK-T18Y-58', 'Touring-3000 Yellow, 58', 100, 75, '461.44', '742.35', 4),
('BK-T18Y-62', 'Touring-3000 Yellow, 62', 100, 75, '461.44', '742.35', 4),
('BK-T44U-46', 'Touring-2000 Blue, 46', 100, 75, '755.15', '1214.85', 4),
('BK-T44U-50', 'Touring-2000 Blue, 50', 100, 75, '755.15', '1214.85', 4),
('BK-T44U-54', 'Touring-2000 Blue, 54', 100, 75, '755.15', '1214.85', 4),
('BK-T44U-60', 'Touring-2000 Blue, 60', 100, 75, '755.15', '1214.85', 4),
('BK-T79U-46', 'Touring-1000 Blue, 46', 100, 75, '1481.94', '2384.07', 4),
('BK-T79U-50', 'Touring-1000 Blue, 50', 100, 75, '1481.94', '2384.07', 4),
('BK-T79U-54', 'Touring-1000 Blue, 54', 100, 75, '1481.94', '2384.07', 4),
('BK-T79U-60', 'Touring-1000 Blue, 60', 100, 75, '1481.94', '2384.07', 4),
('BK-T79Y-46', 'Touring-1000 Yellow, 46', 100, 75, '1481.94', '2384.07', 4),
('BK-T79Y-50', 'Touring-1000 Yellow, 50', 100, 75, '1481.94', '2384.07', 4),
('BK-T79Y-54', 'Touring-1000 Yellow, 54', 100, 75, '1481.94', '2384.07', 4),
('BK-T79Y-60', 'Touring-1000 Yellow, 60', 100, 75, '1481.94', '2384.07', 4),
('CA-1098', 'AWC Logo Cap', 4, 3, '6.92', '8.99', 0),
('CH-0234', 'Chain', 500, 375, '8.99', '20.24', 1),
('CL-9009', 'Bike Wash - Dissolver', 4, 3, '2.97', '7.95', 0),
('CS-4759', 'LL Crankset', 500, 375, '77.92', '175.49', 1),
('CS-9183', 'HL Crankset', 500, 375, '179.82', '404.99', 1),
('FB-9873', 'Front Brakes', 500, 375, '47.29', '106.50', 1),
('FD-2342', 'Front Derailleur', 500, 375, '40.62', '91.49', 1),
('FR-M21B-42', 'LL Mountain Frame - Black, 42', 500, 375, '136.79', '249.79', 1),
('FR-M21B-44', 'LL Mountain Frame - Black, 44', 500, 375, '136.79', '249.79', 1),
('FR-M21B-48', 'LL Mountain Frame - Black, 48', 500, 375, '136.79', '249.79', 1),
('FR-M21S-40', 'LL Mountain Frame - Silver, 40', 500, 375, '144.59', '264.05', 2),
('FR-M21S-42', 'LL Mountain Frame - Silver, 42', 500, 375, '144.59', '264.05', 1),
('FR-M21S-44', 'LL Mountain Frame - Silver, 44', 500, 375, '144.59', '264.05', 1),
('FR-M21S-52', 'LL Mountain Frame - Silver, 52', 500, 375, '144.59', '264.05', 1),
('FR-M63S-40', 'ML Mountain Frame-W - Silver, 40', 500, 375, '199.38', '364.09', 1),
('FR-M63S-42', 'ML Mountain Frame-W - Silver, 42', 500, 375, '199.38', '364.09', 1),
('FR-M63S-46', 'ML Mountain Frame-W - Silver, 46', 500, 375, '199.38', '364.09', 1),
('FR-M94B-38', 'HL Mountain Frame - Black, 38', 500, 375, '739.04', '1349.60', 2),
('FR-M94B-42', 'HL Mountain Frame - Black, 42', 500, 375, '739.04', '1349.60', 1),
('FR-M94S-38', 'HL Mountain Frame - Silver, 38', 500, 375, '747.20', '1364.50', 2),
('FR-M94S-42', 'HL Mountain Frame - Silver, 42', 500, 375, '747.20', '1364.50', 1),
('FR-M94S-46', 'HL Mountain Frame - Silver, 46', 500, 375, '747.20', '1364.50', 1),
('FR-R38B-52', 'LL Road Frame - Black, 52', 500, 375, '204.63', '337.22', 1),
('FR-R38B-58', 'LL Road Frame - Black, 58', 500, 375, '204.63', '337.22', 1),
('FR-R72Y-38', 'ML Road Frame-W - Yellow, 38', 500, 375, '360.94', '594.83', 2),
('FR-R72Y-44', 'ML Road Frame-W - Yellow, 44', 500, 375, '360.94', '594.83', 1),
('FR-R72Y-48', 'ML Road Frame-W - Yellow, 48', 500, 375, '360.94', '594.83', 1),
('FR-R92B-44', 'HL Road Frame - Black, 44', 500, 375, '868.63', '1431.50', 1),
('FR-R92R-44', 'HL Road Frame - Red, 44', 500, 375, '868.63', '1431.50', 1),
('FR-R92R-62', 'HL Road Frame - Red, 62', 500, 375, '868.63', '1431.50', 1),
('FR-T67U-50', 'LL Touring Frame - Blue, 50', 500, 375, '199.85', '333.42', 1),
('FR-T67U-54', 'LL Touring Frame - Blue, 54', 500, 375, '199.85', '333.42', 1),
('FR-T67Y-44', 'LL Touring Frame - Yellow, 44', 500, 375, '199.85', '333.42', 1),
('FR-T67Y-50', 'LL Touring Frame - Yellow, 50', 500, 375, '199.85', '333.42', 1),
('FR-T67Y-62', 'LL Touring Frame - Yellow, 62', 500, 375, '199.85', '333.42', 1),
('FR-T98U-46', 'HL Touring Frame - Blue, 46', 500, 375, '601.74', '1003.91', 1),
('FR-T98U-50', 'HL Touring Frame - Blue, 50', 500, 375, '601.74', '1003.91', 1),
('FR-T98U-54', 'HL Touring Frame - Blue, 54', 500, 375, '601.74', '1003.91', 1),
('FR-T98U-60', 'HL Touring Frame - Blue, 60', 500, 375, '601.74', '1003.91', 1),
('FR-T98Y-46', 'HL Touring Frame - Yellow, 46', 500, 375, '601.74', '1003.91', 1),
('FR-T98Y-50', 'HL Touring Frame - Yellow, 50', 500, 375, '601.74', '1003.91', 1),
('FR-T98Y-54', 'HL Touring Frame - Yellow, 54', 500, 375, '601.74', '1003.91', 1),
('FR-T98Y-60', 'HL Touring Frame - Yellow, 60', 500, 375, '601.74', '1003.91', 1),
('GL-H102-L', 'Half-Finger Gloves, L', 4, 3, '9.16', '24.49', 0),
('GL-H102-M', 'Half-Finger Gloves, M', 4, 3, '9.16', '24.49', 0),
('GL-H102-S', 'Half-Finger Gloves, S', 4, 3, '9.16', '24.49', 0),
('HB-M243', 'LL Mountain Handlebars', 500, 375, '19.78', '44.54', 1),
('HB-M763', 'ML Mountain Handlebars', 500, 375, '27.49', '61.92', 1),
('HB-M918', 'HL Mountain Handlebars', 500, 375, '53.40', '120.27', 1),
('HB-R956', 'HL Road Handlebars', 500, 375, '53.40', '120.27', 1),
('HB-T928', 'HL Touring Handlebars', 500, 375, '40.66', '91.57', 1),
('HL-U509', 'Sport-100 Helmet, Black', 4, 3, '13.09', '34.99', 0),
('HL-U509-B', 'Sport-100 Helmet, Blue', 4, 3, '13.09', '34.99', 0),
('HL-U509-R', 'Sport-100 Helmet, Red', 4, 3, '13.09', '34.99', 0),
('HY-1023-70', 'Hydration Pack - 70 oz.', 4, 3, '20.57', '54.99', 0),
('LJ-0192-L', 'Long-Sleeve Logo Jersey, L', 4, 3, '38.49', '49.99', 0),
('LJ-0192-M', 'Long-Sleeve Logo Jersey, M', 4, 3, '38.49', '49.99', 0),
('LJ-0192-X', 'Long-Sleeve Logo Jersey, XL', 4, 3, '38.49', '49.99', 0),
('PD-M282', 'LL Mountain Pedal', 500, 375, '17.98', '40.49', 1),
('PD-M340', 'ML Mountain Pedal', 500, 375, '27.57', '62.09', 1),
('PD-M562', 'HL Mountain Pedal', 500, 375, '35.96', '80.99', 1),
('PD-R347', 'LL Road Pedal', 500, 375, '17.98', '40.49', 1),
('PD-R563', 'ML Road Pedal', 500, 375, '27.57', '62.09', 1),
('PD-R853', 'HL Road Pedal', 500, 375, '35.96', '80.99', 1),
('PD-T852', 'Touring Pedal', 500, 375, '35.96', '80.99', 1),
('PK-7098', 'Patch Kit/8 Patches', 4, 3, '0.86', '2.29', 0),
('RA-H123', 'Hitch Rack - 4-Bike', 4, 3, '44.88', '120.00', 0),
('RB-9231', 'Rear Brakes', 500, 375, '47.29', '106.50', 1),
('RD-2308', 'Rear Derailleur', 500, 375, '53.93', '121.46', 1),
('SE-M236', 'LL Mountain Seat/Saddle', 500, 375, '12.04', '27.12', 1),
('SE-M798', 'ML Mountain Seat/Saddle', 500, 375, '17.38', '39.14', 1),
('SE-M940', 'HL Mountain Seat/Saddle', 500, 375, '23.37', '52.64', 1),
('SE-R995', 'HL Road Seat/Saddle', 500, 375, '23.37', '52.64', 1),
('SE-T924', 'HL Touring Seat/Saddle', 500, 375, '23.37', '52.64', 1),
('SH-W890-L', "Women\'s Mountain Shorts, L", 4, 3, '26.18', '69.99', 0),
('SH-W890-M', "Women\'s Mountain Shorts, M", 4, 3, '26.18', '69.99', 0),
('SH-W890-S', "Women\'s Mountain Shorts, S", 4, 3, '26.18', '69.99', 0),
('SJ-0194-L', 'Short-Sleeve Classic Jersey, L', 4, 3, '41.57', '53.99', 0),
('SJ-0194-S', 'Short-Sleeve Classic Jersey, S', 4, 3, '41.57', '53.99', 0),
('SJ-0194-X', 'Short-Sleeve Classic Jersey, XL', 4, 3, '41.57', '53.99', 0),
('SO-R809-L', 'Racing Socks, L', 4, 3, '3.36', '8.99', 0),
('SO-R809-M', 'Racing Socks, M', 4, 3, '3.36', '8.99', 0),
('VE-C304-M', 'Classic Vest, M', 4, 3, '23.75', '63.50', 0),
('VE-C304-S', 'Classic Vest, S', 4, 3, '23.75', '63.50', 0),
('WB-H098', 'Water Bottle - 30 oz.', 4, 3, '1.87', '4.99', 0);

CREATE TABLE InvoiceDetails
(
    InvoiceDetailsID int NOT NULL AUTO_INCREMENT,
    InvoiceID int,
    ProductNumber varchar(50),
    OrderQty int,
    UnitPrice decimal(19,2),
    LineTotal decimal(18,2),
    PRIMARY KEY (InvoiceDetailsID),
    CONSTRAINT FK_InvoiceDetails_InvoiceID FOREIGN KEY (InvoiceID)
    REFERENCES Invoices(InvoiceID),
    CONSTRAINT FK_InvoiceDetails_ProductNumber FOREIGN KEY (ProductNumber) 
    REFERENCES Products(ProductNumber)
);

INSERT INTO InvoiceDetails
(
    InvoiceID,
    ProductNumber,
    OrderQty,
    UnitPrice,
    LineTotal
)
VALUES
(
    1,
    'BK-M68S-38',
    1,
    2319.99,
    2319.99
),
(
    1,
    'HL-U509-R',
    2,
    34.99,
    69.98
),
(
    2,
    'BK-R89B-52',
    1,
    2443.35,
    2443.35
),
(
    3,
    'BK-T79U-50',
    2,
    2145.66,
    4291.32
),
(
    3,
    'BK-R89B-52',
    2,
    2199.01,
    4398.02
),
(
    3,
    'HL-U509',
    2,
    31.49,
    62.98
);