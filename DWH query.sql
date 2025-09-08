CREATE TABLE EDW.dim_patient(
    patient_id varchar(50) primary key,
    first_name text,
    last_name text,
    dob date,
    gender text,
    ethnicity text,
    "address" text,
    contact_no text,
    loaded_date date
);

CREATE TABLE stg.dim_patient(
    patient_id varchar(50) primary key,
    first_name text,
    last_name text,
    dob date,
    gender text,
    ethnicity text,
    "address" text,
    contact_no text,
    loaded_date date
);


CREATE TABLE EDW.dim_participants(
   participants_id varchar(50) primary key,
   trial_id  varchar(50),
   patient_id  varchar(50),
   enrollment_date date,
   status  text,
   loaded_date   date
);

CREATE TABLE stg.dim_participants(
   participants_id varchar(50) primary key,
   trial_id  varchar(50),
   patient_id  varchar(50),
   enrollment_date  date,
   status      text,
   loaded_date   date
);


CREATE TABLE EDW.dim_date(
   datekey  date primary key,
   year     integer,
   quarter  integer,
   month    integer,
   week      integer,
   dayOfWeek   integer
);


CREATE TABLE EDW.fact_med_record(
    record_id varchar(50) primary key,
    patient_id  varchar(50),
    admission_date  date,
    discharge_date  date,
    diagnosis text,
    treatment_desc text,
    med_presc text,
    loaded_date  date
);

drop table stg.fact_med_record;
drop table edw.fact_med_record;



CREATE TABLE stg.fact_med_record(
    record_id varchar(50) primary key,
    patient_id  varchar(50),
    admission_date  date,
    discharge_date  date,
    diagnosis text,
    treatment_desc text,
    med_presc text,
    loaded_date  date
);




CREATE TABLE EDW.fact_labs(
    result_id varchar(50) primary key,
    patient_id  varchar(50),
    lab_type varchar(20),
    lab_date  date,
    "result"  text,
    image_url  text,
    ref_range  text,
    loaded_date  date

);

CREATE TABLE stg.fact_labs(
    result_id varchar(50) primary key,
    patient_id  varchar(50),
    lab_type varchar(20),
    lab_date  date,
    "result"  text,
    image_url  text,
    ref_range  text,
    loaded_date  date

);


CREATE TABLE EDW.fact_trials(
    trial_id varchar(50) primary key,
    trial_name  text,
    princ_invest   text,
    start_date  date,
    end_date  date,
    description  text,
    loaded_date  date
);

CREATE TABLE stg.fact_trials(
    trial_id varchar(50) primary key,
    trial_name  text,
    princ_invest   text,
    start_date  date,
    end_date  date,
    description  text,
    loaded_date  date
);


--Populate the Date Dimension Table
DECLARE @StartDate DATE = '2020-01-01';
DECLARE @EndDate DATE = '2030-12-31';


WITH DateSeries AS (
    SELECt @StartDAte AS datekey
    UNION ALL
    SELECT DATEADD(DAY, 1, datekey)
    FROM DateSeries
    WHERE datekey < @EndDate

)
INSERT INTO EDW.dim_date
SELECT
    datekey,
    YEAR(datekey) AS Year,
    DATEPART(QUARTER, datekey) AS Quarter,
    MONTH(datekey) AS Month,
    DATEPART(WEEK, datekey) AS Week,
    DATEPART(WEEKDAY, datekey) AS dayOfWeekF
FROM DateSeries
OPTION (MAXRECURSION 0);


select * from edw.dim_date