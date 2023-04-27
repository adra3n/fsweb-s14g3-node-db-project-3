-- Multi-Table Sorgu Pratiği

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)

SELECT  p.ProductName, c.CategoryName 
FROM [PRODUCT] AS p

JOIN [Category] AS c 
ON c.Id = p.CategoryId

-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)

SELECT o.Id, c.CompanyName 
FROM [Order] AS o

JOIN Customer AS c 
ON o.CustomerId = c.Id

WHERE o.OrderDate < 2012-08-09

-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)

SELECT p.Id AS "ProductId", p.ProductName, o.Quantity 
FROM OrderDetail AS o

JOIN Product AS p 
ON o.ProductId = p.Id

WHERE o.OrderId = 10251

-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)

SELECT o.Id AS "OrderId", c.CompanyName AS "CompanyName", e.LastName AS "employee's LastName" 
FROM [Order] AS o

JOIN Employee AS e 
ON o.EmployeeId=e.Id

JOIN Customer AS c
ON c.Id=o.CustomerId

