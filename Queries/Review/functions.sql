-- create a new review 
CREATE OR REPLACE FUNCTION get_all_reviews()
RETURNS SETOF review AS $$
BEGIN
RETURN QUERY SELECT * FROM public.review;
END;
$$ LANGUAGE plpgsql;

-- get an view by id
CREATE OR REPLACE FUNCTION get_review_by_id(id uuid)
RETURNS review AS $$
DECLARE
	r review;
BEGIN
	IF NOT EXISTS (SELECT * FROM public.review WHERE review_id = id)
	THEN RAISE EXCEPTION no_data_found USING message = 'Review id not found';
	END IF;

	SELECT * INTO r FROM public.review WHERE review_id = id;
	RETURN r;

	EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

-- get view by product_id
CREATE OR REPLACE FUNCTION get_reviews_by_product(productID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.product WHERE product_id = productID)
	THEN RAISE EXCEPTION no_data_found USING message = 'Product not found';
	END IF;

	RETURN QUERY SELECT * FROM public.review WHERE product_id = productID;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

-- get view by user_id
CREATE OR REPLACE FUNCTION get_reviews_by_user(userID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = userID)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
	END IF;

	RETURN QUERY SELECT * FROM public.review WHERE user_id = userID;

    EXCEPTION
		WHEN no_data_found THEN RAISE;
END;
$$ LANGUAGE plpgsql;

-- create a new review
CREATE OR REPLACE FUNCTION add_review(rating integer, content text, productID uuid, userID uuid)
RETURNS SETOF review AS $$
BEGIN
    IF NOT EXISTS (SELECT * FROM public.user WHERE user_id = userID)
	THEN RAISE EXCEPTION no_data_found USING message = 'User not found';
    ELSIF NOT EXISTS (SELECT * FROM public.product WHERE product_id = productID)
	THEN RAISE EXCEPTION no_data_found USING message = 'Product not found';
	END IF;
    RETURN QUERY 
        INSERT INTO public.review (review_id, rating, content, review_date, product_id, user_id)
        VALUES(gen_random_uuid(), rating, content, now(), productID, userID)
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- update review
CREATE OR REPLACE FUNCTION update_review(reviewID uuid, new_rating integer, new_content text)
RETURNS SETOF review AS $$
BEGIN
    RETURN QUERY
        UPDATE public.review
        SET rating = COALESCE(new_rating, rating),
        content = COALESCE(new_content, content),
        WHERE review_id = reviewID
        RETURNING *;
END;
$$ LANGUAGE plpgsql;

-- delete review 
CREATE OR REPLACE FUNCTION delete_review(review_id_param UUID) RETURNS BOOLEAN AS
$$
DECLARE
    deleted BOOLEAN;
BEGIN
    deleted := FALSE;
    DELETE FROM public.review WHERE review_id = review_id_param;
    GET DIAGNOSTICS deleted = ROW_COUNT;

    RETURN deleted;
END;
$$
LANGUAGE plpgsql;
