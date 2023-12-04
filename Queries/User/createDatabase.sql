-- datatype annotation 
CREATE TYPE role  AS ENUM ('admin', 'customer');

-- create user entity
CREATE TABLE IF NOT EXISTS public."user"
(
    user_id uuid NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    email character varying COLLATE pg_catalog."default" NOT NULL,
    password character varying COLLATE pg_catalog."default" NOT NULL,
    avatar character varying COLLATE pg_catalog."default" NOT NULL,
    user_role role NOT NULL,
    CONSTRAINT user_pkey PRIMARY KEY (user_id),
    CONSTRAINT user_email_unique UNIQUE (email)
)