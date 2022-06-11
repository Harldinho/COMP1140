drop table reservation
drop table loan
drop table location
drop table movable
drop table immovable
drop table category
drop table privilege
drop table course
drop table staff
drop table student
drop table acquisition
drop table resource
drop table member

create table member(
MemberID	Char(8), 
name		varchar(50) not null, 
address		varchar(50) not null, 
phone		bigint, 
email		varchar(50) not null, 
status		varchar(8) default 'Active', 
comments	varchar(100),
primary key(MemberID),
check(phone > 0))

create table resource(
ResourceID		char(8), 
description		varchar(50), 
status			varchar(11) default 'Available',
primary key(ResourceID))

create table acquisition(
AcquisitionID	char(8),
MemberID		char(8) not null,
name			varchar(50) not null, 
make			varchar(50), 
manufacturer	varchar(50), 
model			varchar(50), 
year			int, 
description		varchar(100), 
urgency			varchar(10) default 'non-urgent', 
Status			varchar(8) not null, 
FundCode		char(8) not null, 
VendorCode		char(8) not null, 
Price			float not null, 
Notes			varchar(100),
primary key(AcquisitionID),
foreign key(MemberID) references member on update cascade on delete no action,
check(Price > 0),
check(year between 1000 and 2020))


create table student(
StudentID	char(8),
MemberID	char(8) not null,
Points		tinyint default 12,
Status		varchar(8) default 'Enabled',
primary key(StudentID),
foreign key(MemberID) references member on update cascade on delete no action,
check(Points between 0 and 12))

create table staff(
StaffID		char(8), 
MemberID	char(8) not null,
Status		varchar(8) default 'Enabled',
primary key(StaffID),
foreign key(MemberID) references member on update cascade on delete no action)

create table course(
OfferingID		char(8),
StudentID		char(8) not null,
courseID		char(8) not null, 
name			varchar(50) not null, 
semesterOffered	tinyint not null, 
yearOffered		int not null, 
dateBegun		date not null, 
dateCourseEnd	date not null,
primary key(OfferingID),
foreign key(StudentID) references student on update cascade on delete no action,
check(semesterOffered between 1 and 2),
check(yearOffered between 1000 and 2020))

create table privilege(
PrivilegeID			char(8),
OfferingID			char(8) not null,
name				varchar(50) not null, 
description			varchar(100), 
category			varchar(50) not null, 
maxResourceBorrow	tinyint not null,
primary key(PrivilegeID),
foreign key(OfferingID) references course,
check(maxResourceBorrow > 0))

create table category(
CategoryID		char(8),
PrivilegeID		char(8) not null,
ResourceID		char(8) not null,
name			varchar(50) not null, 
description		varchar(100),	 
MaxBorrowTime	datetime not null,
primary key(CategoryID),
foreign key(PrivilegeID) references privilege on update cascade on delete no action,
foreign key(ResourceID) references resource on update cascade on delete no action)

create table immovable(
ImmovableID		char(8),
ResourceID		char(8) not null,
Capacity		smallint not null,
primary key(ImmovableID),
foreign key(ResourceID) references resource on update cascade on delete cascade,
check(Capacity > 0))

create table movable(
MovableID		char(8),
ResourceID		char(8) not null,
name			varchar(50) not null, 
make			varchar(50), 
manufacturer	varchar(50), 
model			varchar(50), 
year			int, 
assetValue		float not null,
primary key(MovableID),
foreign key(ResourceID) references resource on update cascade on delete cascade,
check(assetValue > 0),
check(year between 1000 and 2020))

create table location(
LocationID	char(8),
ResourceID	char(8) not null,
Room		varchar(50) not null, 
Building	varchar(50) not null, 
Campus		varchar(50) not null,
primary key(LocationID),
foreign key(ResourceID) references resource on update cascade on delete no action)

create table loan(
LoanID				char(8),
MemberID			char(8) not null,
MovableID			char(8) not null,
dateTimeBorrowed	datetime not null, 
dateTimeReturned	datetime not null, 
dateTimeDue			datetime not null,
primary key(LoanID),
foreign key(MemberID) references member on update cascade on delete no action,
foreign key(MovableID) references movable on update cascade on delete no action)

create table reservation(
ReservationID		char(8),
MemberID			char(8) not null,
ResourceID			char(8) not null,
dateTimeReserved	datetime not null,   
dateTimeDue			datetime not null,
primary key(ReservationID),
foreign key(MemberID) references member on update cascade on delete no action,
foreign key(ResourceID) references resource on update cascade on delete no action)




insert into member(MemberID, name, address, phone, email, comments) values('M1234567', 'Cory', '34 East street', '1438765567', 'Cory@hotmail.com', 'I am Cory')
insert into member(MemberID, name, address, phone, email) values('M7654321', 'Matt', '12 Hello street', '9876543214', 'Matt@hotmail.com')
insert into member(MemberID, name, address, phone, email, comments) values('M1357911', 'Lukas', '76 Bright avenue', '65714631', 'Lukas@gmail.com', 'I am a member of SCS')
insert into member(MemberID, name, address, phone, email) values('M9999999', 'Mark', '14 West street', '5754678367', 'Mark@hotmail.com')
insert into member(MemberID, name, address, phone, email) values('M9888888', 'John', '10 GoodBye steet', '1800101010', 'John@hotmail.com')
insert into member(MemberID, name, address, phone, email) values('M9777777', 'Mic', '99 port close', '885935672', 'Mic@gmail.com')

insert into resource(ResourceID, status) values('R9876543', 'In Use')
insert into resource(ResourceID, description) values('R1313131', '10k resistor')
insert into resource(ResourceID, description, status) values('R1245789', 'bunsen burner used for chemistry', 'Lost')
insert into resource(ResourceID, description) values('R6543782', 'industrial oven')
insert into resource(ResourceID, description ,status) values('R6879348', 'computer', 'Maintenance')
insert into resource(ResourceID) values('R5789343')

insert into acquisition(AcquisitionID, MemberID, name, make, manufacturer, model, year, description, Status, FundCode, VendorCode, Price, Notes) values('A7657474', 'M7654321', 'jabulani soccer ball', '2010 nike', 'nike', 'jabulani', '2010', 'A soccer ball used in the 2010 world cup', 'Pending', 'FC121856', 'VC587463', '80', 'A replica version')
insert into acquisition(AcquisitionID, MemberID, name, make, manufacturer, year, urgency, Status, FundCode, VendorCode, Price) values('A5434331', 'M7654321', 'cricket gloves', '2012 adidas', 'adidas', '2012', 'Urgent', 'Acquired', 'FC000123', 'VC768549', '56.89')
insert into acquisition(AcquisitionID, MemberID, name, description, Status, FundCode, VendorCode, Price) values('A5438455', 'M9999999', '10 NPN transistors', 'any 10 pk of NPN transistors', 'Pending', 'FC567492', 'VC121256', '20.05')

insert into student(StudentID, MemberID) values('STU00012', 'M1234567')
insert into student(StudentID, MemberID, Points) values('STU00111', 'M7654321', '9')
insert into student(StudentID, MemberID, Points) values('STU00237', 'M1357911', '9')

insert into staff(StaffID, MemberID) values('STA13013', 'M9999999')
insert into staff(StaffID, MemberID) values('STA14014', 'M9888888')
insert into staff(StaffID, MemberID) values('STA15015', 'M9777777')

insert into course(OfferingID, StudentID, courseID, name, semesterOffered, yearOffered, dateBegun, dateCourseEnd) values('OFF12458', 'STU00012', 'COUR0001', 'Introduction to Computer Science', '1', '2020', '2020-01-14', '2020-05-14')
insert into course(OfferingID, StudentID, courseID, name, semesterOffered, yearOffered, dateBegun, dateCourseEnd) values('OFF75835', 'STU00111', 'COUR0002', 'Introduction to Electrical Engineering', '1', '2020', '2020-02-12', '2020-06-12')
insert into course(OfferingID, StudentID, courseID, name, semesterOffered, yearOffered, dateBegun, dateCourseEnd) values('OFF58705', 'STU00237', 'COUR0003', 'Introduction to Physics', '2', '2020', '2020-06-10', '2020-10-10')

insert into privilege(PrivilegeID, OfferingID, name, description, category, maxResourceBorrow) values('PR000012', 'OFF12458', 'Science storage', 'access to science storage', 'science', '5')
insert into privilege(PrivilegeID, OfferingID, name, description, category, maxResourceBorrow) values('PR000013', 'OFF75835', 'engineering storage', 'access to engineering storage', 'engineering', '10')
insert into privilege(PrivilegeID, OfferingID, name, description, category, maxResourceBorrow) values('PR000014', 'OFF58705', 'physics storage', 'access to physics storage', 'physics', '2')

insert into category(CategoryID, PrivilegeID, ResourceID, name, description, MaxBorrowTime) values('CAT56789', 'PR000012', 'R9876543', 'speaker', 'speaker for music', '2020-12-30 11:59:59')
insert into category(CategoryID, PrivilegeID, ResourceID, name, MaxBorrowTime) values('CAT55555', 'PR000013', 'R5789343', 'camera', '2020-12-30 11:59:59')
insert into category(CategoryID, PrivilegeID, ResourceID, name, MaxBorrowTime) values('CAT57495', 'PR000014', 'R1245789', 'physics category', '2020-12-30 11:59:59')

insert into immovable(ImmovableID, ResourceID, Capacity) values('IM564784', 'R6543782', '2')
insert into immovable(ImmovableID, ResourceID, Capacity) values('IM754835', 'R6879348', '1')
insert into immovable(ImmovableID, ResourceID, Capacity) values('IM478239', 'R5789343', '5')

insert into movable(MovableID, ResourceID, name, manufacturer, model, year, assetValue) values('MO654378', 'R5789343', 'HD camera', 'HD', 'pinpoint', '2020', '150.67')
insert into movable(MovableID, ResourceID, name, assetValue) values('MO467285', 'R1313131', '10k resistor', '0.69')
insert into movable(MovableID, ResourceID, name, make, manufacturer, year, assetValue) values('MO463526', 'R1245789', 'Bunsen Burner', 'flamer', 'flameCo', '2016', '45.12')

insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC74657', 'R9876543', 'ES105', 'ES', 'Winchester')
insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC42653', 'R1313131', 'AH684', 'AH', 'Lincoln')
insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC36847', 'R1245789', 'HU483', 'HU', 'Winchester')
insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC47386', 'R6543782', 'HU387', 'HU', 'Winchester')
insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC78966', 'R6879348', 'AH789', 'AH', 'Lincoln')
insert into location(LocationID, ResourceID, Room, Building, Campus) values('LOC96785', 'R5789343', 'ES107', 'ES', 'Winchester')

insert into loan(LoanID, MemberID, MovableID, dateTimeBorrowed, dateTimeReturned, dateTimeDue) values('LOAN5673', 'M1234567', 'MO654378', '2020-06-10 05:45:56', '2020-07-10 09:55:56', '2020-08-10 05:45:56')
insert into loan(LoanID, MemberID, MovableID, dateTimeBorrowed, dateTimeReturned, dateTimeDue) values('LOAN4565', 'M9999999', 'MO467285', '2020-04-13 08:15:43', '2020-06-14 07:34:51', '2020-09-13 08:15:43')
insert into loan(LoanID, MemberID, MovableID, dateTimeBorrowed, dateTimeReturned, dateTimeDue) values('LOAN5473', 'M1357911', 'MO463526', '2020-11-01 09:32:12', '2020-11-03 05:58:12', '2020-11-15 09:32:12')
insert into loan(LoanID, MemberID, MovableID, dateTimeBorrowed, dateTimeReturned, dateTimeDue) values('LOAN5474', 'M1357911', 'MO463526', '2020-11-14 09:32:12', '2020-11-16 05:58:12', '2020-11-18 09:32:12')
insert into loan(LoanID, MemberID, MovableID, dateTimeBorrowed, dateTimeReturned, dateTimeDue) values('LOAN5475', 'M1357911', 'MO463526', '2020-11-20 09:32:12', '2020-11-23 05:58:12', '2020-11-27 09:32:12')

insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES35487', 'M9999999', 'R5789343', '2019-04-14 10:34:56', '2019-04-18 10:34:56')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES43827', 'M9999999', 'R5789343', '2019-05-13 09:39:32', '2019-05-15 09:39:32')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES23786', 'M9999999', 'R6879348', '2020-08-28 06:45:19', '2020-09-01 06:45:19')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES75654', 'M9999999', 'R6879348', '2020-05-01 06:45:19', '2020-09-01 06:45:19')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES56464', 'M9999999', 'R6879348', '2020-06-05 06:45:19', '2020-09-01 06:45:19')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES64564', 'M9999999', 'R6879348', '2020-09-19 06:45:19', '2020-09-25 06:45:19')
insert into reservation(ReservationID, MemberID, ResourceID, dateTimeReserved, dateTimeDue) values('RES64565', 'M9999999', 'R6879348', '2020-09-19 06:45:19', '2020-09-25 06:45:19')


--Q1
select m.name Student_who_enrolled_in_COUR0001 from course c join student s
on c.StudentID = s.StudentID join member m on s.MemberID = m.MemberID
where courseID like 'COUR0001'

--Q2
select m.name, p.maxResourceBorrow maximum_number_of_speakers_can_borrow from category ca join privilege p
on ca.PrivilegeID = p.PrivilegeID join course c on p.OfferingID = c.OfferingID
join student s on c.StudentID = s.StudentID join member m on s.MemberID = m.MemberID
where courseID like 'COUR0001'

--Q3
select m.name, m.phone, count(a.MemberID) as number_of_acquisition_requests, count(r.MemberID) as number_of_reservations_in_2019 from reservation r join member m
on r.MemberID = m.MemberID join acquisition a on m.MemberID = a.MemberID
join staff s on m.MemberID = s.MemberID
where s.StaffID like 'STA13013'
group by m.name, m.phone

--Q4
select m.name name_of_student_who_has_borrowed_camera from loan l join member m
on l.MemberID = m.MemberID join movable mo on l.MovableID = mo.MovableID
join category c on mo.ResourceID = c.ResourceID join student st on m.MemberID = st.MemberID
where c.name like 'camera'
group by m.name, mo.model, mo.year
having mo.model like 'pinpoint' and mo.year like '2020'

--Q5
select r.ResourceID, count(r.description) as name_of_resource_most_loaned_in_this_month from loan l join movable mo
on l.MovableID = mo.MovableID join resource r on mo.ResourceID = r.ResourceID
where month(getdate()) = month(l.dateTimeBorrowed)
group by r.ResourceID, r.description
order by name_of_resource_most_loaned_in_this_month desc

--Q6
select convert(varchar(10), r.dateTimeReserved, 111) as date, loc.Room, count(r.dateTimeReserved) as amount_of_reservations_on_date from reservation r join location loc
on r.ResourceID = loc.ResourceID
where convert(varchar(10), r.dateTimeReserved, 111) like '2020/06/05' or convert(varchar(10), r.dateTimeReserved, 111) like '2020/05/01' or convert(varchar(10), r.dateTimeReserved, 111) like '2020/09/19'
group by r.dateTimeReserved, loc.Room
