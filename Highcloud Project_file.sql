use projectdb;
show tables;
select * from maindata;

-- Q2.Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)
-- 	a) Yearly
	select 
    year AS Flight_Year,
    SUM(`# Transported Passengers`) AS Total_Passengers,
    SUM(`# Available Seats`) AS Total_Seats,
    ROUND(100.0 * SUM(`# Transported Passengers`) / SUM(`# Available Seats`), 2) AS Load_Factor_Pct
	from maindata
	group by year
	order by Flight_Year;
	
-- b) Monthly
	select 
    year AS Flight_Year,
    `Month (#)` AS Month_Number,
    SUM(`# Transported Passengers`) AS Total_Passengers,
    SUM(`# Available Seats`) AS Total_Seats,
    ROUND(100.0 * SUM(`# Transported Passengers`) / SUM(`# Available Seats`), 2) AS Load_Factor_Pct
	from maindata
	group by year,  `Month (#)`
	order by Flight_Year, Month_Number;
       
-- c)Quaterly
	select 
    year AS Flight_Year,
    QUARTER(STR_TO_DATE(CONCAT(year, '-', `Month (#)`, '-', Day), '%Y-%m-%d'))  AS Flight_Quarter,
    SUM(`# Transported Passengers`) AS Total_Passengers,
    SUM(`# Available Seats`) AS Total_Seats,
    ROUND(100.0 * SUM(`# Transported Passengers`) / SUM(`# Available Seats`), 2) AS Load_Factor_Pct
	from maindata
	group by year,Flight_Quarter
	order by year, Flight_Quarter; 

-- Q3.Find the load Factor percentage on a Carrier Name basis ( Transported passengers / Available seats)
	select
    `carrier name`,
    SUM(`# Transported Passengers`) AS total_passengers,
    SUM(`# Available Seats`) AS total_seats,
    ROUND(100.0 * SUM(`# Transported Passengers`) / NULLIF(SUM(`# Available Seats`), 0), 2) AS load_factor_pct
	from maindata
    group by `carrier name`;
    
-- Q4. Identify Top 10 Carrier Names based passengers preference 
	select `carrier name`, 
    COUNT(`# Transported Passengers`) AS Total_Passengers 
	from maindata 
	group by `carrier name` 
	order by Total_Passengers desc
    limit 10;

-- Q5. Display top Routes ( from-to City) based on Number of Flights 
	Select 
    `from - to City` as route, 
    count(*) AS TotalFlights,
    sum(`# Transported Passengers`) AS Total_Passengers 
	from maindata
	group by route
	order by TotalFlights DESC
    limit 10;
    


-- Q6. Identify the how much load factor is occupied on Weekend vs Weekdays.
    select
    case
        when DAYNAME(STR_TO_DATE(CONCAT(year, '-', `Month (#)`, '-', Day), '%Y-%m-%d'))
             in ('Saturday', 'Sunday') then 'Weekend'
        else 'Weekday'
    end as Day_Type,
    ROUND(100.0 * SUM(`# Transported Passengers`) / NULLIF(SUM(`# Available Seats`), 0), 2) as Load_Factor
	from maindata
	group by
		case 
			when DAYNAME(STR_TO_DATE(CONCAT(year, '-', `Month (#)`, '-', Day), '%Y-%m-%d')) in ('Saturday', 'Sunday') then 'Weekend'
			else 'Weekday'
		end;
        
-- Q7  Identify number of flights based on Distance group
	select
    case
        when distance < 500 then 'Short distance (0-499 miles)'
        when distance >= 500 and distance < 1500 then 'Medium distance (500-1499 miles)'
        when distance >= 1500 then 'Long distance (1500+ miles)'
        else 'Unknown Distance'
    end as distance_group,
    COUNT(*) as number_of_flights
	from maindata
	group by 1
	order by number_of_flights DESC;
    
-- Q8 Use the filter to provide a search capability to find the flights between Source Country, Source State, Source City to Destination Country , 
		-- Destination State, Destination City
	select `Origin Country`,`Origin state`,`origin city`, `Destination Country`,`Destination state`,`Destination city` 
    from maindata;


			
		
            
		SELECT max(distance) from maindata;