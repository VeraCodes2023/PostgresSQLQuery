-- create user fn
CREATE OR REPLACE FUNCTION create_user(
    user_name VARCHAR,
    user_email VARCHAR,
    user_password VARCHAR,
    user_avatar VARCHAR,
    user_role_value role
)
RETURNS TABLE (
    returned_user_id UUID,
    returned_name VARCHAR,
    returned_email VARCHAR,
    returned_avatar VARCHAR,
    returned_user_role role
) AS $$
DECLARE
    new_user_id UUID;
BEGIN
    INSERT INTO "user" (name, email, password, avatar, user_role)
    VALUES (user_name, user_email, user_password, user_avatar, user_role_value)
    RETURNING user_id, name, email, avatar, user_role INTO
        new_user_id, returned_name, returned_email, returned_avatar, returned_user_role;

    returned_user_id := new_user_id;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-- query all users fn
CREATE OR REPLACE FUNCTION get_all_users()
RETURNS TABLE(
    user_id UUID,
    name VARCHAR,
    email VARCHAR,
    avatar VARCHAR,
    user_role role
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.user_id, u.name, u.email, u.avatar, u.user_role
    FROM public."user" u;
END;
$$ LANGUAGE plpgsql;

-- single user query fn 
CREATE OR REPLACE FUNCTION get_single_user(user_id_param UUID)
RETURNS TABLE (
    user_id UUID,
    name VARCHAR,
    email VARCHAR,
    avatar VARCHAR,
    user_role role
) AS $$
BEGIN
    RETURN QUERY
    SELECT u.user_id, u.name, u.email, u.avatar, u.user_role
    FROM public."user" u
    WHERE u.user_id = user_id_param;
END;
$$ LANGUAGE plpgsql;

-- update user query fn 
CREATE OR REPLACE FUNCTION update_user(user_id_param UUID, new_name VARCHAR, new_email VARCHAR, new_avatar VARCHAR)
RETURNS TABLE (
    updated_id UUID,
    updated_name VARCHAR,
    updated_email VARCHAR,
    updated_avatar VARCHAR,
    updated_user_role role
) AS $$
BEGIN
    UPDATE public."user"
    SET name = COALESCE(new_name, name),
        email = COALESCE(new_email, email),
        avatar = COALESCE(new_avatar, avatar)
    WHERE user_id = user_id_param
    RETURNING user_id, name, email, avatar, user_role INTO
        updated_id, updated_name, updated_email, updated_avatar, updated_user_role;

    RETURN NEXT;
END;
$$ LANGUAGE plpgsql;

-- delete user query fn 
CREATE OR REPLACE FUNCTION delete_user(user_id_param UUID) RETURNS BOOLEAN AS
$$
DECLARE
    deleted BOOLEAN;
BEGIN
    deleted := FALSE;
    DELETE FROM public."user" WHERE user_id = user_id_param;
    GET DIAGNOSTICS deleted = ROW_COUNT;

    RETURN deleted;
END;
$$
LANGUAGE plpgsql;

