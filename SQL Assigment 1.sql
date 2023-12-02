-- task 1
select date, cmname, price, mktname from food_prices where price <= 50 and mktname = "Quetta" or "karachi" or "Peshawar";
-- task 2
select mktname, count(sn) as number_of_observations from food_prices group by mktname;
-- task 3
select count(distinct mktname) from food_prices;
-- task 4
select distinct (mktname) from food_prices;
-- task 5
select distinct (cmname) from food_prices;
-- task 6
select mktname, avg(price) as average_price from food_prices where cmname="Wheat flour - Retail" group by mktname;
-- task 7
select mktname, cmname, avg(price) as average_price, max(price) as max_price from food_prices where cmname like "%Wheat%" and mktname <> "karachi" group by mktname, cmname order by mktname, cmname;
-- task 8
select mktname, avg(price) as average_price from food_prices where cmname="Wheat - Retail" group by mktname having average_price <30;
-- task 9
select *, case when price < 30 then "low" when price > 250 then "high" else "fair" end as price_category from food_prices;
-- task 10
select date, cmname, category, mktname as city, price, 
case when mktname in ("Karachi", "Lahore") then "Big City" 
when mktname in ("Multan","Peshawar") then "Medium Sized City" 
when mktname = "Quetta" then "Small City" end as city_category from food_prices;
-- task 11
select date, cmname, mktname as city, price, case when price < 100 then "fair" when price > 300 then "speculative" else "unfair" end as price_fairness from food_prices;
-- task 12
select * from food_prices left join commodity on food_prices.cmname=commodity.cmname;
-- task 13
select * from food_prices inner join commodity on food_prices.cmname=commodity.cmname;