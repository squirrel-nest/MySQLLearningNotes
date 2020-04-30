# MySQL Learning Note

## 安装与配置
   * 安装
       + 官网参考
          - CentOS
             * [MySQL Community Downloads](https://dev.mysql.com/downloads/file/?id=492677)<br>
             * 下载脚本
                + wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-8.0.19-el7-x86_64.tar.gz<br>
       + 参考
   * 配置
       + 官网参考
       + 参考
## 数据库管理
   * 数据库启动与停止
      + 启动
         * 方法一
         ```sql
         ./mysqld --datadir=/Users/jennywang/data/mysqldatadev/data_8.0.19 --console # 使用指定数据库
         ./mysqld --console # 使用默认的数据库，顺序详见MySQL书本第xx页
         

         ```
      + 停止
         * 方法一
         ```sql
       
         ```
   * 数据库连接
      + 本地连接
     ```sql
         mysql -h 192.168.0.104 -u root -p
         mysql -h localhost -u root -p
     ```
      + 远程连接
      ```sql
          CREATE USER 'root'@'192.168.1.6' IDENTIFIED BY 'root123'; # 创建用户
          GRANT ALL PRIVILEGES ON *.* TO 'root'@'192.168.1.6'; # 赋予用户权限
       
       # 成功后会出现这行代码
       # Query OK, 0 rows affected (0.02 sec)
      ```
      ```sql
          # 只有一个MySql实例的时候使用下面的语句
          mysql -u root -p;
          # 服务器端有多个sql实例
          mysql -u root -p --socket=/tmp/mariadb.sock;
          mysql -u root -p --socket=/tmp/mariadb_3305.sock; # 服务器端有多个sql实例，端口模式
          也可以：
          mysql -u root -p -P3305     -- 说明：-P表示端口；-p表示是Password
          mysql -u root -p -h 192.168.0.104 -P 3307
          是否成功
          不成功
          是否忘记
          初始密码
          是
          Reset the Root Password
          B.5.3.2 How to Reset the Root Password
          步骤
          1.
          Log on to your system as Administrator.
          2.
          Stop the MySQL server if it is running.
          3.
          Create a text file containing the password-assignment statement on a single line.
          E:\Softwares\Oracle\Database\MySQL\mysql-init.txt
          # MySQL 5.7.6 and later:
          ALTER USER 'root'@'localhost' IDENTIFIED BY 'root123';
          4.
          Open a console window to get to the command prompt
          5. 
          Start the MySQL server with the special --init-file option (notice that the backslash in the option value is doubled):
          步骤
          1.可以先进入目录
          C:\> cd "E:\Softwares\Oracle\Database\MySQL\mysql-8.0.13-winx64\bin"
          2. 
          方法 1
          mysqld --init-file=E:/Softwares/Oracle/Database/MySQL/mysql-init.txt
          方法 2
          推荐，已经设置了MYSQL_HOME,可以直接运行命令
          E:\> mysqld --init-file=E:\\Softwares\\Oracle\\Database\\MySQL\\mysql-init.txt
          否
          成功
          ```
          * 用户管理
          + 密码设置
          ```sql
          shell> mysql -u root
          mysql> UPDATE mysql.user SET Password = PASSWORD('newpwd') WHERE User = 'root';
          mysql> FLUSH PRIVILEGES;

          shell> mysqladmin -u root password "newpwd" -- mysqladmin: [Warning] Using a password on the command line interface can be insecure.
          shell> mysqladmin -u root -h host_name password "newpwd"
      ```
## 数据库操作
   * 创建数据库
      + 创建脚本
      ```sql
          CREATE database testdb
      ```
   * 创建表
   * 创建索引
   
## 数据库维护
   # 数据库测试命令
   ```sql
        Checking&Query The Server
        2.9.3 Testing the Server
        shell> bin/mysqladmin version
        shell> bin/mysqladmin variables
        mysqladmin version status proc
        shell> bin/mysqladmin -u root -p version
        Enter password: (enter root password here)
        shell> bin/mysqlshow
        shell> bin/mysqlshow mysql

        mysqlshow -u root mysql
        shell> bin/mysql -e "SELECT User, Host, plugin FROM mysql.user" mysql
   ```
   
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

## 临时
   * MySQL 的 JSON 字段
      + [11.5 The JSON Data Type](https://dev.mysql.com/doc/refman/8.0/en/json.html)<br>
   * H2Database 的相关知识
      + [SQL Grammar](https://h2database.com/html/grammar.html#json)<br>
      + /Users/jennywang/data/mysqldatadev/data_8.0.19
