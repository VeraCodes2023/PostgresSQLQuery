-- create category entity

CREATE TABLE IF NOT EXISTS public.category
(
    category_id uuid NOT NULL,
    name character varying COLLATE pg_catalog."default" NOT NULL,
    image character varying COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT category_pkey PRIMARY KEY (category_id)
)