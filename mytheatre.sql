drop table Purchased;
drop table Customer;
drop table Movies;


create table Movies(
	title varchar(30) not null,
	Room char(1) not null,
	Duration varchar(6) not null,
	Age_Restriciton real ,
	ReleaseDate date not null,
	cost real not null,
	Quantity integer not null,
	primary key(title)
	) ENGINE = INNODB;


create table Customer(
	Name varchar(20) not null,
	TypeOfSeating char(1) not null,
	age integer not null,
	primary key(Name)
	) ENGINE = INNODB;

create table Purchased(
	Name varchar(20) not null,
	title varchar(30) not null,
	primary key(Name, title),
	foreign key(title) references Movies(title)
	on delete cascade,
	foreign key(Name) references Customer(Name)
	on delete cascade
	) ENGINE = INNODB;


insert into Movies values ('Marvel: Endgame', 'A', '2:05', 13, '2020-05-02', '22', '55');
insert into Movies values ('Forrest Gump', 'B', '2:35', 13, '1969-03-22', '4', '21');
insert into Movies values ('Polar Express', 'C', '1.39', 0, '2000-12-22', '8.25', '33');
insert into Movies values ('Tarzan II', 'D', '1.25', 0, '1999-03-09', '7.25', '50');
insert into Movies values ('The Conjuring', 'E', '3.10', 15, '2018-01-01','5', '25');

insert into Customer values ('Elin Johansson', 'N', 22);
insert into Customer values ('Susie Thomas', 'S', 12);
insert into Customer values ('Robert Jr',  'N', 13);
insert into Customer values ('Tom Hanks',  'S', 15);
insert into Customer values ('Santa Clause',  'N', 18);


insert into Purchased values ('Robert Jr','Marvel: Endgame');
insert into Purchased values ('Elin Johansson','Forrest Gump');
