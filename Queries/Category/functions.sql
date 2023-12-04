-- create category fn 
CREATE OR REPLACE FUNCTION create_category(
    category_name_param VARCHAR,
    category_image_param VARCHAR
)
RETURNS TABLE (
    new_category_id UUID,
    new_name VARCHAR,
    new_image VARCHAR
)
AS $$
DECLARE
    new_category RECORD;
BEGIN
    INSERT INTO public.category(category_id, name, image)
    VALUES (gen_random_uuid(), category_name_param, category_image_param)
    RETURNING category_id, name, image INTO new_category;
    RETURN QUERY SELECT new_category.category_id AS new_category_id, new_category.name AS new_name, new_category.image AS new_image;
END;
$$ LANGUAGE plpgsql;

-- get all categories fn 
CREATE OR REPLACE FUNCTION get_all_categories()
RETURNS TABLE (
    category_id UUID,
    category_name VARCHAR,
    category_image VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT c.category_id, c.name AS category_name, c.image AS category_image
    FROM category c;
END;
$$ LANGUAGE plpgsql;

-- get one category by id fn 
CREATE OR REPLACE FUNCTION get_category_by_id(category_id_param UUID)
RETURNS TABLE (
    category_id UUID,
    category_name VARCHAR,
    category_image VARCHAR
) AS $$
BEGIN
    RETURN QUERY
    SELECT c.category_id, c.name AS category_name, c.image AS category_image
    FROM category c
    WHERE c.category_id = category_id_param;
END;
$$ LANGUAGE plpgsql;

-- update category fn 
CREATE OR REPLACE FUNCTION update_category(
    category_id_param UUID,
    new_name VARCHAR,
    new_image VARCHAR
)
RETURNS TABLE(categoryID uuid, categoryName varchar, categoryImage varchar) AS $$
BEGIN
    RETURN QUERY
        UPDATE category
        SET name = COALESCE(new_name, name), image = COALESCE(new_image, image)
        WHERE category_id = category_id_param
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- delete category fn 
CREATE OR REPLACE FUNCTION delete_category(category_id_param UUID) RETURNS BOOLEAN AS
$$
DECLARE
    deleted BOOLEAN;
BEGIN
    deleted := FALSE;
    DELETE FROM public.category WHERE category_id = category_id_param;
    GET DIAGNOSTICS deleted = ROW_COUNT;
    RETURN deleted;
END;
$$
LANGUAGE plpgsql;

