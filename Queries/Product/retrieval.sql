-- create product
select * from create_product('Electronic Timer','metal cover for outdoors, 3 years battery.','12','f2e28553-2b43-4d61-bb4d-20a2b88048a0')

-- retrieve all products 
SELECT * FROM get_all_products();

-- retrieve a single product 
SELECT * FROM get_product_by_id('3a89e838-23c3-4782-808a-b5c0a1f4f6e1');

-- update a product 
SELECT * FROM update_product(
    '201651bc-dc06-43b0-92bf-36da75479338'::UUID, 
    'New Title'::VARCHAR, 
    'New Description'::VARCHAR, 
    29.99::NUMERIC, 
    '2ff524f8-e00a-47d3-b2a4-2fe8ec64987d'::UUID
);
-- delete a product 
SELECT delete_product('201651bc-dc06-43b0-92bf-36da75479338');

-- the 3 most purchased product 
SELECT get_most_purchased_products(3)