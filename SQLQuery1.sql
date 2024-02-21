
CREATE DATABASE Course2

USE Course2

CREATE TABLE Groups
(
	Id INT PRIMARY KEY IDENTITY,
	Name NVARCHAR(20),
)
ALTER TABLE Groups
Add IsDeleted NVARCHAR(10) DEFAULT 'false'

CREATE TABLE Students
(
	Id INT PRIMARY KEY IDENTITY,
	FullName NVARCHAR(30),
	GroupId INT FOREIGN KEY REFERENCES Groups(Id)
)

SELECT*FROM Groups

INSERT INTO Groups(Name)
VALUES
('PB302'),
('P138'),
('Q140'),
('M345'),
('A100'),
('K500')



SELECT*FROM Students

INSERT INTO Students
VALUES
('Elmar Qarayev',1),
('Dvud Eliyev',4),
('Cavid Ismayilzadeh',4),
('Shaiq Kazmivov',1),
('Mubariz Aghayev',3),
('Ibrahim Abdullayev',5),
('Anar Ismayillov',6),
('Samir Xancanov',2),
('Aqsin Humbetov',2),
('Mirze Bulbule',5),
('Elekber Ismayilov Qarayev',6)

--Student datası silindikdə DeletedStudents table-na əlavə olsun avtomatik (trigger yazın)

CREATE TABLE DeletedStudent
(
	Id INT,
	FullName NVARCHAR(30),
	GroupId INT
)


CREATE TRIGGER TR_DeletedStudents ON dbo.Students
FOR DELETE
AS
INSERT INTO DeletedStudent(Id,FullName,GroupId)
SELECT D.Id,D.FullName,D.GroupId FROM deleted D
JOIN Groups AS G ON G.Id = D.GroupId


SELECT*FROM Students
SELECT *FROM DeletedStudent

DELETE FROM Students WHERE Id = 11




--Group datalarının IsDeleted column-u olsun və defauk false olsun. 
--Bir group datası silinmək istədikdə onun db-dan silinməsinin yerinə o 
--datanın IsDeleted dəyəri dəyişib true olsun (trigger yazın instead of ilə)

CREATE TABLE DeletedGroup
(
	Id INT,
	Name NVARCHAR(30)
)

CREATE TRIGGER TR_DeletedStudentsInstead ON dbo.Groups
INSTEAD OF DELETE
AS
UPDATE g  SET IsDeleted = 'true' FROM Groups g
INNER JOIN deleted d ON g.Id = d.Id;
INSERT INTO DeletedGroup (Id, Name) SELECT Id, Name FROM deleted;



SELECT*FROM Groups
DELETE FROM Groups WHERE Id = 1

SELECT *FROM DeletedGroup



