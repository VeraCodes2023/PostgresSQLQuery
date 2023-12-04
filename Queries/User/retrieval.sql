-- create user
select * from create_user('Lydia','lydia@mail.com','password123','www.lydiaavatar.com','admin')
-- retrieve all users
SELECT * FROM get_all_users();
-- retrieve a single user
SELECT * FROM get_single_user('25cbe9a1-759b-4a29-b5e0-4f4a87c279c9');
-- retrieve a single user
select * from  delete_user('271044fd-9406-4c98-ac4d-d30c504d79ba')
-- update a user
SELECT * FROM update_user('0bdff494-cba2-4699-b70c-3af98caffe21','Emily Lee');
