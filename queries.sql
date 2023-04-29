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


-- Her gönderici tarafından gönderilen gönderi sayısını bulun.

SELECT s.ShipperName as "Gönderici Adı", count(*) AS "Gönderi Sayısı" FROM [Orders] AS o
JOIN [Shippers] AS s ON o.ShipperID = s.ShipperID
GROUP BY o.ShipperID

-- Sipariş sayısına göre ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.

SELECT (e.FirstName||' '||e.LastName)  AS "Çalışan Adı", count(*) AS "Toplam Sipariş" FROM [Orders] AS o
JOIN [Employees] AS e ON e.EmployeeID=o.EmployeeID 
GROUP BY o.EmployeeID 
ORDER BY "Toplam Sipariş" DESC
LIMIT 5

-- Gelir olarak ölçülen en iyi performans gösteren ilk 5 çalışanı bulun.

SELECT (e.FirstName||' '||e.LastName)  AS "Çalışan Adı", SUM(p.Price*od.Quantity) AS "Sipariş Toplamı" FROM [Orders] AS o
JOIN [OrderDetails] AS od ON o.OrderID= od.OrderID
JOIN [Employees] AS e ON e.EmployeeID = o.EmployeeID
JOIN [Products] AS p ON od.ProductID = p.ProductID
GROUP BY e.EmployeeID
ORDER BY "Sipariş Toplamı" DESC
LIMIT 5

-- En az gelir getiren kategoriyi bulun.

SELECT c.CategoryName AS "Kategori Adı", SUM(p.Price*od.Quantity) AS "Sipariş Toplamı" FROM [OrderDetails] AS od
JOIN [Categories] AS c ON c.CategoryID = p.CategoryID
JOIN [Products] AS p ON od.ProductID = p.ProductID
GROUP BY c.CategoryID
ORDER BY "Sipariş Toplamı" ASC
LIMIT 1

-- En çok siparişi olan müşteri ülkesini bulun.

SELECT  c.Country AS "Ülke" ,count(*) AS "Toplam Sipariş" FROM [Orders] AS o
JOIN [OrderDetails] AS od ON o.OrderID= od.OrderID
JOIN [Customers] AS c ON c.CustomerID = o.CustomerID
GROUP BY c.Country
ORDER BY "Toplam Sipariş" DESC
LIMIT 1

