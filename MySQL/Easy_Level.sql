create schema pizzahut;
use pizzahut;

create table orders(
order_id int not null,
order_date date not null,
order_time time not null,
primary key(order_id)
);

select * from pizzahut.orders;

create table order_details(
order_details_id int not null,
order_id int not null,
pizza_id text not null,
quality int not null,
primary key(order_details_id)
);
alter table order_details rename column quality to quantity;
select *from order_details;
-- basic questions
-- Q1-> retive the total number of orders placed
select count(order_id) as total_orders from orders;

-- Q2-> calculate the total revenue generated from pizza sales
SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS total_revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;

-- Q3->Identify the highest price-pizza
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Q4-> identify the most common pizza size ordered
SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS order_count
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;

-- Q5-> list the top 5 most ordered pizza types along with their quantities
SELECT 
    pizza_types.name, SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5;









