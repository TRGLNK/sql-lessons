create database barbershopDB;
go;

use barbershopDB;
go;

create table Positions(
	PositionId int primary key identity(1, 1),
	Name nvarchar(20)
);
go;

create table Barbers(
	BarberId int primary key identity(1, 1),
	Fio nvarchar(50) not null,
	Gender bit,
	Tel nvarchar(50),
	Email nvarchar(50),
	BirthDate date,
	EmploymentDate date,
	PositionId int,
	constraint FK_Barbers_Positions foreign key (PositionId) references Positions(PositionId),
);
go;

insert into Positions values ('Chief'), ('Senior'), ('Junior');

select Fio from Barbers;

select * from Barbers
where PositionId = 2;

select * from Barbers b
join Positions p on p.PositionId = b.PositionId
where p.PositionId = 'senior';