-- create review entity
CREATE TABLE IF NOT EXISTS public.review
(
    review_id uuid NOT NULL,
    rating smallint NOT NULL CHECK (rating >= 1 AND rating <= 5),
    content text COLLATE pg_catalog."default" NOT NULL,
    review_date date NOT NULL,
    product_id uuid NOT NULL,
    user_id uuid NOT NULL,
    CONSTRAINT review_pkey PRIMARY KEY (review_id),
    CONSTRAINT review_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT review_user_id_fkey FOREIGN KEY (user_id)
        REFERENCES public."user" (user_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)