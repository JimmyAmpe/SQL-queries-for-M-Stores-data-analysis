use m_stores;

create view top_selling_products  as
 -- In this query, we extract top selling products and analyze sales trends by month.
SELECT 
    Sub_category AS Product_category,
    SUM(quantity) AS Total_Sales,
   month(Order_Date) AS Month
FROM
    orders
GROUP BY Sub_Category , month(Order_Date)
ORDER BY month(Order_Date) , total_sales desc;



create view orders_per_customer as
--  In this query, I analysed customer behaviour and extracted data on which which customers spent the most in the store
SELECT 
    customer_name,
   COUNT(DISTINCT Order_ID) AS Total_Orders,
    round(SUM(revenue),0) AS Total_Spent,
    round(AVG(revenue),0) AS Average_Order_Value
FROM
    orders
GROUP BY Customer_name
ORDER BY Total_Spent DESC;



CREATE VIEW inventory_take AS
-- In this query, I extracted the number of all orders and quantity sold for inventory count
    SELECT 
        sub_category AS product_name,
        COUNT(Order_ID) AS Total_Orders,
        SUM(Quantity) AS Total_Quantity_Sold,
        ROUND(SUM(revenue), 0) AS Total_Revenue
    FROM
        orders
    GROUP BY sub_category
    ORDER BY Total_Quantity_Sold DESC; 
    
  
  create view manager_performance as
  -- In this query, I extracted data on the overall managers performance by revenue by joining the managers table and orders table
  SELECT 
    m.manager,
    O.region,
    round(SUM(O.revenue),0) AS revenue
FROM
    orders O
        JOIN
    managers m ON m.region = O.region
GROUP BY o.region, m.Manager
ORDER BY revenue desc;


create view customer_segment_performance as
--With this query, I displayed the best performing customer segments by revenue 
SELECT 
    customer_segment,
    count(distinct order_id) AS Total_orders,
    SUM(quantity) AS Quantity_sold,
    round(SUM(revenue),0) AS Revenue
FROM
    orders
GROUP BY customer_segment
ORDER BY revenue desc;



create view above_average_performing_products as
-- We were asked by management to pull up sub categories that performed above overall average
SELECT 
    sub_category AS Product_name, ROUND(AVG(revenue), 0) as revenue
FROM
    orders 
WHERE
    revenue > (SELECT AVG(revenue) from orders)
GROUP BY sub_category
ORDER BY revenue DESC; 


create view returned_products as
-- with this query, I extracted info of the customers that returned goods for for further investigation by joining the returned table with the orders table
SELECT 
    o.Customer_name,
    r.order_id,
    o.sub_category AS Product_name,
    o.city,
    o.order_date,
    o.customer_segment,
    o.revenue
FROM
    returned r
        JOIN
    orders o ON r.order_id = o.order_id;
    
    
  -- With this query, I deleted all orders that were returned from the orders table.  
 DELETE FROM orders 
WHERE
    order_id IN (SELECT 
        order_id
    FROM
        returned);
        
        
create view top_selling_category  as
 -- With this query, I extracted data on top selling product category and analyzekd sales trends by month and revenue.
SELECT 
    Product_category AS Category,
    SUM(quantity) AS Total_Sales,
   month(Order_Date) AS Month,
   round(sum(revenue),0) as revenue
FROM
    orders
GROUP BY product_Category , month(Order_Date)
ORDER BY month(Order_Date) , total_sales desc;





