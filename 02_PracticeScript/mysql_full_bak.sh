#vi mysql_full_bak.sh
#!/bin/bash
# 建立全备份，一个全备份一个文件夹，一个库一个文件夹，一个表一个文件，备份保留3天，移除3天前的备份
# 2014-04-04
# wangyu

user=root  
passwd=
databak_dir=/data1/mysql/data/backup/
DATE=`date +%Y%m%d`
logFile=$databak_dir/logs/mysql$DATE.log
database=factdb
cd /data
dumpFile=$database$DATE.sql
#GZDumpFile=$database$DATE.tar.gz
options="-u$user -p$passwd --opt --extended-insert=false --triggers=false -R --hex-blob --flush-logs --delete-master-logs -B $database"
mysqldump $options > $dumpFile  #导出数据文件
if [[ $? == 0 ]]; then
  #tar cvzf $GZDumpFile $dumpFile >> $eMailFile 2>&1
  #echo "BackupFileName:$GZDumpFile" >> $eMailFile
  #echo "DataBase Backup Success" >> $eMailFile
  #scp $GZDumpFile 地址”:/Dir   #传送备份文件到另一台计算机，需要做好ssh信任
  #rm -f $dumpFile           #删除备份的文件
  #rm –rf $databak_dir/daily/*  #删除每天备份的文件
  echo "$DATE 备份成功"
else
  #echo "DataBase Backup Fail!" >> $emailFile
  #mail -s " DataBase Backup Fail " $eMail < $eMailFile  #如果备份不成功发送邮件通知
  echo "$DATE 备份失败" >> $logFile
fi

#cat $eMailFile >> $logFile