# mySQLNotes



# 脚本记录
## 查询数据库和表的创建脚本
   * ```sql
         show create database `web_customer_tracker`;
         show create table `customer`;
     ```
## 备份表
   * ```sql
         SELECT * FROM web_customer_tracker.customer;
         create table web_customer_tracker.customer_withjson as select * from web_customer_tracker.customer;
     ```
## 更改数据库或表的编码格式
   * ```sql
         alter table customer convert to character set utf8;
     ```
## 脚本备忘
   * 创建 web_customer_tracker.customer 脚本
      + ```sql
           CREATE  TABLE IF NOT EXISTS customers (
           id INT UNSIGNED NOT NULL AUTO_INCREMENT ,
           fullname VARCHAR(45) NOT NULL ,
           email VARCHAR(45) NOT NULL ,
           address VARCHAR(245) NOT NULL ,
           city VARCHAR(45) NOT NULL ,
           course VARCHAR(245) NOT NULL ,
           PRIMARY KEY (id) )
         ENGINE = InnoDB
         COMMENT = 'maintains customer details'
         character set utf8;
         INSERT INTO customers (fullname, email, address, city, course)
         VALUES ('Java DukeMan', 'duke@java.com', 'Sun Microsystems', 'California', 'Java Enterprise for Beginners');
        ```
   * 增加字段脚本
      + ```sql
           ALTER TABLE customer ADD field_name TEXT;
        ```
   * 更改字段脚本
      + ```sql
           ALTER TABLE customer CHANGE field_name json_data TEXT;

           ALTER TABLE `web_customer_tracker`.`customer` CHANGE COLUMN `json_data` `user_details` JSON NULL DEFAULT NULL;

           ALTER TABLE `web_customer_tracker`.`customer` CHANGE COLUMN `user_details` `user_detail` JSON NULL DEFAULT NULL;
        ```
   * 删除字段脚本
      + ```sql
           ALTER TABLE web_customer_tracker.customer DROP COLUMN primaryaddress;

           ALTER TABLE web_customer_tracker.customer DROP COLUMN user_detail;
        ```
   * JSON字段的常用操作
      + ```sql
           
          SELECT JSON_EXTRACT(user_details, "$.primaryAddress") AS primaryAddress, JSON_EXTRACT(user_details, "$.nickname") AS nickname
          FROM customer
          WHERE JSON_EXTRACT(user_details, "$.nickname") = "micky"

          ALTER TABLE web_customer_tracker.customer ADD COLUMN primaryaddress json GENERATED ALWAYS AS (user_detail->>'$.primaryAddress');
          ALTER TABLE web_customer_tracker.customer ADD INDEX idx_user_detail (user_detail ASC);

        ```
    * 数据操作
       + 更新数据操作
          - 注意：需要查看：
             * ```sql
                  show variables like 'SQL_SAFE_UPDATES';
                  
                  sql_safe_updates	OFF
                 
                  -- disable safe update mode
                  SET SQL_SAFE_UPDATES=0;
                  -- execute update statement
                  UPDATE table SET column='value';
                  -- enable safe update mode
                  SET SQL_SAFE_UPDATES=1;
               ```
          - ```sql
             update  web_customer_tracker.customer_withjson t set t.email = "xiaomi@mi.com" where t.id = 7;
            ```
    
