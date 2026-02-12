create table Products
(
	Id int primary key identity(1, 1),
	ProductName nvarchar(50),
	Manufacturer nvarchar(50),
	ProductCount int default 0,
	Price money not null
)

insert into Products values ('Bread', 'Inskoy', 5, 80),
('Water', 'Saint spring', 15, 40),
('Milk', 'Tomskoye moloko', 55, 80),
('Smartphone', 'Samsung', 2, 32080)


select * from Products
go

create procedure ProductSummary as                 /* Создаём процедуру ProductSummary */
select ProductName as Product, Manufacturer, Price /* Компилируемый код процедуры */
from Products
go

exec ProductSummary /* Вызвали процедуру */
go

------------------------------------------

create procedure AddProduct /* Создаём процедуру с ПРИНИМАЕМЫМИ аргументами */
    @name nvarchar(20),
    @manufacturer nvarchar(20),
    @count int,
    @price money
as
insert into Products(ProductName, Manufacturer, ProductCount, Price) 
values(@name, @manufacturer, @count, @price)
go

------------------------------------------

exec AddProduct 'Galaxy C7', 'Samsung', 5, 22000  /* Вызываем процедуру добавления продукта, используя литералы 
                                                  (литералы - это переменные, которые объявляются прямо в вызове функции */
select * from Products

declare @prodName nvarchar(20), @company nvarchar(20); /* Тут мы сначала объявляем переменные */
set @prodName = 'Honor 9'                              /* И уже после устанавливаем их значение */
set @company = 'Huawei'
 
exec AddProduct @name = @prodName,         /* Вызываем процедуру и указываем аргументы по имени */
                @manufacturer=@company,
                @count = 3, 
                @price = 18000
go

------------------------------------------

create procedure AvgPrice /* Создаём процедуру с ВЫВОДИМЫМИ аргументами (просто дописываем output напротив переменных при их объявлении)*/
    @result money output
as
select avg(price) from Products

declare @averagePrice money
exec AvgPrice @averagePrice output /* Чтоб принять переменную */
go

------------------------------------------

create procedure Average
    @num1 float,
    @num2 float,
    @num3 float,
    @result float output
as
begin
    set @result = (@num1 + @num2 + @num3) / 3.0
end
go

declare @result float                      /* Объявили переменную @result с типом float */
exec Average 3.0, 4.0, 7.0, @result output /* Выполняем процедуру Average с параметрами 3, 4, 6 и выводим результат в переменную @result */
print @result                              /* Выводим @result */
go
 
------------------------------------------

create procedure CreateString
    @count int,
    @symbol nvarchar(50),
    @string nvarchar(50) output
as
begin
    set @string = replicate(@symbol, @count)
end

declare @concated nvarchar(50)
exec CreateString 42, '^', @concated output
print @concated

/*привет*/