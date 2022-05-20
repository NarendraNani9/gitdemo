drop database if exists FLIGHT;
create database if not exists FLIGHT;
use FLIGHT;
create table if not exists FLIGHT(ID INT, YEAR INT, MONTH INT, DAY INT, DAY_OF_WEEK INT, AIRLINE VARCHAR(20), FLIGHT_NUMBER INT, TAIL_NUMBER VARCHAR(30),
ORIGIN_AIRPORT VARCHAR(20), DESTINATION_AIRPORT VARCHAR(20), SCHEDULED_DEPARTURE INT, DEPARTURE_TIME INT,
 DEPARTURE_DELAY INT, TAXI_OUT INT, WHEELS_OFF INT, SCHEDULED_TIME INT, ELAPSED_TIME INT, AIR_TIME INT,
 DISTANCE INT, WHEELS_ON INT, TAXI_IN INT, SCHEDULED_ARRIVAL INT, ARRIVAL_TIME INT, ARRIVAL_DELAY INT, 
 DIVERTED INT, CANCELLED INT, CANCELLATION_REASON VARCHAR(10),AIR_SYSTEM_DELAY INT, SECURITY_DELAY INT, 
 AIRLINE_DELAY INT, LATE_AIRCRAFT_DELAY INT, WEATHER_DELAY INT, primary key (ID));

SET GLOBAL local_infile = true;

LOAD DATA LOCAL INFILE 'C:/Users/VISWA/Downloads/Flights_Delay.csv' INTO 
TABLE FLIGHT FIELDS TERMINATED BY ',' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

-- 3.	Average Arrival delay caused by airlines 
select ARRIVAL_DELAY, count(*) as Count_DELAY, count(*)*100/(select count(*) from FLIGHT) 
as Percent_DELAY from FLIGHT group by ARRIVAL_DELAY order by Percent_DELAY ;

-- 4.	Display the Day of Month with AVG Delay [Hint: Add Count() of Arrival & Departure Delay]
select MONTH,ARRIVAL_DELAY,DEPARTURE_DELAY, count(*) as Count_MON, count(*)*100/(select count(*) from FLIGHT) 
as Percent_DELAY from FLIGHT group by MONTH,ARRIVAL_DELAY,DEPARTURE_DELAY order by Percent_DELAY ;

-- 5.	Analysis for each month with total number of cancellations
select MONTH,CANCELLED, count(*) as Count_MON, count(*)*100/(select count(*) from FLIGHT) 
as Percent_CANCEL from FLIGHT group by MONTH,CANCELLED order by Percent_CANCEL ;

-- 6.	Find the airlines that make maximum number of cancellations
select AIRLINE, CANCELLED, count(*) as COUNT_max from FLIGHT group by AIRLINE, CANCELLED ORDER BY COUNT_max;

-- 7.	Finding the Busiest Airport [Hint: Find Count() of origin airport and destination airport]
select ORIGIN_AIRPORT, DESTINATION_AIRPORT, count(*) as COUNT_AIR from FLIGHT group by ORIGIN_AIRPORT, DESTINATION_AIRPORT ORDER BY COUNT_AIR DESC;

-- 8.	Find the airlines that make maximum number of Diversions [Hint: Diverted = 1 indicate Diversion]
select AIRLINE, DIVERTED, count(*) as COUNT_MAX from FLIGHT group by AIRLINE, DIVERTED ORDER BY COUNT_MAX DESC;

-- 9.	Finding all diverted Route from a source to destination Airport & which route is the most diverted route.
select  DIVERTED,DESTINATION_AIRPORT, count(*) as COUNT_MAX from FLIGHT group by DESTINATION_AIRPORT,DIVERTED ORDER BY COUNT_MAX DESC;

-- 10.	Finding all Route from origin to destination Airport & which route got delayed. 
select DIVERTED, ORIGIN_AIRPORT,DESTINATION_AIRPORT, count(*) as COUNT_MAX from FLIGHT group by DIVERTED,DESTINATION_AIRPORT,ORIGIN_AIRPORT ORDER BY COUNT_MAX DESC;

-- 11.	Finding the Route which Got Delayed the Most [Hint: Route include Origin Airport and Destination Airport, Group By Both ]


