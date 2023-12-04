-- get all orders
CREATE OR REPLACE FUNCTION get_all_orders()
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
RETURN QUERY SELECT * FROM public.order;
END;
$$ LANGUAGE plpgsql;

-- get one order by order_id
CREATE OR REPLACE FUNCTION get_order_by_id(id uuid)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
	IF NOT EXISTS (SELECT * FROM public.order WHERE order_id = id)
	THEN RAISE EXCEPTION no_data_found USING message = 'Order id not found';
	END IF;

	RETURN QUERY SELECT * FROM public.order WHERE order_id = id;
END;
$$ LANGUAGE plpgsql;

-- get one order by user_id
CREATE OR REPLACE FUNCTION get_orders_by_user(user_id_to_find uuid)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = user_id_to_find)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

	RETURN QUERY SELECT * FROM public.order WHERE user_id = user_id_to_find;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

-- create a new order 
CREATE OR REPLACE FUNCTION add_order(user_id_add uuid, order_status_add status)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = user_id_add)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

    RETURN QUERY 
        INSERT INTO public.order (order_id, user_id, order_date, order_status)
        VALUES(gen_random_uuid(), user_id_add, now(), order_status_add)
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- update an order 
CREATE OR REPLACE FUNCTION update_order_status(order_id_update UUID, new_order_status STATUS)
RETURNS TABLE(orderID uuid, userID uuid, orderDate date, orderStatus status) AS $$
BEGIN
    RETURN QUERY
        UPDATE public.order
        SET order_status = new_order_status
        WHERE order_id = order_id_update
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- delete one order by order_id
CREATE OR REPLACE FUNCTION delete_order_product(order_id_param UUID) RETURNS BOOLEAN AS
$$
DECLARE
    deleted BOOLEAN;
BEGIN
    deleted := FALSE;
    DELETE FROM public.order_product WHERE order_id = order_id_param;
    GET DIAGNOSTICS deleted = ROW_COUNT;
    RETURN deleted;
END;
$$
LANGUAGE plpgsql;
