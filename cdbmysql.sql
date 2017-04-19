CREATE TABLE `iptvyw01`.`thwtongji` 
 COLUMN `tjdbkj` `tjdbkj` INT(10) GENERATED ALWAYS AS (0) COMMENT '空间总空间（GB）' ,
 COLUMN `tjsykj` `tjsykj` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '空间实际使用量（GB）' ,
 COLUMN `tjkjsyl` `tjkjsyl` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '空间使用率' ,
 COLUMN `tjepgrl` `tjepgrl` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT 'EPG设计容量' ,
 COLUMN `tjepgsy` `tjepgsy` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT 'EPG峰值使用量。' ,
 COLUMN `tjepgsyl` `tjepgsyl` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT 'EPG使用率。' ,
 COLUMN `tjhmsrl` `tjhmsrl` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '流媒体HMS设计容量。' ,
 COLUMN `tjhmssy` `tjhmssy` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '流媒体HMS峰值' ,
 COLUMN `tjhmssyl` `tjhmssyl` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '流媒体HMS使用率。' ,
 COLUMN `tjgfdb` `tjgfdb` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '高峰点播数量。' ,
 COLUMN `tjgfzb` `tjgfzb` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '高峰直播数量。' ,
 COLUMN `tjgq` `tjgq` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '高清节目点播数量' ,
 COLUMN `tjbq` `tjbq` INT(10) UNSIGNED NULL DEFAULT 0 COMMENT '标清节目点播数量。' ,
 COLUMN `opt1` `opt1` VARCHAR(45) NULL DEFAULT 0 COMMENT '可选字段1。' ,
 COLUMN `opt2` `opt2` VARCHAR(45) NULL DEFAULT 0 COMMENT '可选字段2。' ,
 COLUMN `opt3` `opt3` VARCHAR(45) NULL DEFAULT 0 COMMENT '可选字段3。' ,
 COLUMN `opt4` `opt4` VARCHAR(45) NULL DEFAULT 0 COMMENT '可选字段4。' ,
 COLUMN `opt5` `opt5` VARCHAR(45) NULL DEFAULT 0 COMMENT '可选字段5。' ;

ALTER TABLE `iptvyw01`.`tmp_thwtongji` 
CHANGE COLUMN `createtime` `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建记录的时间。' ,
CHANGE COLUMN `updatetime` `updatetime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '更新记录的人，同时更新updateowner。' ,
CHANGE COLUMN `deletetime` `deletetime` DATETIME NULL COMMENT '删除记录的时间，同时deletefalg更新。' ,
CHANGE COLUMN `deleteowner` `deleteowner` VARCHAR(45) NULL COMMENT '删除记录的人。' ;

ALTER TABLE `iptvyw01`.`tmp_thwtongji` 
CHANGE COLUMN `createtime` `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建记录的时间。' ,
CHANGE COLUMN `updatetime` `updatetime` TIMESTAMP NOT NULL COMMENT '更新记录的人，同时更新updateowner。' ,
CHANGE COLUMN `deletetime` `deletetime` DATETIME NULL COMMENT '删除记录的时间，同时deletefalg更新。' ,
CHANGE COLUMN `deleteowner` `deleteowner` VARCHAR(45) NULL COMMENT '删除记录的人。' ;



CREATE TABLE `iptvyw01`.`thwethTraffic` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID',
  `jiedian` VARCHAR(30) NOT NULL COMMENT '节点名称',
  `ipaddr` VARCHAR(30) NOT NULL COMMENT '网卡IP地址',
  `srvtype` VARCHAR(30) NOT NULL COMMENT '服务类型',
  `ethport` VARCHAR(30) NOT NULL COMMENT '网卡端口号',
  `ethbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '网卡带宽，单位Mbps，默认值为0。',
  `avginput` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均入流，单位bps',
  `avgoutput` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均出流，单位bps',
  `maxinput` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大入流，单位bps',
  `maxoutput` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大出流，单位bps',
  `inputper` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '入流百分比，maxinput/1000/1000/ethbandwidht计算所得，默认值为0。',
  `outputper` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '出流百分比，maxoutput/1000/1000/ethbandwidht计算所得，默认值为0',
  `status` VARCHAR(30) NOT NULL DEFAULT '空' COMMENT '网卡状态描述，OK正常，默认值为空时说明没有网卡状态描述。',
  `ethinfo` VARCHAR(30) NULL COMMENT '网卡端口描述',
  `errornum` INT(10) NOT NULL DEFAULT -1 COMMENT '错误代码，0代表正常，其他数字都不正常，默认是－1。',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC));


ALTER TABLE `iptvyw01`.`tmp_thwethTraffic` 
CHANGE COLUMN `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
CHANGE COLUMN `createtime` `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写' ,
ADD PRIMARY KEY (`id`);

load data local infile "/home/caixiaoming/workspace/iptvyw/input/thwsheji.csv" replace into table thwsheji character set gbk fields terminated by "," lines terminated by "\r\n";

CREATE TABLE `iptvyw01`.`tmp_tztehmsbf` (
  `seqnum` INT UNSIGNED COMMENT '序号',
  `starttime` DATETIME NOT NULL COMMENT '开始时间',
  `endtime` DATETIME NOT NULL COMMENT '结束时间',
  `qryinterval` VARCHAR(30) NOT NULL COMMENT '查询间隔',
  `hmsname` VARCHAR(50) NOT NULL COMMENT '网元位置，节点名字',
  `livenum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'live单播用户数，默认值为0。',
  `livebandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'live单播流量，单位kbps。',
  `vodnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'vod点播用户数，默认值为0。',
  `vodbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'vod点播流量，单位kbps，默认值为0。',
  `tvodnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tvod回看用户数，默认值为0。',
  `tvodbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tvod回看流量，单位kbps，默认值为0。',
  `tstvnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tstv时移用户数，默认值为0。',
  `tstvbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tstv时移流量，单位kbps，默认值为0。',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tztehmsbf` (
  `hmsname` VARCHAR(50) NOT NULL COMMENT '网元位置，节点名字',
  `livenum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'live单播用户数，默认值为0。',
  `livebandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'live单播流量，单位kbps。',
  `vodnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'vod点播用户数，默认值为0。',
  `vodbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'vod点播流量，单位kbps，默认值为0。',
  `tvodnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tvod回看用户数，默认值为0。',
  `tvodbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tvod回看流量，单位kbps，默认值为0。',
  `tstvnum` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tstv时移用户数，默认值为0。',
  `tstvbandwidth` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'tstv时移流量，单位kbps，默认值为0。',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tmp_tztedbkj` (
  `seqnum` INT UNSIGNED COMMENT '序号',
  `starttime` DATETIME NOT NULL COMMENT '开始时间',
  `endtime` DATETIME NOT NULL COMMENT '结束时间',
  `qryinterval` VARCHAR(30) NOT NULL COMMENT '查询间隔',
  `hmsname` VARCHAR(50) NOT NULL COMMENT '网元位置，节点名字',
  `dbsjkj` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点磁阵总空间，默认值为0，单位MB。',
  `dbsykj` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点磁阵使用空间，默认值为0，单位MB',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tztedbkj` (
  `hmsname` VARCHAR(50) NOT NULL COMMENT '网元位置，节点名字',
  `dbsjkj` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点磁阵总空间，默认值为0，单位MB。',
  `dbsykj` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点磁阵使用空间，默认值为0，单位MB',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tztesheji` (
  `nodename` VARCHAR(50) NOT NULL COMMENT '数据库中POP点名字',
  `wgname` VARCHAR(50) COMMENT '网管中POP点名字',
  `epggroupname` VARCHAR(50) COMMENT 'EPG分组中POP点名字',
  `sjkyll` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '可研设计流量，默认值为0。单位Gbps。',
  `sjjdll` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际的设计流量，默认值为0。单位Gbps。',
  `sjhmsbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '流媒体实际的设计点播用户数，默认值为0。',
  `sjepgbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'EPG实际的设计用户数，默认值为0。',
  `sjdbkj` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '存储实际的设计空间，单位TB，默认值为0。',
  `nodeid` VARCHAR(50) NOT NULL COMMENT '数据库中POP点ID',
  `clusterid` VARCHAR(50) NOT NULL COMMENT '数据库中POP点集群ID',
  `clustername` VARCHAR(50) NOT NULL COMMENT '数据库中POP点集群名字',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

ALTER TABLE `iptvyw01`.`tztesheji` 
CHANGE COLUMN `epgname` `epggroupname` VARCHAR(50) NOT NULL COMMENT 'EPG分组中POP点名字' ;

load data local infile '/home/caixiaoming/iptvyw01/tztesheji.csv' replace into table tztesheji character set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

CREATE TABLE `iptvyw01`.`tmp_tzteepgbf` (
  `epgdate` DATE NOT NULL COMMENT 'epg并发日期',
  `epgtime` VARCHAR(30) NOT NULL COMMENT 'epg并发时间',
  `epgname` VARCHAR(50) NOT NULL COMMENT 'POP点EPG名字',
  `epgbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'epg实际并发',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tzteepgbf` (
  `epgname` VARCHAR(50) NOT NULL COMMENT 'POP点EPG名字',
  `epgbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'epg实际并发',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tzteepggrpsvr` (
  `epggroupid` INT NOT NULL DEFAULT 0 COMMENT 'EPG分组ID',
  `epggroupname` VARCHAR(50) NOT NULL COMMENT 'EPG分组名字',
  `epgterminalid` INT NOT NULL DEFAULT 0 COMMENT 'EPG名字ID',
  `epgname` VARCHAR(50) NOT NULL COMMENT 'EPG名字',
  `epgipaddr` VARCHAR(30) NOT NULL COMMENT 'EPG IP地址',
  `epgmaxnum` INT UNSIGNED NOT NULL DEFAULT 1 COMMENT 'EPG最大并发数(个)',
  `epgstatus` VARCHAR(30) NOT NULL DEFAULT 2 COMMENT 'EPG状态',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

load data local infile '/home/caixiaoming/iptvyw01/tzteepggrpsvr.csv' replace into table tzteepggrpsvr character set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

CREATE PROCEDURE dbInsertTmp_tztedbkj
INSERT INTO tmp_tztedbkj
(seqnum, starttime, endtime, qryinterval, hmsname, dbsjkj, dbsykj)  
VALUES(%s, %s, %s, %s, %s, %s, %s);

create sql security invoker view

drop view vzteepggrpbf;
CREATE SQL SECURITY INVOKER VIEW vzteepggrpbf
AS SELECT grp.epggroupname AS epggrpname, SUM(grp.epgmaxnum) AS epggrpmaxnum, SUM(bf.epgbf) AS epggrpbf
FROM tzteepggrpsvr grp, tzteepgbf bf
WHERE grp.epgname = bf.epgname
and unix_timestamp(bf.createtime) > unix_timestamp(current_date())
GROUP BY grp.epggroupname
ORDER BY grp.epggroupid;

FLUSH TABLES WITH READ LOCK;FLUSH LOGS; SET GLOBAL binlog_format = 'MIXED'; FLUSH LOGS; UNLOCK TABLES;

drop table tfhsheji;
CREATE TABLE `iptvyw01`.`tfhsheji` (
  `nodearea` VARCHAR(50) NOT NULL COMMENT '节点所有区域',
  `nodeCname` VARCHAR(50) NOT NULL COMMENT '节点中文名字',
  `nodeEname` VARCHAR(50) NOT NULL COMMENT '节点英文名字',
  `nodeid` VARCHAR(50) COMMENT '节点ID',
  `sjkyll` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '可研设计流量，默认值为1。单位Mbps。',
  `sjjdll` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '实际的设计流量，默认值为1。单位Mbps。',
  `sjjdbf` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '流媒体实际的设计点播用户数，默认值为1。',
  `sjdbkj` INT(10) UNSIGNED NOT NULL DEFAULT 1 COMMENT '存储实际的设计空间，单位TB，默认值为1。',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tfhepgsheji` (
  `epgname` VARCHAR(50) NOT NULL COMMENT 'epg服务器名字',
  `epgip` VARCHAR(50) NOT NULL COMMENT 'epg服务器IP',
  `epgsjbf` INT(10) UNSIGNED NOT NULL COMMENT 'epg设计并发',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tfhyewu` (
  `cpEname` VARCHAR(50) NOT NULL COMMENT 'cp业务名称',
  `cpname` VARCHAR(50) NOT NULL COMMENT 'cp业务名称',
  `cptype` VARCHAR(50) NOT NULL COMMENT '业务类型',
  `connzteflag` VARCHAR(1) NOT NULL COMMENT '是否对接中兴标识，只有是/否2个值',
  `onlineflag` VARCHAR(1) NOT NULL COMMENT '是否上线标识，只有是/否2个值',
  `yewurukou` VARCHAR(50) COMMENT '各业务在机顶盒上的入口',
  `cdntype` VARCHAR(50) COMMENT 'cdn类型，注入或者回源',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');
  

CREATE TABLE `iptvyw01`.`tmp_tfhepgbf` (
  `epgip` VARCHAR(50) NOT NULL COMMENT 'epg服务器IP',
  `epgname` VARCHAR(50) NOT NULL COMMENT 'epg服务器名字',
  `epgmaxbf` INT(10) UNSIGNED NOT NULL COMMENT 'epg设计并发',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');
 
CREATE TABLE `iptvyw01`.`tfhepgbf` (
  `epgip` VARCHAR(50) NOT NULL COMMENT 'epg服务器IP',
  `epgname` VARCHAR(50) NOT NULL COMMENT 'epg服务器名字',
  `epgmaxbf` INT(10) UNSIGNED NOT NULL COMMENT 'epg设计并发',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tmp_tfhhmsbf` (
  `hmsdatetime` DATETIME NOT NULL COMMENT '峰值并发发生的时间',
  `nodeEname` VARCHAR(50) NOT NULL COMMENT '节点英文名字',
  `cpname` VARCHAR(50) NOT NULL COMMENT '业务名称',
  `maxoutput` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大出流，单位Mbps',
  `maxinput` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大入流，单位Mbps',
  `maxhmsbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大并发数',
  `maxbacksrc` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大并发数',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tfhhmsbf` (
  `hmsdatetime` DATETIME NOT NULL COMMENT '峰值并发发生的时间',
  `nodeEname` VARCHAR(50) NOT NULL COMMENT '节点英文名字',
  `cpname` VARCHAR(50) NOT NULL COMMENT '业务名称',
  `maxoutput` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大出流，单位Mbps',
  `maxinput` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大入流，单位Mbps',
  `maxhmsbf` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大并发数',
  `maxbacksrc` INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大并发数',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tmp_tfhdbspace` (
  `nodeEname` VARCHAR(50) NOT NULL COMMENT '节点英文名字',
  `dbdatetime` DATETIME NOT NULL COMMENT '峰值并发发生的时间',
  `usedspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间，单位MB',
  `freespace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '剩余空间，单位MB',
  `totalspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '总空间空间，单位MB',
  `usedpercent` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间百分比，单位%',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

CREATE TABLE `iptvyw01`.`tfhdbspace` (
  `nodeEname` VARCHAR(50) NOT NULL COMMENT '节点英文名字',
  `dbdatetime` DATETIME NOT NULL COMMENT '峰值并发发生的时间',
  `usedspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间，单位MB',
  `freespace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '剩余空间，单位MB',
  `totalspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '总空间空间，单位MB',
  `usedpercent` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间百分比，单位%',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0');

truncate table tfhepgsheji;
load data local infile '/home/caixiaoming/iptvyw01/tfhepgsheji.csv' replace into table tfhepgsheji character set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

truncate table tfhyewu;
load data local infile '/home/caixiaoming/iptvyw01/tfhyewu.csv' replace into table tfhyewu character set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';

truncate table tfhsheji;
load data local infile '/home/caixiaoming/iptvyw01/tfhsheji.csv' replace into table tfhsheji character set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';


CREATE TABLE `iptvyw01`.`tzteDayRpt` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `nodename` VARCHAR(50) NOT NULL COMMENT '节点名字',
  `avgwidth` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `sjjdll` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '设计节点流量',
  `dbdatetime` DATETIME NOT NULL COMMENT '峰值并发发生的时间',
  `usedspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间，单位MB',
  `freespace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '剩余空间，单位MB',
  `totalspace` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '总空间空间，单位MB',
  `usedpercent` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '已使用空间百分比，单位%',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用。',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用。',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用。',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0'
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `id_UNIQUE` (`ID` ASC));
