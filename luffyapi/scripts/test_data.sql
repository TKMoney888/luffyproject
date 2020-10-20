# 关闭原来表中的主外键约束功能
set FOREIGN_KEY_CHECKS=0;

# 清空原有的课程分类表信息
truncate table ly_course_category;

# 添加课程分类信息
insert into ly_course_category
(name,orders,is_show,is_delete,created_time,updateed_time) VALUES
("python",1,1,0,"2019-11-11 12:00:00","2020-11-11 12:00:00"),
("python进阶",2,1,0,"2019-11-11 12:00:00","2020-11-11 12:00:00"),
("java",3,1,0,"2019-11-11 12:00:00","2020-11-11 12:00:00"),
("前端开发",4,1,0,"2019-11-11 12:00:00","2020-11-11 12:00:00");

# 添加课程信息
INSERT INTO luffy.ly_course
(name, orders, is_show, is_delete, created_time, updateed_time, course_img, course_video, course_type, brief, level, pub_date, period, attachment_path, status, students, lessons, pub_lessons, price, course_category_id, teacher_id)
VALUES
('7天python从入门到放弃', 3, 1, 0, '2020-09-23 07:30:26.966935', '2020-09-23 07:31:04.440506', 'course/2.jpeg', 'course_video/2.jpeg', 0, '33333333333333333333333333333333', 2, '2020-09-23', 71, '123.jpg', 0, 900, 10, 8, 1000.00, 2, 1),
('7天java从入门到放弃', 3, 1, 0, '2020-09-23 07:30:26.966935', '2020-09-23 07:31:04.440506', 'course/2.jpeg', 'course_video/2.jpeg', 0, '33333333333333333333333333333333', 2, '2020-09-23', 71, '123.jpg', 0, 900, 10, 8, 1000.00, 2, 1),
('7天C++从入门到放弃', 3, 1, 0, '2020-09-23 07:30:26.966935', '2020-09-23 07:31:04.440506', 'course/2.jpeg', 'course_video/2.jpeg', 0, '33333333333333333333333333333333', 2, '2020-09-23', 71, '123.jpg', 0, 900, 10, 8, 1000.00, 2, 1),
('7天前端从入门到放弃', 3, 1, 0, '2020-09-23 07:30:26.966935', '2020-09-23 07:31:04.440506', 'course/2.jpeg', 'course_video/2.jpeg', 0, '33333333333333333333333333333333', 2, '2020-09-23', 71, '123.jpg', 0, 900, 10, 8, 1000.00, 2, 1);

# 开启原来表中的主外键约束功能
set FOREIGN_KEY_CHECKS=1;