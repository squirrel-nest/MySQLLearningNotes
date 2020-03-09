rem MySQL_HOME 本地MySQL的安装路径
rem host mysql 服务器的ip地址，可以是本地，也可以是远程
rem port mysql 服务器的端口，缺省为3306
rem user password 具有操作数据库权限的用户名和密码，如root
rem default-character-set 数据库所用的字符集
rem database 要连接的数据名，这里用的qc1
rem test.sql 要执行的脚本文件，这里为mysql.sql
rem mysql 后面的应该放在一行。
set MySQL_HOME=D:\database\MySQL\MySQL Server 5.1
set PATH=%MySQL_HOME%\bin;%PATH%
mysql --host=localhost --port=3306 --user=root --password=sa --default-character-set=utf8 qc1 < mysql.sql
pause