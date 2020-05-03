# mySQLNotes



# 脚本记录
## 数据库的指定方法
   1. 指定数据库
      * use database_name;
   2. 对象之前加数据库名称
      * select * from database_name.table_name;
## 在MySQL下查看当前使用的是哪个数据库
   * 三种方法
      1. mysql> status;
         * 其中：Current database: web_customer_tracker
      2. mysql> select database();
      3. mysql> show tables;
         * +----------------------------------+<br>
           | Tables_in_web_customer_tracker |<br>
           +----------------------------------+<br>
## 查询数据库和表的创建脚本
   * ```sql
         show create database `web_customer_tracker`;
         show create table `customer`;
     ```
## 查询数据库和表相关信息 - 参考: 3.4 Getting Information About Databases and Tables
   * ```sql
       SELECT DATABASE();
     ```
## 查询表结构（Table Schema） - 参考: 3.4 Getting Information About Databases and Tables
   * ```sql
       DESCRIBE customer;
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
   * 创建 web_customer_tracker.customer 脚本 - 注意：id MEDIUMINT NOT NULL AUTO_INCREMENT 的使用
      + ```sql
            use web_customer_tracker;
           
            CREATE TABLE `customer` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `first_name` varchar(45) DEFAULT NULL,
              `last_name` varchar(45) DEFAULT NULL,
              `email` varchar(45) DEFAULT NULL,
              PRIMARY KEY (`id`)
            ) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

            LOCK TABLES `customer` WRITE;

            INSERT INTO `customer` VALUES 
               (1,'David','Adams','david@gmail.com'),
               (2,'John','Doe','john@gmail.com'),
               (3,'Ajay','Rao','ajay@gmail.com'),
               (4,'Mary','Public','mary@gmail.com'),
               (5,'Maxwell','Dixon','max@gmail.com');

            UNLOCK TABLES;

            # customers 表是 与 customer 表 结构不一样，用 DESCRIBE customers; 查表结构！！
            
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
   * 创建表索引 - 索引比较复杂，需要深入学习。注意 functional key 的使用。 MySQL 8.0.13 and higher 才支持。 -这里没有说明，参考文档
      + ```sql
          CREATE INDEX IDX_CUSTOMER_FULLNAME ON customer (fullname(10));
      
          CREATE UNIQUE INDEX IDX_CUSTOMER_ID ON CUSTOMER(id) USING BTREE;
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
      + Add 数据记录 - 参考： 3.3.3 Loading Data into a Table
         - 直接执行脚本的方法 - 特别注意：如果没有 Primary Key自动增长设置，ID字段要包括，如果Primary Key设置了 自动增长，则不需要包括ID字段
            * ```sql
                  use web_customer_tracker;
                 INSERT INTO `customer` VALUES 
                   (1,'David','Adams','david@gmail.com'),
                   (2,'John','Doe','john@gmail.com'),
                   (3,'Ajay','Rao','ajay@gmail.com'),
                   (4,'Mary','Public','mary@gmail.com'),
                   (5,'Maxwell','Dixon','max@gmail.com'),
                     
                   (6,'wanglai','wang','aaa@sina.com'),
                   (7,'小米','雷','xiaomi@mi.com');
                   
              ```
         - 调用脚本文件的方法（非load，只是执行脚本文件中的脚本） - 例子参见：[Sample_SqlScript_test.txt](https://github.com/huarui0/MySQLLearningNote/blob/master/02_PracticeScript/my_script/Sample_SqlScript_test.txt) 中的例子<br>
            * >+--------+------+-----------------------------+线下面的例子
            * Terminal命令行模式
               - ```sql
                     e:\***\***\lzdata-ee-8-jaxrs-new\src\main\resources\sqlscript\mysql>mysql -u root  -p < database-web_customer_tracker-scripts.sql;
                 ```
            * 终端登陆MySQL模式 - 特别注意：Widnows下，Path不能用反斜杠(\) - 以下语句可行
               - ```sql
                     source E:/JavaEEDev/JavaEELearningCode/lzdata-ee-8-jaxrs-new/src/main/resources/sqlscript/mysql/mysql_test.sql;
                 ```

         - 加载数据的方法 - load 命令 - 与 导入与导出（备份与恢复）的比较。
            * ```sql
                  mysql> use web_customer_tracker;
                  mysql> LOAD DATA LOCAL INFILE 'E:/JavaEEDev/JavaEELearningCode/lzdata-ee-8-jaxrs-new/src/main/resources/sqlscript/mysql/data_web_customer_tracker.txt' INTO TABLE web_customer_tracker.customer;
              ```
         - 导入导出（备份恢复）数据的方法，参见：[数据库的备份与恢复](#数据库的备份与恢复)<br>



      + 清除数据库的方法
         - 全部删除
            1. delete的方法
               * ```sql
                     use customer_test;
                     delete from customer_test;
                 ```
            2. trancate的方法 - 不用写日志，快速，建议使用
               * ```sql
                     use customer_test;
                    truncate table customer_test;
                 ```
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
## 数据库的备份与恢复
   * 备份
      + 
      + 步骤
         1. 连接数据库
            - 注意事项
               * 连接数据库前，要更改my.cnf（my.ini in widonws system)，将datadir参数（如：datadir=D:/MySqlDataDev/data_8.0.1）更改为要**导出**数据的数据库文件夹
               * 用于启动数据库的mysql server app，版本要与原来创建数据库的版本一致
         2. 执行导出脚本
         ```bash
             cd D:\MySQLDataDmp
             mysqldump -u root -p --databases jira > databases_jira.sql
         ```
   * 恢复
      + 
      + 步骤
         1. 连接数据库
            - 注意事项
               * 连接数据库前，要更改my.cnf（my.ini in widonws system)，将datadir参数（如：datadir=D:/MySqlDataDev/data_8.0.1）更改为要**导入**数据的数据库文件夹
               * 用于启动数据库的mysql server app，版本要与要导入的数据库的版本一致
         2. 创建与要导入的数据库的空数据库，如：
         ```sql
            CREATE DATABASE jira;
            commit;
         ```
         3. 执行导入脚本
         ```bash
             mysql -u root -p jira < D:\MySQLDataDmp\databases_jira.sql;
         ```
## 数据库表的备份与恢复
