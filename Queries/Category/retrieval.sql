--  create_category(new_name VARCHAR,new_image VARCHAR) 
SELECT create_category('Home Decoration', 'image_url');
-- get all categories()
SELECT * FROM get_all_categories();
-- get one category(category_id_param UUID)
select * from get_category_by_id('a2e107ac-11e0-4482-ab6b-afe017520a98');
-- update category(category_id_param UUID,new_name VARCHAR,new_image VARCHAR)
select * from update_category('a2e107ac-11e0-4482-ab6b-afe017520a98','Local Fruits','www.localfruits.com')
-- fdb26860-7f38-4b27-a1a6-e8a295736929
SELECT * FROM delete_category('98406540-9505-455e-96d9-3406bf836779')