-- Advance level question
-- Q1-> cal the percentage contribution of each pizza type to total revenue

SELECT 
    pizza_types.category,
    round((SUM(order_details.quantity * pizzas.price) / total_sales.total) * 100,2) AS revenue_percentage
FROM 
    pizza_types
JOIN 
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN 
    order_details ON order_details.pizza_id = pizzas.pizza_id
CROSS JOIN 
    (SELECT ROUND(SUM(order_details.quantity * pizzas.price), 2) AS total
     FROM order_details
     JOIN pizzas ON order_details.pizza_id = pizzas.pizza_id) AS total_sales
GROUP BY 
    pizza_types.category, total_sales.total
ORDER BY 
    revenue_percentage DESC;

-- Q2-> analyze the cumulative revenue generated over time
select o_date,
sum(revenue) over(order by o_date) as cum_revenue
from 
(select orders.order_date as o_date,
sum(order_details.quantity * pizzas.price) as revenue
from order_details join pizzas
on order_details.pizza_id=pizzas.pizza_id
join orders
on orders.order_id=order_details.order_id
group by  o_date) as sales