--1. Get all customers and their addresses.
SELECT * 
FROM "customers"
JOIN "addresses"
	ON "customers"."id" = "addresses"."customer_id";
--2. Get all orders and their line items (orders, quantity and product).
SELECT 
	"line_items"."quantity" as "productQuantity",
	"line_items"."order_id" as "orderId",
	"products"."description" as "productDescription" 
FROM "orders"
JOIN "line_items"
	ON "line_items"."order_id" = "orders"."id"
JOIN "products"
	ON "products"."id" = "line_items"."product_id"
GROUP BY "orderId", "productDescription", "productQuantity"
ORDER BY "orderId" ASC;
;
--3. Which warehouses have cheetos?
SELECT
	"products".description,
	"warehouse".warehouse
FROM "products"
JOIN "warehouse_product"
	ON "products".id = "warehouse_product".product_id
JOIN "warehouse"
	ON "warehouse".id = "warehouse_product".warehouse_id
WHERE "products".description = 'cheetos';
--4. Which warehouses have diet pepsi?
SELECT
	"products".description,
	"warehouse".warehouse
FROM "products"
JOIN "warehouse_product"
	ON "products".id = "warehouse_product".product_id
JOIN "warehouse"
	ON "warehouse".id = "warehouse_product".warehouse_id
WHERE "products".description = 'diet pepsi';

--5. Get the number of orders for each customer. NOTE: It is OK if those without orders are not included in results.
SELECT 
	"customers"."first_name" as "firstName",
	"customers"."last_name" as "lastName",
	--"customers"."id" as "customerId",
	count("customers"."id") as "numOrders"
FROM "customers"
JOIN "addresses"
	ON "addresses"."customer_id" = "customers"."id"
JOIN "orders"
	ON "orders"."address_id" = "addresses"."id"
GROUP BY "firstName", "lastName";

--6. How many customers do we have?
SELECT 
	count("customers"."id") as "numCustomers"
FROM "customers";
--7. How many products do we carry?
SELECT
	count("products"."id") as "numOfProducts"
FROM "products";
--8. What is the total available on-hand quantity of diet pepsi?
SELECT
	sum("products"."id") as "totalOfProducts"
from "products"
JOIN "warehouse_product"
	ON "warehouse_product"."product_id" = "products"."id"
JOIN "warehouse"
	ON "warehouse"."id" = "warehouse"."id"
Where "products"."description" = 'diet pepsi';