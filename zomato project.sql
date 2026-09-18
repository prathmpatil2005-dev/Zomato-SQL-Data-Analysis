-- ======================================================================================================================================

-- Creating zomato database 
create database zomato_db;

-- ======================================================================================================================================

-- using zomato database
use zomato_db;

-- =======================================================================================================================================

-- ctreating all tables and importing the row data

create table delivery_partner
(partner_id  INT primary key, partner_name VARCHAR(100));

create table food
 (f_id int primary key, f_name varchar(200),
 type varchar(50));

create table manu (menu_id int primary key, 
r_id int, f_id int, price decimal(10,2));

create table order_details 
( id int primary key, order_id int, f_id int);

create table orders
(orders int primary key, user_id int, r_id int, 
amount decimal (10,2), date date, partner_id INT,
 delivery_time int, delivery_rating int, restaurant_rating int);

create table restaurants (r_id int primary key,
 r_name varchar(100), cuisine varchar(100));
 
 create table users (user_id int primary key, 
 name varchar(100), email varchar(200),password varchar(100));

 select * from users;
 show tables;
 -- all tables has been ctrated and imported the data 
 
 -- ======================================================================================================================================
 -- sovling the queris
 
 -- Counts of rows?
 
 select count(*) total_restorents
 from restaurants;
 
  select count(*) total_food
 from food;
 
  select count(*) total_manu
 from manu;
 
  select count(*) total_orders
 from orders;
 
  select count(*) total_order_details
 from order_details;
 
 
 
  select count(*) total_delivry_partner
 from delivery_partner ;
 
-- ====================================================================================================================================

-- Finding the null values

select 
sum(user_id is null) as user_id_null,
sum(name is null) as name_null,
sum(email is null) as email_null,
sum(password is null) as password_null
from users;

 select 
 sum(r_id is null) as r_id_null,
 sum(r_name is null) as r_name_null,
 sum(cuisine is null) as cuisine_null
 from restaurants;
 
 select 
 sum(orders is null) as orders_null,
 sum(user_id is null) as user_id_null,
 sum(r_id is null) as r_id_null,
 sum(amount is null) as amount_null,
 sum(date is null) as date_null,
 sum(partner_id is null) as partner_id_null,
 sum(delivery_time is null) as delivery_time_null,
 sum(delivery_rating is null) as delivery_rating_null,
 sum(restaurant_rating is null) as restaurant_rating_null
 from orders;
 
 select 
 sum(id is null) as id_null,
 sum(order_id is null) as order_id_null,
 sum(f_id is null) as f_id_null
 from order_details;
 
 select 
 sum(menu_id is null) as menu_id_null,
 sum(r_id is null) as r_id_null,
 sum(f_id is null) as f_id_null,
 sum(price is null) as price_null
 from manu;
 
 select 
 sum(f_id is null) as f_id_null,
 sum(f_name is null) as f_name_null,
 sum(type is null) as type_null
 from food;
 
 select
 sum(partner_id is null) as partner_id_null,
 sum(partner_name is null) as partner_name_null
 from delivery_partner;
 
 -- there are 0 null values in all the tables
 
 -- ====================================================================================================================================
 
 -- Find numbers of orders placed by each customers
 
 select 
 u.user_id,
 u.name,
 count(o.orders) as total_orders
 from users u
 left join orders o
 on u.user_id = o.user_id
 group by u.user_id, u.name
 order by total_orders desc;
 -- =========================================================================================================================================
 
 -- Find restaurant with most number of menu items
 
 select 
 r.r_id,
 r.r_name,
 count(m.f_id) as total_menu_items
 from restaurants r
 join manu m
 on r.r_id = m.r_id
 group by r.r_id, r.r_name
 order by total_menu_items desc
 limit 1;
 -- =========================================================================================
 
 -- ==============================================================================================================================================
 -- Find the food that is been sold at most number of restaurants
 select 
 f.f_id,
 f.f_name,
 count(distinct m.r_id) as restaurant_count
 from food f
 join manu m
 on f.f_id = m.f_id
 group by f.f_id, f.f_name
 order by restaurant_count desc
 limit 1;
 -- ==========================================================================================================================================
 -- Find restaurant with maximum revenue iN May month
 select 
 r.r_id,
 r.r_name,
 sum(o.amount) as total_revenue
 from restaurants r
 join orders o
 on r.r_id = o.r_id
 where month(o.date) = 5
 group by r.r_id, r.r_name
 order by total_revenue desc
 limit 1;
 
 -- =========================================================================================
 -- Find restaurants with sales greater then 1500
 
 select 
 r.r_id,
 r.r_name,
 sum(o.amount) as total_sales
 from restaurants r
 join orders o
 on r.r_id = o.r_id
 group by r.r_id, r.r_name
 having sum(o.amount) > 1500
 order by total_sales desc;
  
-- ===========================================================================================================================================

-- Find customers who have never ordered

select 
u.user_id,
u.name
from users u
left join orders o
on u.user_id = o.user_id
where o.user_id is null;

-- =======================================================================================================================================
use zomato_db;
-- Show order detail of a perticular customer in a given date range
select
 orders,
 user_id,
 date,
 amount
 from orders
 order by date;
-- =====================================================================================================================================

-- Customer favorite food 
select 
u.user_id,
u.name,
f.f_name,
count(od.f_id) as order_count
from users u
join orders o
on u.user_id = o.user_id
join order_details od
on o.orders = od.order_id
join food f
on od.f_id = f.f_id
where u.user_id = 1
group by u.user_id, u.name, f.f_id, f.f_name
order by order_count desc
limit 1;
-- =======================================================================================================================================

-- Find the most costly restaurants

select 
r_id,
max(price) as highest_price
from manu
group by r_id
order by highest_price
limit 1;
-- ====================================================================================================================================

-- Finding Delivery partners compunsation 
select 
partner_id,
count(*) as total_orders,
sum(delivery_time) as total_delivery_time
from orders
group by partner_id
order by total_orders desc;
-- =====================================================================================================================================
-- Find all the veg restaurants

select *
from food
where type = 'veg'; 
-- =======================================================================================================================================