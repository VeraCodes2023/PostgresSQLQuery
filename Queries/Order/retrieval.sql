-- get all orders 
select * from get_all_orders()
-- get order by order_id 
select * from get_order_by_id('fd6d48cb-7edd-4e1c-9011-38425049f4a8')
-- get order by user_id 
select * from get_orders_by_user('4d97ac49-d50b-4786-934c-c6355aae27d5')
-- create new order 
select * from add_order('9536b5c4-20d0-445e-a6ae-7004a6ee474e','processing')
-- update an order 
select * from update_order_status('2ed12bcc-b378-4dd8-97a9-84f9cb4d9c2a','shipped')
-- delete an order 
select * from delete_order('bfb3bc8c-e223-4d0f-99d8-74608a4db35e')