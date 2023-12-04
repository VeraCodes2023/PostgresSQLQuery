-- datatype annotation 
CREATE TYPE order_status AS ENUM ('pending', 'processing', 'shipped', 'delivered', 'completed','cancelled');

-- 5.create order entity
CREATE TABLE IF NOT EXISTS public."order"
(
    order_id uuid NOT NULL,
    user_id uuid NOT NULL,
    order_date date NOT NULL,
    order_status order_status  NOT NULL,
    CONSTRAINT order_pkey PRIMARY KEY (order_id),
    CONSTRAINT order_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public."user" (user_id) MATCH SIMPLE
)

-- 6.create order_product entity
CREATE TABLE IF NOT EXISTS public.order_product
(
    order_id uuid NOT NULL,
    product_id uuid NOT NULL,
    quantity integer NOT NULL,
    CONSTRAINT order_product_order_id_fkey FOREIGN KEY (order_id)
        REFERENCES public."order" (order_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT order_product_product_id_fkey FOREIGN KEY (product_id)
        REFERENCES public.product (product_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID,
    CONSTRAINT order_product_quantity_positive CHECK (quantity > 0) NOT VALID
)


ALTER TABLE order_product
ADD CONSTRAINT order_product_order_id_fkey,
CONSTRAINT order_id_unique UNIQUE (order_id)
FOREIGN KEY (order_id) REFERENCES public."order" (order_id) ON DELETE CASCADE;
