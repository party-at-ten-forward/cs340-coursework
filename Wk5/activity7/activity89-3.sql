SELECT Customers.CustomerName,Invoices.InvoiceID,SUM(InvoiceDetails.LineTotal) AS SumLineTotal
FROM Customers
INNER JOIN Invoices ON Customers.CustomerID = Invoices.CustomerID
INNER JOIN InvoiceDetails ON Invoices.InvoiceID = InvoiceDetails.InvoiceID
GROUP BY Invoices.InvoiceID
ORDER BY SumLineTotal DESC;