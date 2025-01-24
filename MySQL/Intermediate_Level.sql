-- intermediate Level questions
-- Q1-> join the necessary tables to find the total quantity of each pizza category ordered

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY quantity DESC;


-- Q2-> Determine the  distribution of orders by hour of the day
SELECT 
    HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM
    orders
GROUP BY HOUR(order_time);


-- Q3-> join relevent tables to find the category-wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;


-- Q4-> group the orders by date and calculate the average number of pizzas ordered per day
SELECT 
    ROUND(AVG(quantity), 0) as `average_pizza/day`
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS order_quantity;
    
    
-- Q5-> determine the top3 most ordered pizza types based on revenue

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3



