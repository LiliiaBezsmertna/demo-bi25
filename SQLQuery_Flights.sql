
--STEG 1 -DB SourseSystemes

create database SourseSystemes
go
select count(*) from [dbo].[RawAirports] --322
select * from [dbo].[RawAirlines] --14
select count(*) from [dbo].[RawFlights]  --5819079

create table RawAirlines(
	IATA_CODE varchar(250) NULL,
	AIRLINE varchar(250) NULL
);

create table RawAirports(
	IATA_CODE varchar(250) NULL,
	AIRPORT varchar(250) NULL,
	CITY varchar(250) NULL,
	[STATE] varchar(250) NULL,
	COUNTRY varchar(250) NULL,
	LATITUDE float NULL,
	LONGITUDE float NULL
);

create table RawFlights(
	[YEAR] [varchar](50) NULL,
	[MONTH] [varchar](50) NULL,
	[DAY] varchar(50) NULL,
	DAY_OF_WEEK varchar(50) NULL,
	AIRLINE varchar(50) NULL,
	FLIGHT_NUMBER varchar(50) NULL,
	TAIL_NUMBER varchar(50) NULL,
	ORIGIN_AIRPORT varchar(50) NULL,
	DESTINATION_AIRPORT varchar(50) NULL,
	SCHEDULED_DEPARTURE varchar(50) NULL,
	DEPARTURE_TIME varchar(50) NULL,
	DEPARTURE_DELAY varchar(50) NULL,
	TAXI_OUT varchar(50) NULL,
	WHEELS_OFF varchar(50) NULL,
	SCHEDULED_TIME varchar(50) NULL,
	ELAPSED_TIME varchar(50) NULL,
	AIR_TIME varchar(50) NULL,
	DISTANCE varchar(50) NULL,
	WHEELS_ON varchar(50) NULL,
	TAXI_IN varchar(50) NULL,
	SCHEDULED_ARRIVAL varchar(50) NULL,
	ARRIVAL_TIME varchar(50) NULL,
	ARRIVAL_DELAY varchar(50) NULL,
	DIVERTED varchar(50) NULL,
	CANCELLED varchar(50) NULL,
	CANCELLATION_REASON varchar(50) NULL,
	AIR_SYSTEM_DELAY varchar(50) NULL,
	SECURITY_DELAY varchar(50) NULL,
	AIRLINE_DELAY varchar(50) NULL,
	LATE_AIRCRAFT_DELAY varchar(50) NULL,
	WEATHER_DELAY varchar(50) NULL
);
 
--STEG 2 -Skapa DB StagingArea

create database StagingArea
go

CREATE TABLE AirlinesClean (
    AirlineKey INT IDENTITY(1,1) PRIMARY KEY,
    IATACode VARCHAR(10) NOT NULL,
    AirlineName VARCHAR(100) NOT NULL
);

CREATE TABLE AirportsClean (
    AirportKey INT IDENTITY(1,1) PRIMARY KEY,
    IATACode VARCHAR(10) NOT NULL,
    AirportName VARCHAR(150) NOT NULL,
    City VARCHAR(100),
    State VARCHAR(50),
    Country VARCHAR(50),
    Latitude FLOAT,
    Longitude FLOAT
);

CREATE TABLE FlightsClean (
    FlightKey INT IDENTITY(1,1) PRIMARY KEY,
    FlightDate DATE,
    AirlineCode VARCHAR(10),
    FlightNumber VARCHAR(10),
    TailNumber VARCHAR(10),
    OriginAirportCode VARCHAR(10),
    DestinationAirportCode VARCHAR(10),
    ScheduledDepartureTime TIME,
    ActualDepartureTime TIME,
    ScheduledArrivalTime TIME,
    ActualArrivalTime TIME,
    DepartureDelay INT,
    ArrivalDelay INT,
    Cancelled BIT,
    Distance INT
);

CREATE TABLE Routes (
    RouteID INT IDENTITY(1,1) PRIMARY KEY,
    OriginAirportCode VARCHAR(10),
    DestinationAirportCode VARCHAR(10)
);

-- Steg 3 -Skapa DW_FlightData

create database DW_FlightData
go

CREATE TABLE DimAirline (
    AirlineKey INT PRIMARY KEY,
    IATACode VARCHAR(10) NOT NULL,
    AirlineName VARCHAR(100) NOT NULL
);

CREATE TABLE DimRoutes (
    RouteKey INT IDENTITY(1,1) PRIMARY KEY,
    RouteID INT,
    OriginAirportCode VARCHAR(10),
    OriginAirportName VARCHAR(150),
    OriginCity VARCHAR(100),
    OriginState VARCHAR(50),
    OriginCountry VARCHAR(50),
    DestinationAirportCode VARCHAR(10),
    DestinationAirportName VARCHAR(150),
    DestinationCity VARCHAR(100),
    DestinationState VARCHAR(50),
    DestinationCountry VARCHAR(50)
);

-- DimDate och FactFlights tabellerna skapade jag i SSIS