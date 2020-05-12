--Get all customers and their addresses.
SELECT *
FROM customers
JOIN addresses ON addresses.customer_id=customers.id;

--Get all orders and their line items (orders, quantity and product).
SELECT orders.id, description, quantity
FROM orders
JOIN line_items ON line_items.order_id=orders.id
JOIN products on products.id=line_items.product_id;

--Which warehouses have cheetos?
SELECT warehouse.warehouse, products.description
FROM warehouse
JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id
JOIN products ON products.id=warehouse_product.product_id
WHERE description='cheetos';

--Which warehouses have diet pepsi?
SELECT warehouse.warehouse, products.description
FROM warehouse
JOIN warehouse_product ON warehouse.id=warehouse_product.warehouse_id
JOIN products ON products.id=warehouse_product.product_id
WHERE description='diet pepsi';

--Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT CONCAT(customers.first_name, ' ', customers.last_name), COUNT(orders.id)
FROM customers
JOIN addresses ON customers.id=addresses.customer_id
JOIN orders ON orders.address_id=addresses.id
GROUP BY CONCAT(customers.first_name, ' ', customers.last_name);

--How many customers do we have?
SELECT COUNT(customers.id)
FROM customers;

--How many products do we carry?
SELECT COUNT(products.id)
FROM products;

--What is the total available on-hand quantity of diet pepsi?
SELECT products.description, SUM(warehouse_product.on_hand)
FROM products
    JOIN warehouse_product ON warehouse_product.product_id=products.id
WHERE description='diet pepsi'
GROUP BY products.description;

/* Stretch */

--How much was the total cost for each order?
SELECT orders.id, SUM(products.unit_price)
FROM orders
    JOIN line_items ON line_items.order_id=orders.id
    JOIN products ON products.id=line_items.product_id
GROUP BY orders.id
ORDER BY orders.id;

--How much has each customer spent in total?
SELECT CONCAT(first_name, ' ', last_name), SUM(products.unit_price)
FROM customers
    JOIN addresses ON addresses.customer_id=customers.id
    JOIN orders ON orders.address_id=addresses.id
    JOIN line_items ON line_items.order_id=orders.id
    JOIN products ON products.id=line_items.product_id
GROUP BY CONCAT(first_name, ' ', last_name);