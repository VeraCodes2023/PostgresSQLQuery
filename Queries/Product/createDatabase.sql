-- create database 
CREATE DATABASE "e-commerce"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

-- create product entity
CREATE TABLE IF NOT EXISTS public.product
(
    product_id uuid NOT NULL,
    title character varying COLLATE pg_catalog."default" NOT NULL,
    description character varying COLLATE pg_catalog."default" NOT NULL,
    price numeric NOT NULL,
    category_id uuid NOT NULL,
    CONSTRAINT product_pkey PRIMARY KEY (product_id),
    CONSTRAINT category FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT product_price_positive CHECK (price > 0::numeric) NOT VALID
)

-- create product_image entity
CREATE TABLE IF NOT EXISTS public.product_image
(
    image_id uuid NOT NULL,
    url character varying COLLATE pg_catalog."default",
    product_id uuid NOT NULL,
    CONSTRAINT product_image_pkey PRIMARY KEY (image_id),
    CONSTRAINT product_image_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)










