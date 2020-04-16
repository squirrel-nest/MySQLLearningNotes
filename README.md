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
     
