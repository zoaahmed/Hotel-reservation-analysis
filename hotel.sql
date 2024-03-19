select * from dbo.['Hotel Reservation Dataset$']
--1) Total number of reservations done in the dataset
SELECT COUNT(*) as Totalreservations FROM dbo.['Hotel Reservation Dataset$'] 

--2)which meal plan is most popular among the guest
SELECT top 1 type_of_meal_plan, COUNT(*) AS TotalGuests
FROM dbo.['Hotel Reservation Dataset$']
GROUP BY type_of_meal_plan
ORDER BY TotalGuests DESC 

--3)What is the average price per room for reservations involving children
select no_of_children,cast(Avg(avg_price_per_room)  as int) AS [average price per room for reservations] from dbo.['Hotel Reservation Dataset$'] 
where  no_of_children>0
group by no_of_children 

select * from dbo.['Hotel Reservation Dataset$']

--4)How many reservations were made for the year 2017?
select count(*) as total_reservations from dbo.['Hotel Reservation Dataset$'] where Year(arrival_date)='2017'

--4)How many reservations were made for the month of july in 2018?
select count(*) as total_reservations from dbo.['Hotel Reservation Dataset$'] where month(arrival_date)='07' and year(arrival_date)='2018'

--5. What is the most commonly booked room type?
select top 1 room_type_reserved as common_booked_type , count(*) as num_of_bookings from dbo.['Hotel Reservation Dataset$'] group by room_type_reserved order by num_of_bookings desc

--6)How many reservations fall on a weekend (no_of_weekend_nights > 0)?
select count(*) as Num_of_reservations from dbo.['Hotel Reservation Dataset$'] where no_of_weekend_nights>0

--7) What is the highest and lowest lead time for reservations? 
select max(lead_time) as highest_lead_time ,min(lead_time) as lowest_lead_time,count(*) as totalreservations_done from dbo.['Hotel Reservation Dataset$'] 

select * from dbo.['Hotel Reservation Dataset$']

--8)What is the most common market segment type for reservations? 
select top 1 market_segment_type,count(*) as reservations from  dbo.['Hotel Reservation Dataset$'] group by market_segment_type order by reservations desc

--9) How many reservations have a booking status of "Confirmed"? 
select count(*) as Num_of_reservations from dbo.['Hotel Reservation Dataset$'] where booking_status='Not_Canceled'  

--10) How many reservations have a booking status of "Canceled"? 
select count(*) as Num_of_reservations from dbo.['Hotel Reservation Dataset$'] where booking_status='Canceled' 

--11) What is the total number of adults and children across all reservations? 
select sum(no_of_adults) as totalnumber_of_adults,sum(no_of_children) as  total_number_of_children  from dbo.['Hotel Reservation Dataset$']

--12) What is the average number of weekend nights for reservations involving children? 
select no_of_children,AVG(no_of_weekend_nights) as average_number_of_weekend_nights from dbo.['Hotel Reservation Dataset$'] where no_of_children>0
group by no_of_children

--13)How many reservations were made in each month of the year? 
SELECT MONTH(arrival_date) AS month, COUNT(*) AS num_reservations
FROM dbo.['Hotel Reservation Dataset$']
GROUP BY MONTH(arrival_date)
order by num_reservations

--14) What is the average number of nights (both weekend and weekday) spent by guests for each room type? 
SELECT 
    room_type_reserved,
    AVG(no_of_weekend_nights + no_of_week_nights) AS average_total_nights
FROM dbo.['Hotel Reservation Dataset$']
GROUP BY room_type_reserved;


--15) For reservations involving children, what is the most common room type, and what is the average 
--price for that room type? 
select  top 1 room_type_reserved,count(*) as reservations ,avg_price_per_room FROM dbo.['Hotel Reservation Dataset$'] where no_of_children >0
group by room_type_reserved , avg_price_per_room
order by reservations desc


--16)Find the market segment type that generates the highest average price per room.
select top 1 market_segment_type , max(avg_price_per_room) as highest_average_price_per_room from dbo.['Hotel Reservation Dataset$'] group by market_segment_type
order by highest_average_price_per_room desc


--17) Find the top 3 months with the highest number of reservations made in  year 2017.
WITH monthly_reservations AS (
    SELECT 
        YEAR(arrival_date) AS year,
        MONTH(arrival_date) AS month,
        COUNT(*) AS num_reservations,
        RANK() OVER (PARTITION BY YEAR(arrival_date) ORDER BY COUNT(*) DESC) AS month_rank
    FROM 
        dbo.['Hotel Reservation Dataset$']
    GROUP BY 
        YEAR(arrival_date),
        MONTH(arrival_date)
)
SELECT top 3 month,    year,
    num_reservations
FROM 
    monthly_reservations
WHERE 
    month_rank <= 3 


