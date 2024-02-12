//CREATION OF TABLES:
create table team(
TID int primary key, 
Name varchar2(50) unique, 
Debut_year int, 
Team_Principal varchar2(30),
Points int default NULL
);

create table driver(
TID int,
DID int primary key, 
dname varchar2(30), 
dpoints int, 
role varchar2(30), 
ICE int,
MGU_H int,
MGU_K int,
Turbocharger int,
ES int,
CE int,
Exhaust int, 
foreign key(TID) references team(TID) on delete SET NULL
);

create table Engine(
EID int primary key,
TID int,
Ename varchar2(30),
foreign key(TID) references team(TID) on delete SET NULL
);

create table engineers(
EID int primary key,
Ename varchar2(30),
DID int,
foreign key(DID) references driver(DID) on delete SET NULL
);

create table race(
Circuit varchar2(30),
Winner int, 
foreign key(Winner) references driver(DID) on delete SET NULL
);

//INSERTION OF DATA:
insert into team values(1,'Red Bull Racing',2005,'Christian Horner',123);
insert into team values(2,'Aston Martin',2021,'Mike Krack',65);
insert into team values(3,'Mercedes',2010,'Toto Wolff',56);
insert into team values(4,'Scuderia Ferrari',1950,'Fred Vasseur',26);
insert into team values(5,'Alpine',2020,'Otmar Szafnauer',8);
insert into team values(6,'Alpha Tauri',2020,'Franz Tost',1);
insert into team values(7,'Alfa Romeo',1950,'Alessandro Alunni Bravi',6);
insert into team values(8,'Haas',2016,'Guenther Steiner',7);
insert into team values(9,'Williams',1977,'James Vowles',1);
insert into team values(10,'Mclaren',1966,'Andrea Stella',12);

insert into driver values(1,1,'Max Verstappen',69,'In car',3,3,3,3,2,2,8);
insert into driver values(1,11,'Sergio Perez',54,'In car',3,3,3,3,2,2,8);
insert into driver values(2,14,'Fernando Alonso',45,'In car',3,3,3,3,2,2,8);
insert into driver values(3,44,'Lewis Hamilton',38,'In car',3,3,3,3,2,2,8);
insert into driver values(4,55,'Carlos Sainz',20,'In car',3,3,3,3,2,2,8);
insert into driver values(2,18,'Lance Stroll',20,'In car',3,3,3,3,2,2,8);
insert into driver values(3,63,'George Russell',18,'In car',3,3,3,3,2,2,8);
insert into driver values(10,4,'Lando Norris',8,'In car',3,3,3,3,2,2,8);
insert into driver values(8,27,'Nico Hulkenberg',6,'In car',3,3,3,3,2,2,8);
insert into driver values(4,16,'Charles Leclerc',6,'In car',3,3,3,3,2,2,8);
insert into driver values(7,77,'Valtteri Bottas',4,'In car',3,3,3,3,2,2,8);
insert into driver values(5,31,'Esteban Ocon',4,'In car',3,3,3,3,2,2,8);
insert into driver values(10,81,'Oscar Piastri',4,'In car',3,3,3,3,2,2,8);
insert into driver values(5,10,'Pierre Gasly',4,'In car',3,3,3,3,2,2,8);
insert into driver values(7,24,'Zhou Guanyu',2,'In car',3,3,3,3,2,2,8);
insert into driver values(6,22,'Yuki Tsunoda',1,'In car',3,3,3,3,2,2,8);
insert into driver values(8,20,'Kevin Magnussen',1,'In car',3,3,3,3,2,2,8);
insert into driver values(9,23,'Alex Albon',1,'In car',3,3,3,3,2,2,8);
insert into driver values(9,2,'Logan Sargeant',0,'In car',3,3,3,3,2,2,8);
insert into driver values(6,41,'Nyck de Vries',0,'In car',3,3,3,3,2,2,8);

insert into engine values(1,1,'Red Bull Powertrains');
insert into engine values(2,2,'Mercedes');
insert into engine values(3,3,'Mercedes');
insert into engine values(4,4,'Ferrari');
insert into engine values(5,5,'Renault');
insert into engine values(6,6,'Honda');
insert into engine values(7,7,'Ferrari');
insert into engine values(8,8,'Ferrari');
insert into engine values(9,9,'Mercedes');
insert into engine values(10,10,'Mercedes');


insert into engineers values(1,'Gianpiero Lambiase',1);
insert into engineers values(2,'Hugh Bird',11);
insert into engineers values(3,'Xavier Marcos Padros',16);
insert into engineers values(4,'Riccardo Adami',55);
insert into engineers values(5,'Peter Bonnington',44);
insert into engineers values(6,'Riccardo Musconi',63);
insert into engineers values(7,'Josh Peckett',31);
insert into engineers values(8,'Karel Loos',10);
insert into engineers values(9,'William Joseph',4);
insert into engineers values(10,'Tom Stallard',81);
insert into engineers values(11,'Alex Chan',77);
insert into engineers values(12,'Jorn Becker',24);
insert into engineers values(13,'Ben Michell',18);
insert into engineers values(14,'Chris Cronin',14);
insert into engineers values(15,'Mark Slade',20);
insert into engineers values(16,'Gary Gannon',27);
insert into engineers values(17,'Mattia Spini',22);
insert into engineers values(18,'Pierre Hamelin',41);
insert into engineers values(19,'James Urwin',23);
insert into engineers values(20,'Gaetan Jego',2);


insert into race values('Bahrain','1');
insert into race values('Saudi Arabia','11');
insert into race values('Melbourne','1');


//PROCEDURES
create or replace procedure addpoints(a number, b number)
is 
begin
update team set points = b + (select points from team where tid = (select tid from driver where did = a)) where tid = (select tid from driver where did = a);
update driver set dpoints = b + (select dpoints from driver where did = a) where did = a;
end addpoints;
declare
a number;
b number;
begin
a:=1;
b:=18;
addpoints(a,b);
End;


create or replace procedure ppoints(id number ,thispoints number)
is 
begin
update driver set dpoints = dpoints+ thispoints where did = id;
update team set points = points+ thispoints where tid = id;
end ppoints;
declare
id number;
points number;
begin
id:=2;
points:=20;
ppoints(id,points);
End;


create or replace procedure delengine (id int)
as 
begin
delete from engine where tid = id;
end delengine;
declare
id int;
begin
id:=10;
delengine(10);
End;


CREATE OR REPLACE PROCEDURE GET_TEAM_POINTS(TID IN NUMBER, POINTS_OUT OUT NUMBER) AS
BEGIN
  SELECT SUM(DPOINTS) INTO POINTS_OUT FROM DRIVER WHERE TID = TID;
END GET_TEAM_POINTS;
DECLARE
  team_id NUMBER := 4;
  points NUMBER;
BEGIN
  GET_TEAM_POINTS(team_id, points);
  DBMS_OUTPUT.PUT_LINE('Team ' || team_id || ' has ' || points || ' points.');
END;


create or replace procedure deleteteam (id int)
is begin
delete from team where tid = id;
delete from engine where eid = id;
delete from engineers where did = (select did from driver where tid = id);
delete from race where winner = (select did from driver where tid = id);
end deleteteam;
declare
id int;
begin
id:= 10;
deleteteam(id);
end;


create or replace procedure reducemgu_h(id int)
is 
begin
update driver set mgu_h = (select mgu_h from driver where did = id) -  1 where did = id;
end reducemgu_h;
declare
id int;
lim exception;
our int;
begin
id:=1;
reducemgu_h(id);
select mgu_h into our from driver where did = id;
if our < 1 then
    raise lim;
end if;
exception 
    when lim then
    dbms_output.put_line('Careful next component usage will result in penalty!!');
End;


//CURSORS
DECLARE
  CURSOR team_cursor IS
    SELECT Name, Debut_year FROM team;
BEGIN
  FOR team_rec IN team_cursor LOOP
    DBMS_OUTPUT.PUT_LINE(team_rec.Name || ' - Debut year: ' || team_rec.Debut_year);
  END LOOP;
END;
DECLARE 
  CURSOR dri_rec IS SELECT dname, tid FROM driver;
BEGIN
  FOR cur IN dri_rec LOOP
    dbms_output.put_line(cur.dname || ' :- ' || cur.tid);
  END LOOP;
END;


DECLARE
  v_max_points driver.dpoints%TYPE;
  CURSOR c_max_points IS
    SELECT MAX(dpoints) AS max_points FROM driver;
BEGIN
  OPEN c_max_points;
  FETCH c_max_points INTO v_max_points;
  DBMS_OUTPUT.PUT_LINE('The maximum points scored by any driver is ' || v_max_points);
  CLOSE c_max_points;
END;


DECLARE
  CURSOR c_drivers IS
    SELECT dname, dpoints
    FROM driver
    WHERE dpoints > 50;
  v_name driver.dname%TYPE;
  v_points driver.dpoints%TYPE;
BEGIN
  OPEN c_drivers;
  LOOP
    FETCH c_drivers INTO v_name, v_points;
    EXIT WHEN c_drivers%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_name || ' has ' || v_points || ' points');
  END LOOP;
  CLOSE c_drivers;
END;


//FUNCTIONS
CREATE OR REPLACE FUNCTION average_points_of_team(tid in number)
  RETURN NUMBER
IS
  total_points NUMBER;
  num_drivers NUMBER;
  avg_points NUMBER;
BEGIN
  SELECT SUM(dpoints), COUNT(did) INTO total_points, num_drivers
  FROM driver
  WHERE tid = tid;
  avg_points := total_points / num_drivers;
  RETURN avg_points;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Team not found');
    RETURN NULL;
END;
DECLARE
  team_avg_points NUMBER;
	tid number;
BEGIN
    tid:=1;
  team_avg_points := average_points_of_team(tid);
  DBMS_OUTPUT.PUT_LINE('Team average points: ' || team_avg_points);
END;


CREATE OR REPLACE FUNCTION get_top_driver_in_team (team_name IN VARCHAR2) RETURN VARCHAR2 AS
  driver_name VARCHAR2(30);
BEGIN
  SELECT dname INTO driver_name FROM driver WHERE tid = (SELECT tid FROM team WHERE name = team_name) AND dpoints = (SELECT MAX(dpoints) FROM driver WHERE tid = (SELECT tid FROM team WHERE name = team_name));
  RETURN driver_name;
END;
DECLARE
  top_driver VARCHAR2(30);
	team varchar2(20);
BEGIN
    team:='Mercedes';
  top_driver := get_top_driver_in_team(team);
  DBMS_OUTPUT.PUT_LINE('The top driver in team ' || team || ' is ' || top_driver);
END; 


//TRIGGERS
CREATE OR REPLACE TRIGGER max_drivers_per_team
BEFORE INSERT ON driver
FOR EACH ROW
DECLARE
   l_driver_count NUMBER;
BEGIN
   SELECT COUNT(*)
   INTO l_driver_count
   FROM driver
   WHERE TID = :NEW.TID;
   
   IF l_driver_count >= 2 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Team already has the maximum number of drivers allowed');
   END IF;
END;
DECLARE
    tid driver.tid%TYPE;
	did driver.did%TYPE;
	dname driver.dname%TYPE; 
BEGIN
   tid := 3;
   did:=99;
   dname := 'Anhad Sharma';
   INSERT INTO driver(tid,did,dname)
   VALUES(tid,did,dname);
END;
