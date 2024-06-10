CREATE TABLE regions (
    region_id integer  NOT NULL,
    region_name VARCHAR(25),
    PRIMARY KEY (region_id)
    );

CREATE TABLE countries (
    country_id CHAR(2) NOT NULL,
    country_name VARCHAR(40),
    region_id INTEGER NOT NULL,
    PRIMARY KEY (country_id),
    CONSTRAINT countries_regions_region_id FOREIGN KEY (region_id) REFERENCES regions(region_id)
    );
    
CREATE TABLE locations (
    location_id SERIAL  NOT NULL,
    street_address VARCHAR(40),
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(25),
    country_id CHAR(2) NOT NULL,
    PRIMARY KEY (location_id),
    CONSTRAINT locations_countries_country_id FOREIGN KEY (country_id) REFERENCES countries(country_id)
    );

CREATE TABLE departments (
    department_id INTEGER  NOT NULL CHECK (department_id>0),
    department_name VARCHAR(30) NOT NULL,
    manager_id INTEGER CHECK (manager_id>0),
    location_id INTEGER CHECK (location_id>0),
    PRIMARY KEY (department_id),
    CONSTRAINT departments_locations_location_id FOREIGN KEY (location_id) REFERENCES locations(location_id)
    );

CREATE TABLE jobs (
    job_id VARCHAR(10) NOT NULL,
    job_title VARCHAR(35) NOT NULL,
    min_salary DECIMAL(8, 0) CHECK (min_salary>0),
    max_salary DECIMAL(8, 0) CHECK (max_salary>0),
    PRIMARY KEY (job_id)
    );

CREATE TABLE employees (
    employee_id INTEGER NOT NULL CHECK (employee_id>0) ,
    first_name VARCHAR(20),
    last_name VARCHAR(25) NOT NULL,
    email VARCHAR(25) NOT NULL,
    phone_number VARCHAR(20),
    hire_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    salary DECIMAL(8, 2) NOT NULL,
    commission_pct DECIMAL(2, 2),
    manager_id INTEGER CHECK (manager_id>0),
    department_id INTEGER CHECK (department_id>0),
    PRIMARY KEY (employee_id),
    CONSTRAINT employees_jobs_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT employees_departments_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT employees_manager_employee_id FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
    );

ALTER TABLE departments ADD FOREIGN KEY (manager_id) REFERENCES employees (employee_id);

CREATE TABLE job_history (
    employee_id INTEGER  NOT NULL CHECK (employee_id>0),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    job_id VARCHAR(10) NOT NULL,
    department_id INTEGER  NOT NULL CHECK (department_id>0),
    CONSTRAINT job_history_employees_employee_id FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    CONSTRAINT job_history_jobs_job_id FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    CONSTRAINT job_history_departments_department_id FOREIGN KEY (department_id) REFERENCES departments(department_id)
    );
    
INSERT INTO regions
VALUES (1,'Europe'),
(2,'Americas'),
(3,'Asia'),
(4,'Middle East and Africa');

COMMIT;

select * from regions;

INSERT INTO countries VALUES
('IT','Italy',1),
('JP','Japan',3),
('US','United States of America',2),
('CA','Canada',2),
('CN','China',3),
('IN','India',3),
('AU','Australia',3),
('ZW','Zimbabwe',4),
('SG','Singapore',3),
('UK','United Kingdom',1),
('FR','France',1),
('DE','Germany',1),
('ZM','Zambia',4),
('EG','Egypt',4),
('BR','Brazil',2),
('CH','Switzerland',1),
('NL','Netherlands',1),
('MX','Mexico',2),
('KW','Kuwait',4),
('IL','Israel',4),
('DK','Denmark',1),
('HK','HongKong',3),
('NG','Nigeria',4),
('AR','Argentina',2),
('BE','Belgium',1);

COMMIT;

select * from locations;

INSERT INTO locations VALUES
(1000,'1297 Via Cola di Rie','00989','Roma',NULL,'IT'),
(1100,'93091 Calle della Testa','10934','Venice',NULL,'IT'),
(1200,'2017 Shinjuku-ku','1689','Tokyo','Tokyo Prefecture','JP'),
(1300,'9450 Kamiya-cho','6823','Hiroshima',NULL,'JP'),
(1400,'2014 Jabberwocky Rd','26192','Southlake','Texas','US'),
(1500,'2011 Interiors Blvd','99236','South San Francisco','California','US'),
(1600,'2007 Zagora St','50090','South Brunswick','New Jersey','US'),
(1700,'2004 Charade Rd','98199','Seattle','Washington','US'),
(1800,'147 Spadina Ave','M5V 2L7','Toronto','Ontario','CA'),
(1900,'6092 Boxwood St','YSW 9T2','Whitehorse','Yukon','CA'),
(2000,'40-5-12 Laogianggen','190518','Beijing',NULL,'CN'),
(2100,'1298 Vileparle (E)','490231','Bombay','Maharashtra','IN'),
(2200,'12-98 Victoria Street','2901','Sydney','New South Wales','AU'),
(2300,'198 Clementi North','540198','Singapore',NULL,'SG'),
(2400,'8204 Arthur St',NULL,'London',NULL,'UK'),
(2500,'Magdalen Centre, The Oxford Science Park','OX9 9ZB','Oxford','Oxford','UK'),
(2600,'9702 Chester Road','09629850293','Stretford','Manchester','UK'),
(2700,'Schwanthalerstr. 7031','80925','Munich','Bavaria','DE'),
(2800,'Rua Frei Caneca 1360 ','01307-002','Sao Paulo','Sao Paulo','BR'),
(2900,'20 Rue des Corps-Saints','1730','Geneva','Geneve','CH'),
(3000,'Murtenstrasse 921','3095','Bern','BE','CH'),
(3100,'Pieter Breughelstraat 837','3029SK','Utrecht','Utrecht','NL'),
(3200,'Mariano Escobedo 9991','11932','Mexico City','Distrito Federal,','MX');

COMMIT;

ALTER TABLE departments DISABLE TRIGGER ALL;

INSERT INTO departments VALUES
(10,'Administration',200,1700),
(20,'Marketing',201,1800),
(30,'Purchasing',114,1700),
(40,'Human Resources',203,2400),
(50,'Shipping',121,1500),
(60,'IT',103,1400),
(70,'Public Relations',204,2700),
(80,'Sales',145,2500),
(90,'Executive',100,1700),
(100,'Finance',108,1700),
(110,'Accounting',205,1700),
(120,'Treasury',NULL,1700),
(130,'Corporate Tax',NULL,1700),
(140,'Control And Credit',NULL,1700),
(150,'Shareholder Services',NULL,1700),
(160,'Benefits',NULL,1700),
(170,'Manufacturing',NULL,1700),
(180,'Construction',NULL,1700),
(190,'Contracting',NULL,1700),
(200,'Operations',NULL,1700),
(210,'IT Support',NULL,1700),
(220,'NOC',NULL,1700),
(230,'IT Helpdesk',NULL,1700),
(240,'Government Sales',NULL,1700),
(250,'Retail Sales',NULL,1700),
(260,'Recruiting',NULL,1700),
(270,'Payroll',NULL,1700);

COMMIT;

select * from jobs;

ALTER TABLE departments ENABLE TRIGGER ALL;
/****/

INSERT INTO jobs VALUES
('AD_PRES','President',20000,40000),
('AD_VP','Administration Vice President',15000,30000),
('AD_ASST','Administration Assistant',3000,6000),
('FI_MGR','Finance Manager',8200,16000),
('FI_ACCOUNT','Accountant',4200,9000),
('AC_MGR','Accounting Manager',8200,16000),
('AC_ACCOUNT','Public Accountant',4200,9000),
('SA_MAN','Sales Manager',10000,20000),
('SA_REP','Sales Representative',6000,12000),
('PU_MAN','Purchasing Manager',8000,15000),
('PU_CLERK','Purchasing Clerk',2500,5500),
('ST_MAN','Stock Manager',5500,8500),
('ST_CLERK','Stock Clerk',2000,5000),
('SH_CLERK','Shipping Clerk',2500,5500),
('IT_PROG','Programmer',4000,10000),
('MK_MAN','Marketing Manager',9000,15000),
('MK_REP','Marketing Representative',4000,9000),
('HR_REP','Human Resources Representative',4000,9000),
('PR_REP','Public Relations Representative',4500,10500);

COMMIT;

select * from employees;

INSERT INTO employees VALUES
(100,'Steven','King','SKING','515.123.4567',TO_DATE('17-JUN-1987', 'dd-Mon-YYYY'),'AD_PRES',24000,NULL,NULL,90),
(101,'Neena','Kochhar','NKOCHHAR','515.123.4568',TO_DATE('21-SEP-1989', 'dd-Mon-YYYY'),'AD_VP',17000,NULL,100,90),
(102,'Lex','De Haan','LDEHAAN','515.123.4569',TO_DATE('13-JAN-1993', 'dd-Mon-YYYY'),'AD_VP',17000,NULL,100,90),
(103,'Alexander','Hunold','AHUNOLD','590.423.4567',TO_DATE('03-JAN-1990', 'dd-Mon-YYYY'),'IT_PROG',9000,NULL,102,60),
(104,'Bruce','Ernst','BERNST','590.423.4568',TO_DATE('21-MAY-1991', 'dd-Mon-YYYY'),'IT_PROG',6000,NULL,103,60),
(105,'David','Austin','DAUSTIN','590.423.4569',TO_DATE('25-JUN-1997', 'dd-Mon-YYYY'),'IT_PROG',4800,NULL,103,60),
(106,'Valli','Pataballa','VPATABAL','590.423.4560',TO_DATE('05-FEB-1998', 'dd-Mon-YYYY'),'IT_PROG',4800,NULL,103,60),
(107,'Diana','Lorentz','DLORENTZ','590.423.5567',TO_DATE('07-FEB-1999', 'dd-Mon-YYYY'),'IT_PROG',4200,NULL,103,60),
(108,'Nancy','Greenberg','NGREENBE','515.124.4569',TO_DATE('17-AUG-1994', 'dd-Mon-YYYY'),'FI_MGR',16000,NULL,101,100),
(109,'Daniel','Faviet','DFAVIET','515.124.4169',TO_DATE('16-AUG-1994', 'dd-Mon-YYYY'),'FI_ACCOUNT',9000,NULL,108,100),
(110,'John','Chen','JCHEN','515.124.4269',TO_DATE('28-SEP-1997', 'dd-Mon-YYYY'),'FI_ACCOUNT',8200,NULL,108,100),
(111,'Ismael','Sciarra','ISCIARRA','515.124.4369',TO_DATE('30-SEP-1997', 'dd-Mon-YYYY'),'FI_ACCOUNT',7700,NULL,108,100),
(112,'Jose Manuel','Urman','JMURMAN','515.124.4469',TO_DATE('07-MAR-1998', 'dd-Mon-YYYY'),'FI_ACCOUNT',7800,NULL,108,100),
(113,'Luis','Popp','LPOPP','515.124.4567',TO_DATE('07-DEC-1999', 'dd-Mon-YYYY'),'FI_ACCOUNT',6900,NULL,108,100),
(114,'Den','Raphaely','DRAPHEAL','515.127.4561',TO_DATE('07-DEC-1994', 'dd-Mon-YYYY'),'PU_MAN',11000,NULL,100,30),
(115,'Alexander','Khoo','AKHOO','515.127.4562',TO_DATE('18-MAY-1995', 'dd-Mon-YYYY'),'PU_CLERK',3100,NULL,114,30),
(116,'Shelli','Baida','SBAIDA','515.127.4563',TO_DATE('24-DEC-1997', 'dd-Mon-YYYY'),'PU_CLERK',2900,NULL,114,30),
(117,'Sigal','Tobias','STOBIAS','515.127.4564',TO_DATE('24-JUL-1997', 'dd-Mon-YYYY'),'PU_CLERK',16000,NULL,114,30),
(118,'Guy','Himuro','GHIMURO','515.127.4565',TO_DATE('15-NOV-1998', 'dd-Mon-YYYY'),'PU_CLERK',2600,NULL,114,30),
(119,'Karen','Colmenares','KCOLMENA','515.127.4566',TO_DATE('10-AUG-1999', 'dd-Mon-YYYY'),'PU_CLERK',2500,NULL,114,30),
(120,'Matthew','Weiss','MWEISS','650.123.1234',TO_DATE('18-JUL-1996', 'dd-Mon-YYYY'),'ST_MAN',8000,NULL,100,50),
(121,'Adam','Fripp','AFRIPP','650.123.2234',TO_DATE('10-APR-1997', 'dd-Mon-YYYY'),'ST_MAN',8200,NULL,100,50),
(122,'Payam','Kaufling','PKAUFLIN','650.123.3234',TO_DATE('01-MAY-1995', 'dd-Mon-YYYY'),'ST_MAN',7900,NULL,100,50),
(123,'Shanta','Vollman','SVOLLMAN','650.123.4234',TO_DATE('10-OCT-1997', 'dd-Mon-YYYY'),'ST_MAN',6500,NULL,100,50),
(124,'Kevin','Mourgos','KMOURGOS','650.123.5234',TO_DATE('16-NOV-1999', 'dd-Mon-YYYY'),'ST_MAN',5800,NULL,100,50),
(125,'Julia','Nayer','JNAYER','650.124.1214',TO_DATE('16-JUL-1997', 'dd-Mon-YYYY'),'ST_CLERK',3200,NULL,120,50),
(126,'Irene','Mikkilineni','IMIKKILI','650.124.1224',TO_DATE('28-SEP-1998', 'dd-Mon-YYYY'),'ST_CLERK',2700,NULL,120,50),
(127,'James','Landry','JLANDRY','650.124.1334',TO_DATE('14-JAN-1999', 'dd-Mon-YYYY'),'ST_CLERK',2400,NULL,120,50),
(128,'Steven','Markle','SMARKLE','650.124.1434',TO_DATE('08-MAR-2000', 'dd-Mon-YYYY'),'ST_CLERK',2200,NULL,120,50),
(129,'Laura','Bissot','LBISSOT','650.124.5234',TO_DATE('20-AUG-1997', 'dd-Mon-YYYY'),'ST_CLERK',3300,NULL,121,50),
(130,'Mozhe','Atkinson','MATKINSO','650.124.6234',TO_DATE('30-OCT-1997', 'dd-Mon-YYYY'),'ST_CLERK',2800,NULL,121,50),
(131,'James','Marlow','JAMRLOW','650.124.7234',TO_DATE('16-FEB-1997', 'dd-Mon-YYYY'),'ST_CLERK',2500,NULL,121,50),
(132,'TJ','Olson','TJOLSON','650.124.8234',TO_DATE('10-APR-1999', 'dd-Mon-YYYY'),'ST_CLERK',2100,NULL,121,50),
(133,'Jason','Mallin','JMALLIN','650.127.1934',TO_DATE('14-JUN-1996', 'dd-Mon-YYYY'),'ST_CLERK',3300,NULL,122,50),
(134,'Michael','Rogers','MROGERS','650.127.1834',TO_DATE('26-AUG-1998', 'dd-Mon-YYYY'),'ST_CLERK',2900,NULL,122,50),
(135,'Ki','Gee','KGEE','650.127.1734',TO_DATE('12-DEC-1999', 'dd-Mon-YYYY'),'ST_CLERK',2400,NULL,122,50),
(136,'Hazel','Philtanker','HPHILTAN','650.127.1634',TO_DATE('06-FEB-2000', 'dd-Mon-YYYY'),'ST_CLERK',2200,NULL,122,50),
(137,'Renske','Ladwig','RLADWIG','650.121.1234',TO_DATE('14-JUL-1995', 'dd-Mon-YYYY'),'ST_CLERK',3600,NULL,123,50),
(138,'Stephen','Stiles','SSTILES','650.121.2034',TO_DATE('26-OCT-1997', 'dd-Mon-YYYY'),'ST_CLERK',3200,NULL,123,50),
(139,'John','Seo','JSEO','650.121.2019',TO_DATE('12-FEB-1998', 'dd-Mon-YYYY'),'ST_CLERK',2700,NULL,123,50),
(140,'Joshua','Patel','JPATEL','650.121.1834',TO_DATE('06-APR-1998', 'dd-Mon-YYYY'),'ST_CLERK',2500,NULL,123,50),
(141,'Trenna','Rajs','TRAJS','650.121.8009',TO_DATE('17-OCT-1995', 'dd-Mon-YYYY'),'ST_CLERK',3500,NULL,124,50),
(142,'Curtis','Davies','CDAVIES','650.121.2994',TO_DATE('29-JAN-1997', 'dd-Mon-YYYY'),'ST_CLERK',3100,NULL,124,50),
(143,'Randall','Matos','RMATOS','650.121.2874',TO_DATE('15-MAR-1998', 'dd-Mon-YYYY'),'ST_CLERK',2600,NULL,124,50),
(144,'Peter','Vargas','PVARGAS','650.121.2004',TO_DATE('09-JUL-1998', 'dd-Mon-YYYY'),'ST_CLERK',2500,NULL,124,50),
(145,'John','Russell','JRUSSEL','011.44.1344.429268',TO_DATE('01-OCT-1996', 'dd-Mon-YYYY'),'SA_MAN',14000,.4,100,80),
(146,'Karen','Partners','KPARTNER','011.44.1344.467268',TO_DATE('05-JAN-1997', 'dd-Mon-YYYY'),'SA_MAN',13500,.3,100,80),
(147,'Alberto','Errazuriz','AERRAZUR','011.44.1344.429278',TO_DATE('10-MAR-1997', 'dd-Mon-YYYY'),'SA_MAN',12000,.3,100,80),
(148,'Gerald','Cambrault','GCAMBRAU','011.44.1344.619268',TO_DATE('15-OCT-1999', 'dd-Mon-YYYY'),'SA_MAN',11000,.3,100,80),
(149,'Eleni','Zlotkey','EZLOTKEY','011.44.1344.429018',TO_DATE('29-JAN-2000', 'dd-Mon-YYYY'),'SA_MAN',10500,.2,100,80),
(150,'Peter','Tucker','PTUCKER','011.44.1344.129268',TO_DATE('30-JAN-1997', 'dd-Mon-YYYY'),'SA_REP',10000,.3,145,80),
(151,'David','Bernstein','DBERNSTE','011.44.1344.345268',TO_DATE('24-MAR-1997', 'dd-Mon-YYYY'),'SA_REP',9500,.25,145,80),
(152,'Peter','Hall','PHALL','011.44.1344.478968',TO_DATE('20-AUG-1997', 'dd-Mon-YYYY'),'SA_REP',9000,.25,145,80),
(153,'Christopher','Olsen','COLSEN','011.44.1344.498718',TO_DATE('30-MAR-1998', 'dd-Mon-YYYY'),'SA_REP',8000,.2,145,80),
(154,'Nanette','Cambrault','NCAMBRAU','011.44.1344.987668',TO_DATE('09-DEC-1998', 'dd-Mon-YYYY'),'SA_REP',7500,.2,145,80),
(155,'Oliver','Tuvault','OTUVAULT','011.44.1344.486508',TO_DATE('23-NOV-1999', 'dd-Mon-YYYY'),'SA_REP',7000,.15,145,80),
(156,'Janette','King','JKING','011.44.1345.429268',TO_DATE('30-JAN-1996', 'dd-Mon-YYYY'),'SA_REP',10000,.35,146,80),
(157,'Patrick','Sully','PSULLY','011.44.1345.929268',TO_DATE('04-MAR-1996', 'dd-Mon-YYYY'),'SA_REP',9500,.35,146,80),
(158,'Allan','McEwen','AMCEWEN','011.44.1345.829268',TO_DATE('01-AUG-1996', 'dd-Mon-YYYY'),'SA_REP',9000,.35,146,80),
(159,'Lindsey','Smith','LSMITH','011.44.1345.729268',TO_DATE('10-MAR-1997', 'dd-Mon-YYYY'),'SA_REP',8000,.3,146,80),
(160,'Louise','Doran','LDORAN','011.44.1345.629268',TO_DATE('15-DEC-1997', 'dd-Mon-YYYY'),'SA_REP',7500,.3,146,80),
(161,'Sarath','Sewall','SSEWALL','011.44.1345.529268',TO_DATE('03-NOV-1998', 'dd-Mon-YYYY'),'SA_REP',7000,.25,146,80),
(162,'Clara','Vishney','CVISHNEY','011.44.1346.129268',TO_DATE('11-NOV-1997', 'dd-Mon-YYYY'),'SA_REP',10500,.25,147,80),
(163,'Danielle','Greene','DGREENE','011.44.1346.229268',TO_DATE('19-MAR-1999', 'dd-Mon-YYYY'),'SA_REP',9500,.15,147,80),
(164,'Mattea','Marvins','MMARVINS','011.44.1346.329268',TO_DATE('24-JAN-2000', 'dd-Mon-YYYY'),'SA_REP',7200,.10,147,80),
(165,'David','Lee','DLEE','011.44.1346.529268',TO_DATE('23-FEB-2000', 'dd-Mon-YYYY'),'SA_REP',6800,.1,147,80),
(166,'Sundar','Ande','SANDE','011.44.1346.629268',TO_DATE('24-MAR-2000', 'dd-Mon-YYYY'),'SA_REP',6400,.10,147,80),
(167,'Amit','Banda','ABANDA','011.44.1346.729268',TO_DATE('21-APR-2000', 'dd-Mon-YYYY'),'SA_REP',6200,.10,147,80),
(168,'Lisa','Ozer','LOZER','011.44.1343.929268',TO_DATE('11-MAR-1997', 'dd-Mon-YYYY'),'SA_REP',11500,.25,148,80),
(169,'Harrison','Bloom','HBLOOM','011.44.1343.829268',TO_DATE('23-MAR-1998', 'dd-Mon-YYYY'),'SA_REP',10000,.20,148,80),
(170,'Tayler','Fox','TFOX','011.44.1343.729268',TO_DATE('24-JAN-1998', 'dd-Mon-YYYY'),'SA_REP',9600,.20,148,80),
(171,'William','Smith','WSMITH','011.44.1343.629268',TO_DATE('23-FEB-1999', 'dd-Mon-YYYY'),'SA_REP',7400,.15,148,80),
(172,'Elizabeth','Bates','EBATES','011.44.1343.529268',TO_DATE('24-MAR-1999', 'dd-Mon-YYYY'),'SA_REP',7300,.15,148,80),
(173,'Sundita','Kumar','SKUMAR','011.44.1343.329268',TO_DATE('21-APR-2000', 'dd-Mon-YYYY'),'SA_REP',6100,.10,148,80),
(174,'Ellen','Abel','EABEL','011.44.1644.429267',TO_DATE('11-MAY-1996', 'dd-Mon-YYYY'),'SA_REP',11000,.30,149,80),
(175,'Alyssa','Hutton','AHUTTON','011.44.1644.429266',TO_DATE('19-MAR-1997', 'dd-Mon-YYYY'),'SA_REP',9000,.25,149,80),
(176,'Jonathon','Taylor','JTAYLOR','011.44.1644.429265',TO_DATE('24-MAR-1998', 'dd-Mon-YYYY'),'SA_REP',8600,.20,149,80),
(177,'Jack','Livingston','JLIVINGS','011.44.1644.429264',TO_DATE('23-APR-1998', 'dd-Mon-YYYY'),'SA_REP',8400,.20,149,80),
(178,'Kimberely','Grant','KGRANT','011.44.1644.429263',TO_DATE('24-MAY-1999', 'dd-Mon-YYYY'),'SA_REP',7000,.15,149,NULL),
(179,'Charles','Johnson','CJOHNSON','011.44.1644.429262',TO_DATE('04-JAN-2000', 'dd-Mon-YYYY'),'SA_REP',6200,.10,149,80),
(180,'Winston','Taylor','WTAYLOR','650.507.9876',TO_DATE('24-JAN-1998', 'dd-Mon-YYYY'),'SH_CLERK',3200,NULL,120,50),
(181,'Jean','Fleaur','JFLEAUR','650.507.9877',TO_DATE('23-FEB-1998', 'dd-Mon-YYYY'),'SH_CLERK',3100,NULL,120,50),
(182,'Martha','Sullivan','MSULLIVA','650.507.9878',TO_DATE('21-JUN-1999', 'dd-Mon-YYYY'),'SH_CLERK',2500,NULL,120,50),
(183,'Girard','Geoni','GGEONI','650.507.9879',TO_DATE('03-FEB-2000', 'dd-Mon-YYYY'),'SH_CLERK',2800,NULL,120,50),
(184,'Nandita','Sarchand','NSARCHAN','650.509.1876',TO_DATE('27-JAN-1996', 'dd-Mon-YYYY'),'SH_CLERK',4200,NULL,121,50),
(185,'Alexis','Bull','ABULL','650.509.2876',TO_DATE('20-FEB-1997', 'dd-Mon-YYYY'),'SH_CLERK',4100,NULL,121,50),
(186,'Julia','Dellinger','JDELLING','650.509.3876',TO_DATE('24-JUN-1998', 'dd-Mon-YYYY'),'SH_CLERK',3400,NULL,121,50),
(187,'Anthony','Cabrio','ACABRIO','650.509.4876',TO_DATE('07-FEB-1999', 'dd-Mon-YYYY'),'SH_CLERK',3000,NULL,121,50),
(188,'Kelly','Chung','KCHUNG','650.505.1876',TO_DATE('14-JUN-1997', 'dd-Mon-YYYY'),'SH_CLERK',3800,NULL,122,50),
(189,'Jennifer','Dilly','JDILLY','650.505.2876',TO_DATE('13-AUG-1997', 'dd-Mon-YYYY'),'SH_CLERK',3600,NULL,122,50),
(190,'Timothy','Gates','TGATES','650.505.3876',TO_DATE('11-JUL-1998', 'dd-Mon-YYYY'),'SH_CLERK',2900,NULL,122,50),
(191,'Randall','Perkins','RPERKINS','650.505.4876',TO_DATE('19-DEC-1999', 'dd-Mon-YYYY'),'SH_CLERK',2500,NULL,122,50),
(192,'Sarah','Bell','SBELL','650.501.1876',TO_DATE('04-FEB-1996', 'dd-Mon-YYYY'),'SH_CLERK',4000,NULL,123,50),
(193,'Britney','Everett','BEVERETT','650.501.2876',TO_DATE('03-MAR-1997', 'dd-Mon-YYYY'),'SH_CLERK',3900,NULL,123,50),
(194,'Samuel','McCain','SMCCAIN','650.501.3876',TO_DATE('01-JUL-1998', 'dd-Mon-YYYY'),'SH_CLERK',3200,NULL,123,50),
(195,'Vance','Jones','VJONES','650.501.4876',TO_DATE('17-MAR-1999', 'dd-Mon-YYYY'),'SH_CLERK',2800,NULL,123,50),
(196,'Alana','Walsh','AWALSH','650.507.9811',TO_DATE('24-APR-1998', 'dd-Mon-YYYY'),'SH_CLERK',3100,NULL,124,50),
(197,'Kevin','Feeney','KFEENEY','650.507.9822',TO_DATE('23-MAY-1998', 'dd-Mon-YYYY'),'SH_CLERK',3000,NULL,124,50),
(198,'Donald','OConnell','DOCONNEL','650.507.9833',TO_DATE('21-JUN-1999', 'dd-Mon-YYYY'),'SH_CLERK',2600,NULL,124,50),
(199,'Douglas','Grant','DGRANT','650.507.9844',TO_DATE('13-JAN-2000', 'dd-Mon-YYYY'),'SH_CLERK',2600,NULL,124,50),
(200,'Jennifer','Whalen','JWHALEN','515.123.4444',TO_DATE('17-SEP-1987', 'dd-Mon-YYYY'),'AD_ASST',4400,NULL,101,10),
(201,'Michael','Hartstein','MHARTSTE','515.123.5555',TO_DATE('17-FEB-1996', 'dd-Mon-YYYY'),'MK_MAN',13000,NULL,100,20),
(202,'Pat','Fay','PFAY','603.123.6666',TO_DATE('17-AUG-1997', 'dd-Mon-YYYY'),'MK_REP',6000,NULL,201,20),
(203,'Susan','Mavris','SMAVRIS','515.123.7777',TO_DATE('07-JUN-1994', 'dd-Mon-YYYY'),'HR_REP',6500,NULL,101,40),
(204,'Hermann','Baer','HBAER','515.123.8888',TO_DATE('07-JUN-1994', 'dd-Mon-YYYY'),'PR_REP',10000,NULL,101,70),
(205,'Shelley','Higgins','SHIGGINS','515.123.8080',TO_DATE('07-JUN-1994', 'dd-Mon-YYYY'),'AC_MGR',12000,NULL,101,110),
(206,'William','Gietz','WGIETZ','51hr5.123.8181',TO_DATE('07-JUN-1994', 'dd-Mon-YYYY'),'AC_ACCOUNT',8300,NULL,205,110);


INSERT INTO job_history VALUES
(101, date('2024-09-21'), date('2024-06-17'), 'AD_VP', 90),
(102, date('2024-01-13'), date('2024-09-21'), 'AD_VP', 90),
(103, date('2024-01-03'), date('2024-01-13'), 'IT_PROG', 60),
(104, date('2024-05-21'), date('2024-01-03'), 'IT_PROG', 60),
(105, date('2024-06-25'), date('2024-05-21'), 'IT_PROG', 60),
(106, date('2024-02-05'), date('2024-06-25'), 'IT_PROG', 60),
(107, date('2024-02-07'), date('2024-02-05'), 'IT_PROG', 60),
(108, date('2024-08-17'), date('2024-09-21'), 'FI_MGR', 100),
(109, date('2024-08-16'), date('2024-08-17'), 'FI_ACCOUNT', 100),
(110, date('2024-09-28'), date('2024-08-17'), 'FI_ACCOUNT', 100),
(111, date('2024-09-30'), date('2024-08-17'), 'FI_ACCOUNT', 100),
(112, date('2024-03-07'), date('2024-08-17'), 'FI_ACCOUNT', 100),
(113, date('2024-12-07'), date('2024-08-17'), 'FI_ACCOUNT', 100),
(114, date('2024-12-07'), date('2024-01-13'), 'PU_MAN', 30),
(115, date('2024-05-18'), date('2024-12-07'), 'PU_CLERK', 30),
(116, date('2024-12-24'), date('2024-12-07'), 'PU_CLERK', 30),
(117, date('2024-07-24'), date('2024-12-07'), 'PU_CLERK', 30),
(118, date('2024-11-15'), date('2024-12-07'), 'PU_CLERK', 30),
(119, date('2024-08-10'), date('2024-12-07'), 'PU_CLERK', 30),
(120, date('2024-07-18'), date('2024-01-13'), 'ST_MAN', 50),
(121, date('2024-04-10'), date('2024-07-18'), 'ST_MAN', 50),
(122, date('2024-05-01'), date('2024-07-18'), 'ST_MAN', 50),
(123, date('2024-05-23'), date('2024-07-18'), 'ST_MAN', 50),
(124, date('2024-06-15'), date('2024-07-18'), 'ST_MAN', 50),
(125, date('2024-01-16'), date('2024-07-18'), 'ST_MAN', 50),
(126, date('2024-03-18'), date('2024-09-21'), 'SH_CLERK', 50),
(127, date('2024-07-24'), date('2024-03-18'), 'SH_CLERK', 50),
(128, date('2024-05-23'), date('2024-07-24'), 'SH_CLERK', 50),
(129, date('2024-02-24'), date('2024-07-24'), 'SH_CLERK', 50),
(130, date('2024-11-15'), date('2024-09-21'), 'AD_ASST', 90),
(131, date('2024-01-16'), date('2024-11-15'), 'AC_ACCOUNT', 90);

--1. Obtenga el nombre completo (first_name y last_name) y el salario (salary) de todos los empleados. Cambie el nombre
--de la columna first_name a Nombre y last_name a Apellido y salary a Salario.
SELECT first_name as Nombre, last_name as Apellido, salary as Salario FROM EMPLOYEES

--2. Obtenga el nombre completo (first_name y last_name) y el salario (salary) de todos los empleados ordenado
--alfabéticamente por apellido (last_name).
SELECT first_name as Nombre, last_name as Apellido, salary as Salario 
FROM EMPLOYEES
ORDER BY last_name

--3. Obtenga el apellido (last_name) y la Comisión (commission_pct) que perciben los empleados cuya comisión sea mayor
--a 0.25. Mostrarlos ordenados en forma descendente por last_name.
SELECT last_name, commission_pct
FROM EMPLOYEES
WHERE commission_pct>0.25
ORDER BY last_name DESC

--4. Obtenga la cantidad de empleados que trabajan en el departamento 100.
SELECT COUNT(employee_id) as cant_empleados
FROM EMPLOYEES
WHERE department_id=100

--5. Obtenga todos los datos de los departamentos con identificador 10 ó 70 (department_id).
SELECT *
FROM DEPARTMENTS 
WHERE department_id IN (10,70)

--6. Obtenga el apellido (last_name) de los empleados junto al nombre del departamento (department_name) donde
--trabajan
SELECT EMPLOYEES.last_name, DEPARTMENTS.department_name
FROM EMPLOYEES JOIN DEPARTMENTS ON EMPLOYEES.department_id=DEPARTMENTS.department_id

--7. Obtenga el apellido (last_name) de los empleados de los departamentos de Finanzas (Finance) y/o Transporte (Shipping).
SELECT EMPLOYEES.last_name
FROM EMPLOYEES JOIN DEPARTMENTS ON EMPLOYEES.department_id=DEPARTMENTS.department_id
WHERE DEPARTMENTS.department_name IN ('Finance', 'Shipping')

--8. Obtenga sin repetir los tipos de trabajos (jobs) que realizan en los departamentos los empleados. Liste el identificador
--del departamento y el nombre del trabajo.
SELECT DISTINCT EMPLOYEES.department_id, JOBS.job_title
FROM EMPLOYEES JOIN JOBS ON EMPLOYEES.job_id=JOBS.job_id

--9. Obtenga los departamentos en los que los empleados realizan trabajos de Contabilidad (Stock Clerk) y Asistente de
--Administración (Shipping Clerk). Liste el identificador del departamento y el nombre del trabajo.
SELECT DISTINCT EMPLOYEES.department_id
FROM EMPLOYEES JOIN JOBS ON EMPLOYEES.job_id=JOBS.job_id
WHERE JOBS.job_title='Stock Clerk'
INTERSECT
SELECT DISTINCT EMPLOYEES.department_id
FROM EMPLOYEES JOIN JOBS ON EMPLOYEES.job_id=JOBS.job_id
WHERE JOBS.job_title='Shipping Clerk'

--10. Obtenga el nombre de los departamentos que tienen al menos 3 empleados
SELECT DEPARTMENTS.department_name
FROM DEPARTMENTS
JOIN EMPLOYEES ON DEPARTMENTS.department_id = EMPLOYEES.department_id
GROUP BY DEPARTMENTS.department_name
HAVING COUNT(EMPLOYEES.employee_id) >= 3;

--11. Obtenga el apellido de los empleados (last_name) y el salario (salary) de aquellos empleados que tienen un salario
--mayor que el salario promedio. Ordene el listado en forma descendente por salario.
SELECT last_name, salary
FROM EMPLOYEES 
WHERE salary > (
	SELECT AVG(salary)
	FROM EMPLOYEES
)
ORDER BY salary DESC

--12. Obtenga el salario máximo de los empleados del departamento 110. Ordene el listado en forma ascendente por salario.
SELECT MAX(salary)
FROM EMPLOYEES
WHERE department_id=110

--13. Obtenga el nombre del/de los empleados que tienen el sueldo máximo del departamento 110. Ordene el listado en
--forma ascendente por salario
SELECT first_name, salary
FROM EMPLOYEES
WHERE salary = (
    SELECT MAX(salary)
    FROM EMPLOYEES
    WHERE department_id = 110
)
ORDER BY salary ASC;

--14. Obtenga todos los datos de los empleados que no sean supervisores (o directores). NOTA: En la tabla departments el
--atributo manager_id tiene la identificación de los supervisores de cada dpto.

SELECT *
FROM EMPLOYEES
WHERE employee_id NOT IN (
    SELECT manager_id
    FROM DEPARTMENTS
    WHERE manager_id IS NOT NULL
);








