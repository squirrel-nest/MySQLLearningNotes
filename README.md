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
## 调用脚本文件的方法
   * Terminal命令行模式
      - ```sql
            e:\***\***\lzdata-ee-8-jaxrs-new\src\main\resources\sqlscript\mysql>mysql -u root  -p < database-web_customer_tracker-scripts.sql;
        ```
   * 终端登陆MySQL模式 - 特别注意：Widnows下，Path不能用反斜杠(\) - 以下语句可行
      - ```sql
            source E:/JavaEEDev/JavaEELearningCode/lzdata-ee-8-jaxrs-new/src/main/resources/sqlscript/mysql/mysql_test.sql;
        ```
## 加载数据的方法
   * ```
     ```
## 脚本备忘 - 创建 Jakarka EE 示例数据库：web_customer_tracker
   * 创建数据库的脚本 - 注意：因为有的操作系统，如Unix or Linux ,database names are case-sensitive, 因此，规定，创建数据库时，**数据库名称全部用小写**
      + ```sql
            use mysql; /*！可以不用 */
            
            CREATE DATABASE  IF NOT EXISTS `web_customer_tracker`
            CHARACTER SET = utf8;
            
            USE `web_customer_tracker`;

        ```
         - 
         
         'CREATE DATABASE `web_customer_tracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION=''N'' */'
   * 创建 web_customer_tracker.customer 脚本
      + ```sql
           use web_customer_tracker;
           
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
    
