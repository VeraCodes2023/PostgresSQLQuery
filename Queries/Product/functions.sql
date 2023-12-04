-- create product fn
CREATE OR REPLACE FUNCTION create_product(
    product_title VARCHAR,
    product_description VARCHAR,
    product_price NUMERIC,
    product_category_id UUID
)
RETURNS product AS $$
DECLARE
    new_product product;
BEGIN
    INSERT INTO public.product (product_id, title, description, price, category_id)
    VALUES (gen_random_uuid(), product_title, product_description, product_price, product_category_id)
    RETURNING * INTO  new_product;
    RETURN new_product;
END;
$$ LANGUAGE plpgsql

-- get all products fn 
CREATE OR REPLACE FUNCTION get_all_products()
RETURNS SETOF product AS
$$
BEGIN
RETURN QUERY SELECT * FROM product;
END;
$$
LANGUAGE plpgsql;

-- get a single product fn 
CREATE OR REPLACE FUNCTION get_product_by_id(
    product_id_to_find UUID
)
RETURNS product AS
$$
DECLARE
    found_product product;
BEGIN
    SELECT * INTO found_product FROM product WHERE product_id = product_id_to_find;
    RETURN found_product;
END;
$$
LANGUAGE plpgsql;

-- update product fn 
CREATE OR REPLACE FUNCTION update_product(
    product_id_to_update UUID,
    new_title TEXT,
    new_description TEXT,
    new_price NUMERIC,
    new_category_id UUID
)
RETURNS TABLE(productID uuid, title varchar, description varchar, price numeric, categoryId uuid) AS $$
BEGIN
    RETURN QUERY
    UPDATE public.product
        SET
            title = new_title,
            description = new_description,
            price = new_price,
            category_id = new_category_id
        WHERE product_id = product_id_to_update
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- delete product fn 
CREATE OR REPLACE FUNCTION delete_product(remove_product_id UUID) RETURNS BOOLEAN AS
$$
DECLARE
    deleted BOOLEAN;
BEGIN
    deleted := FALSE;
    DELETE FROM public.product WHERE product_id = remove_product_id;
    GET DIAGNOSTICS deleted = ROW_COUNT;
    RETURN deleted;
END;
$$
LANGUAGE plpgsql;

-- get most purchased product fn 
-- CREATE OR REPLACE FUNCTION get_most_purchased_products(topX integer)
-- RETURNS SETOF product AS $$
-- BEGIN
--     RETURN QUERY SELECT op.product_id,SUM(quantity) as op.total, prod.title, prod.description, prod.price, prod.category_id
--     FROM public.order_product as op
--     JOIN public.product as prod ON op.product_id = prod.product_id
--     GROUP BY op.product_id, op.total, prod.title, prod.description, prod.price, prod.category_id
--     ORDER BY SUM(quantity) DESC
--     LIMIT topX;
-- END;
-- $$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_most_purchased_products(topX integer)
RETURNS TABLE (
    product_id uuid,
    total_quantity bigint,
    title character varying,
    description character varying,
    price numeric,
    category_id uuid
) AS $$
BEGIN
    RETURN QUERY SELECT prod.product_id, COALESCE(SUM(op.quantity), 0)::bigint as total_quantity, 
        prod.title::character varying, prod.description::character varying, prod.price, prod.category_id::uuid
        FROM public.product as prod
        LEFT JOIN public.order_product as op ON op.product_id = prod.product_id
        GROUP BY prod.product_id, prod.title, prod.description, prod.price, prod.category_id
        ORDER BY total_quantity DESC
        LIMIT topX;
END;
$$ LANGUAGE plpgsql;



