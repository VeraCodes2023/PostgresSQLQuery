-- get all reviews 
select * from get_all_reviews();
-- get one review by review_id
select * from get_review_by_id('6010a088-0e5a-4677-9723-51dafac8b239');
-- get one review by product_id
select * from get_reviews_by_product('69d4c6a1-25ce-4f87-9442-46d4d0f2db5e');
-- get one review by user_id
select * from get_reviews_by_user('9536b5c4-20d0-445e-a6ae-7004a6ee474e');
-- update review 
select * from update_review('2f5e6494-9bda-4d20-a2f4-ce442e3d246e','4','updated fake content');
-- create review 
select * from add_review('3','rating content fake','7ea7a7b5-cc9e-405e-8ab4-c8e3e8dd22f2','0f18904c-e012-4c4e-a599-a4bc953071af');
-- create review 
select * from delete_review('1ed8b9e9-0440-442c-9faf-68b24c5119bc');