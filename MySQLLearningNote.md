# MySQL Learning Note

## 安装与配置
   * 官网参考
   * 参考
      + :heavy-check-:[INsteafdafafd](http:\\fdafafa)<br>



## 备份与恢复
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
## 数据库管理
   * 权限与角色管理（Using Roles）
   * 用户管理
      + 添加用户
         - 方法 1
         ```sql
            6.3.3 Removing User Accounts

            DROP USER 'root'@'%';

            FLUSH PRIVILEGES;

            13.7.1.1. CREATE USER Syntax
            # 创建用户
            CREATE USER 'root'@'132.97.221.219' IDENTIFIED BY '!13YXmcq';
            # 赋予权限
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'132.97.221.219'
            WITH GRANT OPTION;

            CREATE USER 'tool'@'132.97.221.219' IDENTIFIED BY 'tool123';
            GRANT ALL PRIVILEGES ON *.* TO 'tool'@'132.97.221.219'
            WITH GRANT OPTION;

            CREATE USER 'tool'@'132.97.221.219' IDENTIFIED BY 'tool123';
            GRANT ALL PRIVILEGES ON *.* TO 'tool'@'132.97.221.219'
            WITH GRANT OPTION;



            ------mysql 外网登陆。为何要两个啊（实际是转换成映射的电脑登陆），不用第一个的！！！
            ---------------------------------------------------------------------
            CREATE USER 'root'@'tomcat1.in.3322.org' IDENTIFIED BY 'root123Root';
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'tomcat1.in.3322.org' WITH GRANT OPTION;

            CREATE USER 'root'@'192.168.0.12' IDENTIFIED BY 'root123';
            GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.0.12' WITH GRANT OPTION;
            ---------------------------------------------------------------------


            mysql> CREATE USER 'monty'@'localhost' IDENTIFIED BY 'some_pass';
            mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty'@'localhost'
            -> WITH GRANT OPTION;
            mysql> CREATE USER 'monty'@'%' IDENTIFIED BY 'some_pass';
            mysql> GRANT ALL PRIVILEGES ON *.* TO 'monty'@'%'
            -> WITH GRANT OPTION;
            mysql> CREATE USER 'admin'@'localhost';
            mysql> GRANT RELOAD,PROCESS ON *.* TO 'admin'@'localhost';
            mysql> CREATE USER 'dummy'@'localhost';

            GRANT ALL PRIVILEGES ON *.* TO 'tool'@'%'


            CREATE USER 'gd4g'@'%' IDENTIFIED BY 'gd4g123';

            CREATE USER 'root'@'%' IDENTIFIED BY '!13YXmcq';

            mysql -u root -p --socket=/tmp/mysql_3311.sock

            UPDATE mysql.user SET Password = PASSWORD('root123') WHERE User = 'root';
            FLUSH PRIVILEGES;

            CREATE USER 'multi_admin'@'localhost' IDENTIFIED BY 'multi_admin123';
            grant shutdown on *.* to multi_admin@localhost identified by 'multi_admin123' with grant option;
            show grants for 'multi_admin'@'localhost';

         
         
         
         ```
      + 密码设置
         - 方法 1
         ```sql
            shell> mysql -u root
            mysql> SET PASSWORD FOR 'root'@'localhost' = PASSWORD('newpwd');
            mysql> SET PASSWORD FOR 'root'@'127.0.0.1' = PASSWORD('newpwd');
            mysql> SET PASSWORD FOR 'root'@'::1' = PASSWORD('newpwd');
            mysql> SET PASSWORD FOR 'root'@'%' = PASSWORD('newpwd');


         ```
         - 方法 2
         ```sql

            shell> mysql -u root
            mysql> UPDATE mysql.user SET Password = PASSWORD('newpwd') WHERE User = 'root';
            mysql> FLUSH PRIVILEGES;

         ```
         - 方法 3
         ```sql
            shell> mysqladmin -u root password "newpwd" -- mysqladmin: [Warning] Using a password on the command line interface can be inse
            cure.
            shell> mysqladmin -u root -h host_name password "newpwd"


         
         ```
## 数据库操作
   * 创建数据库
      + 创建脚本
      ```sql
          CREATE database testdb
      ```
      + 执行脚本方式
         - 方法 1
            * dadfadfa
         - 方法 2
            * dfadfafa
   * 创建表
   * 创建索引
## MySQL 与 MacOS
   * 原来安装的Mysql备忘
   
      + 开机自动启动 - 停止脚本
      ```bash
         sudo launchctl stop com.oracle.oss.mysql.mysqld.plist 
      ```
      + 开机启动 - 卸载脚本 参考：XMind文档：自动启动程序的方法
      ```bash
          sudo launchctl unload com.oracle.oss.mysql.mysqld.plist
      ```
      ```bash
         # 永久卸载
         sudo launchctl unload -w com.oracle.oss.mysql.mysqld.plist
      ```
      + 原启动脚本
      ```bash
          /usr/local/mysql/bin/mysqld --user=_mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data --plugin-dir=/usr/local/mysql/lib/plugin --log-error=/usr/local/mysql/data/mysqld.local.err --pid-file=/usr/local/mysql/data/mysqld.local.pid --keyring-file-data=/usr/local/mysql/keyring/keyring --early-plugin-load=keyring_file=keyring_file.so   
     ```
