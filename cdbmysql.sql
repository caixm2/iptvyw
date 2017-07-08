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

ALTER TABLE `thwethTraffic` CHANGE `ethbandwidth` `ethbandwidth` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '网卡带宽，单位Mbps，默认值为0。';
ALTER TABLE `thwethTraffic` CHANGE `avginput` `avginput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均入流，单位bps';
ALTER TABLE `thwethTraffic` CHANGE `avgoutput` `avgoutput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均出流，单位bps';
ALTER TABLE `thwethTraffic` CHANGE `maxinput` `maxinput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大入流，单位bps';
ALTER TABLE `thwethTraffic` CHANGE `maxoutput` `maxoutput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大出流，单位bps';
ALTER TABLE `thwethTraffic` CHANGE `inputper` `inputper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '入流百分比，maxinput/1000/1000/ethbandwidht计算所得，默认值为0。';
ALTER TABLE `thwethTraffic` CHANGE `outputper` `outputper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '出流百分比，maxoutput/1000/1000/ethbandwidht计算所得，默认值为0';

ALTER TABLE `tmp_thwethTraffic` CHANGE `ethbandwidth` `ethbandwidth` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '网卡带宽，单位Mbps，默认值为0。';
ALTER TABLE `tmp_thwethTraffic` CHANGE `avginput` `avginput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均入流，单位bps';
ALTER TABLE `tmp_thwethTraffic` CHANGE `avgoutput` `avgoutput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均出流，单位bps';
ALTER TABLE `tmp_thwethTraffic` CHANGE `maxinput` `maxinput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大入流，单位bps';
ALTER TABLE `tmp_thwethTraffic` CHANGE `maxoutput` `maxoutput` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '最大出流，单位bps';
ALTER TABLE `tmp_thwethTraffic` CHANGE `inputper` `inputper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '入流百分比，maxinput/1000/1000/ethbandwidht计算所得，默认值为0。';
ALTER TABLE `tmp_thwethTraffic` CHANGE `outputper` `outputper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '出流百分比，maxoutput/1000/1000/ethbandwidht计算所得，默认值为0';

ALTER TABLE `iptvyw01`.`tmp_thwethTraffic` 
CHANGE COLUMN `id` `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
CHANGE COLUMN `createtime` `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写' ,
ADD PRIMARY KEY (`id`);

load data local infile "/home/caixiaoming/workspace/iptvyw/input/thwsheji.csv" 
replace INTO table thwsheji character 
set gbk fields terminated by "," lines terminated by "\r\n";

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

load data local infile '/home/caixiaoming/iptvyw01/tztesheji.csv' replace INTO table tztesheji character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

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

load data local infile '/home/caixiaoming/iptvyw01/tzteepggrpsvr.csv' replace INTO table tzteepggrpsvr character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

delete from tzteepgbf
where unix_timestamp(createtime) > unix_timestamp(current_date());
delete from tztedbkj
where unix_timestamp(createtime) > unix_timestamp(current_date());
delete from tztehmsbf
where unix_timestamp(createtime) > unix_timestamp(current_date());
delete from tzteDayRpt
where unix_timestamp(createtime) > unix_timestamp(current_date());
delete from tzteDayRptAreaSum
where unix_timestamp(createtime) > unix_timestamp(current_date());
COMMIT;

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
load data local infile '/home/caixiaoming/iptvyw01/tfhepgsheji.csv' replace INTO table tfhepgsheji character 
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

truncate table tfhyewu;
load data local infile '/home/caixiaoming/iptvyw01/tfhyewu.csv' replace INTO table tfhyewu character 
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';

truncate table tfhsheji;
load data local infile '/home/caixiaoming/iptvyw01/tfhsheji.csv' replace INTO table tfhsheji character 
set utf8 fields terminated by ',' enclosed by '"' lines terminated by '\n';

drop table `iptvyw01`.`tzteDayRpt`;
CREATE TABLE `iptvyw01`.`tzteDayRpt` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `nodename` VARCHAR(50) NOT NULL COMMENT '节点名字',
  `nodeid` VARCHAR(50) NOT NULL COMMENT '节点ID',
  `avgwidth` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `sjjdll` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量',
  `peakjdll` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量',
  `jdllper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量百分比',
  `sjepgbf` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点EPG设计并发',
  `peakepgbf` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值并发',
  `epgbfper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值百分比',
  `sjhmsbf` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发',
  `peakhmsbf` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发',
  `hmsbfper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发百分比',
  `sjdbkj` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间',
  `peakdbkj` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间',
  `dbkjper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间百分比',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用
  ',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `id_UNIQUE` (`ID` ASC));

drop table `iptvyw01`.`tzteDayRptAreaSum`;
CREATE TABLE `iptvyw01`.`tzteDayRptAreaSum` (
  `ID` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `clustername` VARCHAR(50) NOT NULL COMMENT '集群名字',
  `clusterid` VARCHAR(50) NOT NULL COMMENT '集群ID',
  `avgwidth` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `nodenum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '一个区域中有多少个节点',
  `sjjdllsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量区域汇总',
  `peakjdllsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量区域汇总',
  `jdllsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量区域汇总百分比',
  `sjepgbfsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点EPG设计并发区域汇总',
  `peakepgbfsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值并发区域汇总',
  `epgbfsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值区域汇总百分比',
  `sjhmsbfsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发区域汇总',
  `peakhmsbfsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发区域汇总',
  `hmsbfsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发区域汇总百分比',
  `sjdbkjsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间区域汇总',
  `peakdbkjsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间区域汇总',
  `dbkjsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间区域汇总百分比',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `id_UNIQUE` (`ID` ASC));

drop PROCEDURE pzteDayRpt;
delimiter //
create procedure pzteDayRpt()
begin
  INSERT INTO tzteDayRpt(nodename, nodeid, avgwidth, sjjdll, peakjdll, jdllper, sjepgbf, peakepgbf, 
            epgbfper, sjhmsbf, peakhmsbf, hmsbfper, sjdbkj, peakdbkj, dbkjper, 
                        createtime, updatetime, createowner, updateowner)
  select sj.nodename,sj.nodeid, ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,
       round(sj.sjjdll/1024,0) jdll, ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 2) AS bandwidthGbps, 
       ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/(sj.sjjdll/1024)*100,0) AS bandper,
       epg.epggrpmaxnum, epg.epggrpbf, round(epg.epggrpbf/epg.epggrpmaxnum*100,0) as epgper,
       sj.sjhmsbf, hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum AS hmsbf, 
     round((hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sj.sjhmsbf*100,0) AS hmsper,
       round(sj.sjdbkj/1024/1024, 0) AS dbkj, round((sj.sjdbkj-db.dbsykj)/1024/1024, 0) AS sykj, round((sj.sjdbkj-db.dbsykj)/sj.sjdbkj*100, 0) as dbper,
       NOW(), NOW(), USER(), USER()
from tztesheji sj 
left join  tztehmsbf hms
on   sj.wgname = hms.hmsname
left join tztedbkj db
on   sj.wgname = db.hmsname
left join vzteepggrpbf epg
on   sj.epggroupname = epg.epggrpname
where   (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)
and   (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)
order by sj.clusterid, sj.nodename;

INSERT INTO tzteDayRptAreaSum(clustername, clusterid, nodenum, avgwidth, sjjdllsum, peakjdllsum, jdllsumper, 
                          sjepgbfsum, peakepgbfsum, epgbfsumper, sjhmsbfsum, peakhmsbfsum, hmsbfsumper, 
                              sjdbkjsum, peakdbkjsum, dbkjsumper, createtime, updatetime, createowner, updateowner
              )
select sj.clustername, sj.clusterid, count(sj.nodename) as countsum, ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,
       round(sum(sj.sjjdll)/1024, 0) AS jdllsum, ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 0) AS bandwidthGbps, 
       ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/sum(sj.sjjdll)*100,0) AS bandper,
       sum(epg.epggrpmaxnum), sum(epg.epggrpbf), round(sum(epg.epggrpbf)/sum(epg.epggrpmaxnum)*100,0) as epgper,
       sum(sj.sjhmsbf), sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum) AS hmsbf, 
     round(sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sum(sj.sjhmsbf)*100,0) AS hmsper,
       round(sum(sj.sjdbkj)/1024/1024, 0) AS dbkjsum, round((sum(sj.sjdbkj)-sum(db.dbsykj))/1024/1024, 0) AS sykjsum, round((sum(sj.sjdbkj)-sum(db.dbsykj))/sum(sj.sjdbkj)*100, 0) as dbper
       ,NOW(), NOW(), USER(), USER()
from tztesheji sj 
left join  tztehmsbf hms
on   sj.wgname = hms.hmsname
left join tztedbkj db
on   sj.wgname = db.hmsname
left join vzteepggrpbf epg
on   sj.epggroupname = epg.epggrpname
where   (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)
and   (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)
group by sj.clusterid
order by sj.clusterid, sj.nodename;
COMMIT;
end //
delimiter ;

drop event ezteDayRptM;
delimiter //
CREATE event IF NOT EXISTS ezteDayRptM
  ON SCHEDULE EVERY 1 MINUTE  
  STARTS '2017-3-27 16:13:00'
  ON COMPLETION NOT PRESERVE ENABLE
  DO 
  BEGIN
      call iptvyw01.pzteDayRpt();
  END//
delimiter ;

drop table `iptvyw01`.`thwDayRpt`;
CREATE TABLE `iptvyw01`.`thwDayRpt` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `quju` VARCHAR(50) NOT NULL COMMENT '区局名字',
  `nodename` VARCHAR(50) NOT NULL COMMENT '节点名字',
  `upid` VARCHAR(50) NOT NULL COMMENT '上级节点ID',
  `nodeid` VARCHAR(50) NOT NULL COMMENT '节点ID',
  `avgwidth` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `sjjdll` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量',
  `peakjdll` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量',
  `jdllper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量百分比',
  `sjepgbf` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点EPG设计并发',
  `peakepgbf` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值并发',
  `epgbfper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值百分比',
  `sjhmsbf` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发',
  `peakhmsbf` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发',
  `hmsbfper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发百分比',
  `sjdbkj` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间',
  `peakdbkj` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间',
  `dbkjper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间百分比',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_thwDayRpt_id` (`id` ASC));

drop table `iptvyw01`.`thwDayRptAreaSum`;
CREATE TABLE `iptvyw01`.`thwDayRptAreaSum` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `upname` VARCHAR(50) NOT NULL DEFAULT '没有对应集群' COMMENT '集群名字',
  `upid` VARCHAR(50) NOT NULL COMMENT '集群ID',
  `avgwidth` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `nodenum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '一个区域中有多少个节点',
  `sjjdllsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量区域汇总',
  `peakjdllsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量区域汇总',
  `jdllsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量区域汇总百分比',
  `sjepgbfsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点EPG设计并发区域汇总',
  `peakepgbfsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值并发区域汇总',
  `epgbfsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点EPG峰值区域汇总百分比',
  `sjhmsbfsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发区域汇总',
  `peakhmsbfsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发区域汇总',
  `hmsbfsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发区域汇总百分比',
  `sjdbkjsum` float UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间区域汇总',
  `peakdbkjsum` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间区域汇总',
  `dbkjsumper` float UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间区域汇总百分比',
  `OPT1` VARCHAR(45) NULL COMMENT '备注1，扩充字段使用',
  `OPT2` VARCHAR(45) NULL COMMENT '备注2，扩充字段使用',
  `OPT3` VARCHAR(45) NULL COMMENT '备注3，扩充字段使用',
  `OPT4` VARCHAR(45) NULL COMMENT '备注4，扩充字段使用',
  `OPT5` VARCHAR(45) NULL COMMENT '备注5，扩充字段使用',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_thwDayRptAreaSum_id` (`id` ASC));


##计算某一段地址中有多少用户
##1. 将NOC总的地址段按C或者B拆分成小地址段存入临时表
##2. 将华为地址段合入NOC表中
##3. 将3A用户和华为地址段进行比对后，计算各段的用户数。
##4. 输出结果表。

  #创建临时表存放分割后的IP地址信息
  DROP TABLE IF EXISTS `iptvyw01`.`tmp_tnoc_split_ippool`;
  CREATE TABLE IF NOT EXISTS `iptvyw01`.`tmp_tnoc_split_ippool` (
    `ipstart` VARCHAR(50) NOT NULL  COMMENT 'NOC IP地址段开始' ,
    `ipend` VARCHAR(50) NOT NULL COMMENT 'NOC IP地址段结束',
    `quju` VARCHAR(50)  NOT NULL COMMENT 'IP地址段对应的区局',
    `usrnum` BIGINT  DEFAULT 0 COMMENT '一段IP中的用户数',
    INDEX idx_tnoc_split_ippool_ipstart (`ipstart`),
    INDEX idx_tnoc_split_ippool_ipsend (`ipend`)
  );
  #

  DROP TABLE IF EXISTS `iptvyw01`.`tmp_t3a_usrs_in_ippool`;
  CREATE TABLE IF NOT EXISTS `iptvyw01`.`tmp_t3a_usrs_in_ippool` (
  `ipaddr` VARCHAR(50) NOT NULL DEFAULT '没有ipaddr' COMMENT '不在NOC地址池中的IP',
  INDEX idx_t3a_usrs_in_ippool_ipaddr (`ipaddr`)
  );

#创建中兴POP点IP地址表
DROP TABLE IF EXISTS tzteiparea;
CREATE TABLE `iptvyw01`.`tzteiparea` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `nodename` VARCHAR(50) NOT NULL COMMENT '中兴POP点名字',
  `nodeid` VARCHAR(50) NOT NULL DEFAULT 0 COMMENT '中兴POP点ID',
  `ipstart` VARCHAR(50) NOT NULL DEFAULT 0 COMMENT 'IP地址段开始',
  `ipend` VARCHAR(50) NOT NULL DEFAULT 0 COMMENT 'IP地址段结束',
  `epgprovider` VARCHAR(50) NOT NULL DEFAULT 1 COMMENT '平台名字',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表未删除，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  INDEX `idx_tzteiparea_id` (`id`)) 
  COMMENT '中兴平台各POP点IP池' ENGINE=InnoDB DEFAULT CHARSET=utf8;
truncate table `iptvyw01`.`tzteiparea`;
load data local infile '/home/caixiaoming/django/tzteiparea.csv' 
replace INTO table tzteiparea 
character set gbk fields 
terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
(`nodename`,`nodeid`,`ipstart`,`ipend`, `epgprovider`);
load data local infile '/home/xknight/django/tzteiparea.csv' 
replace INTO table tzteiparea 
character set gbk fields 
terminated by ',' 
enclosed by '"' 
lines terminated by '\n'
(`nodename`,`nodeid`,`ipstart`,`ipend`, `epgprovider`);

DROP PROCEDURE IF EXISTS `iptvyw01`.`pdrop_create_t3a_usr`;
delimiter //
CREATE PROCEDURE `iptvyw01`.`pdrop_create_t3a_usr`()
BEGIN
DROP TABLE IF EXISTS `iptvyw01`.`t3a_usr`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`t3a_usr` (
  `adslname` VARCHAR(20) NOT NULL  COMMENT '设备编号，用户大AD' ,
  `loginname` VARCHAR(30) NOT NULL COMMENT 'IPTV账号',
  `ipaddr` VARCHAR(50)  COMMENT '用户IP地址',
  `logintime` VARCHAR(20) COMMENT '最后一次登陆时间',
  `status` VARCHAR(5) COMMENT '账号状态',
  `platform` VARCHAR(20) COMMENT '对应到平台',
  `fj_name` VARCHAR(50) COMMENT '分局名字',
  `quju` VARCHAR(50) COMMENT '区局名字',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0'
  );

END; //
delimiter ;
#ALTER TABLE t3a_usr ADD PRIMARY KEY(`loginname`);
CALL iptvyw01.pdrop_create_t3a_usr();
load data local infile '/home/xknight/django/t3a_usr.csv' 
replace INTO table t3a_usr character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n'
ignore 1 lines;
ALTER TABLE `iptvyw01`.`t3a_usr` ADD INDEX idx_t3a_usr_ipaddr(`ipaddr`);
ALTER TABLE `iptvyw01`.`t3a_usr` ADD INDEX idx_t3a_usr_logintime(`logintime`);
ALTER TABLE `iptvyw01`.`t3a_usr` ADD INDEX idx_t3a_usr_platform(`platform`);

DROP INDEX idx_t3a_usr_ipaddr ON `iptvyw01`.`t3a_usr`;
DROP INDEX idx_t3a_usr_logintime ON `iptvyw01`.`t3a_usr`;
DROP INDEX idx_t3a_usr_platform ON `iptvyw01`.`t3a_usr`;

truncate table t3a_usr;
load data local infile '/home/xknight/django/t3a_usr.csv' 
replace INTO table t3a_usr character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n'
ignore 1 lines;
truncate TABLE t3a_usr;
load data local infile '/home/caixiaoming/django/t3a_usr.csv' 
replace INTO table t3a_usr character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n'
ignore 1 lines
(`adslname`, `loginname`, `ipaddr`, `logintime`, `status`, `platform`, 
  `fj_name`, `quju`)
;

DROP TABLE IF EXISTS `iptvyw01`.`tnoc_usr_ippool`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tnoc_usr_ippool` (
  `ipstart` VARCHAR(50) NOT NULL  COMMENT 'ip地址段开始' ,
  `ipend` VARCHAR(50) NOT NULL COMMENT 'ip地址段结束',
  `quju` VARCHAR(50)  NOT NULL COMMENT 'IP地址段对应的区局',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` INT NOT NULL DEFAULT 0 COMMENT '删除标志，0代表正常，1代表删除，默认值0',
  PRIMARY KEY (`ipstart`));
truncate table tnoc_usr_ippool;
load data local infile '/home/xknight/django/tnoc_usr_ippool.csv' 
replace INTO table tnoc_usr_ippool character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n';

truncate table tnoc_usr_ippool;
load data local infile '/home/caixiaoming/django/tnoc_usr_ippool.csv' 
replace INTO table tnoc_usr_ippool character 
set gbk fields terminated by ',' enclosed by '"' lines terminated by '\r\n'
(`ipstart` ,`ipend`, `quju`);


#创建华为平台IP地址段归属POP点信息表
DROP TABLE IF EXISTS `iptvyw01`.`thwiparea`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`thwiparea` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `3aipid` BIGINT unsigned not null COMMENT '业务管理平台策略ID',
  `parentid` VARCHAR(50) DEFAULT '0' COMMENT '父id',
  `broadcast` VARCHAR(50) DEFAULT '1' COMMENT '广播',
  `ipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT 'IP地址段开始',
  `ipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT 'IP地址段结束',
  `mask` VARCHAR(50) COMMENT '子网掩码',
  `status` VARCHAR(50) NOT NULL DEFAULT '0' COMMENT '状态',
  `nodeid` VARCHAR(50) NOT NULL DEFAULT '没有nodeid' COMMENT '华为节点ID',
  `nodename` VARCHAR(50) NOT NULL DEFAULT '没有nodename' COMMENT '华为节点名称',
  `areacode` VARCHAR(50)  COMMENT '区域码',
  `epgprovider` VARCHAR(50) NOT NULL DEFAULT '没有epgprovider' COMMENT '厂商代码',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为Y后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为Y时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_thwiparea_id` (`id` ASC))
  COMMENT '储存华为平台IP地址段归属POP点信息' ENGINE=InnoDB DEFAULT CHARSET=utf8;

truncate table `iptvyw01`.`thwiparea`;
load data local infile '/home/caixiaoming/django/thwiparea.csv' 
replace INTO table thwiparea 
character set gbk fields 
terminated by ',' 
enclosed by '"' 
lines terminated by '\r\n'
ignore 1 lines (`3aipid`,`parentid`,`broadcast`,`ipstart`,`ipend`,
  `mask`,`status`,`nodeid`,`nodename`,`areacode`,`epgprovider`);

truncate table `iptvyw01`.`thwiparea`;
load data local infile '/home/xknight/django/thwiparea.csv' 
replace INTO table thwiparea 
character set gbk fields 
terminated by ',' 
enclosed by '"' 
lines terminated by '\r\n'
ignore 1 lines (`3aipid`,`parentid`,`broadcast`,`ipstart`,`ipend`,
  `mask`,`status`,`nodeid`,`nodename`,`areacode`,`epgprovider`);

DROP TABLE IF EXISTS `iptvyw01`.`tmp_tusrs_in_ip`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tmp_tusrs_in_ip`(
  `usrip` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT '用户IP地址',
  `popipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT '平台IP地址段开始',
  `popipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT '平台IP地址段结束'
  );

CREATE OR REPLACE VIEW `iptvyw01`.`tmp_vusrscount` AS
  SELECT popipstart, popipend, count(popipstart) usrnum
  FROM tmp_tusrs_in_ip
  GROUP BY popipstart, popipend;

DROP TABLE IF EXISTS `iptvyw01`.`tusrsinippoolnum`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tusrsinippoolnum` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `nocipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT 'NOC IP地址段开始',
  `nocipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT 'NOCIP地址段结束',
  `nocquju` VARCHAR(50) NOT NULL DEFAULT '没有nocquju' COMMENT 'NOC IP段所属区局',
  `popipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT '平台IP地址段开始',
  `popipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT '平台IP地址段结束',
  `popid` VARCHAR(50) NOT NULL DEFAULT '没有nodeid' COMMENT 'POP节点唯一ID',
  `popname` VARCHAR(50) NOT NULL DEFAULT '没有nodename' COMMENT 'POP节点名称',
  `usrnum` BIGINT NOT NULL DEFAULT 0 COMMENT '用户数量',
  `platform` VARCHAR(50) NOT NULL DEFAULT '没有platform' COMMENT '所属平台',
  `ipfield` VARCHAR(50) NOT NULL DEFAULT '没有ipfield' COMMENT 'IP地址段落',
  `daylen` VARCHAR(50) NOT NULL DEFAULT '没有daylen' COMMENT '查询间隔',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为Y后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为Y时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_tusrsinippoolnum_id` (`id` ASC))
  COMMENT '储存中兴华为平台IP地址段中的用户数量' ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `iptvyw01`.`tmp_tusrsinippoolnum`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tusrsinippoolnum` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `nocipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT 'NOC IP地址段开始',
  `nocipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT 'NOCIP地址段结束',
  `nocquju` VARCHAR(50) NOT NULL DEFAULT '没有nocquju' COMMENT 'NOC IP段所属区局',
  `popipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT '平台IP地址段开始',
  `popipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT '平台IP地址段结束',
  `popid` VARCHAR(50) NOT NULL DEFAULT '没有nodeid' COMMENT 'POP节点唯一ID',
  `popname` VARCHAR(50) NOT NULL DEFAULT '没有nodename' COMMENT 'POP节点名称',
  `usrnum` BIGINT NOT NULL DEFAULT 0 COMMENT '用户数量',
  `platform` VARCHAR(50) NOT NULL DEFAULT '没有platform' COMMENT '所属平台',
  `ipfield` VARCHAR(50) NOT NULL DEFAULT '没有ipfield' COMMENT 'IP地址段落',
  `daylen` VARCHAR(50) NOT NULL DEFAULT '没有daylen' COMMENT '查询间隔',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为Y后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为Y时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_tusrsinippoolnum_id` (`id` ASC))
  COMMENT '储存中兴华为平台IP地址段中的用户数量' ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `iptvyw01`.`tdic_netmask`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tdic_netmask`(
  `netmaskstr` VARCHAR(20) NULL COMMENT '子网掩码的字符表示，如1B，2B',
  `netmaskpoint`  VARCHAR(20) NULL COMMENT '子网掩码的点分十进制表示',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`netmaskstr`),
  UNIQUE INDEX `idx_tdic_netmask_str` (`netmaskstr` ASC));
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('1B','255.255.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('2B','255.254.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('4B','255.252.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('8B','255.248.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('16B','255.240.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('32B','255.224.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('64B','255.192.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('128B','255.128.0.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('128C','255.255.128.0', NOW(), NOW(), USER(), user());
INSERT INTO `iptvyw01`.`tdic_netmask` (netmaskstr, netmaskpoint, createtime, updatetime, createowner, updateowner)
VALUES('64C','255.255.192.0', NOW(), NOW(), USER(), user());
COMMIT;


#输入IP地址和子网掩码计算出开始IP和结束IP地址。
DROP PROCEDURE IF EXISTS putil_calc_sip_eip;
delimiter //
CREATE PROCEDURE putil_calc_sip_eip(IN clientip VARCHAR(20), IN netmask VARCHAR(20), 
  OUT sip VARCHAR(20), OUT eip VARCHAR(20)
    )
BEGIN
  IF netmask != '' THEN
    SET sip = INET_NTOA(inet_aton(clientip)&inet_aton(netmask));
    SET eip = INET_NTOA(inet_aton(sip) + (pow(2,32) - inet_aton(netmask) - 1));
  #ELSE
    #@TODO:报出一个异常退出。
  #  ;
  END IF;
END //
delimiter ;
CALL putil_calc_sip_eip('12.12.128.148', '255.255.0.0', @sip, @eip);
SELECT @sip, @eip;


DROP PROCEDURE IF EXISTS p3a_calciplen;
delimiter //
CREATE PROCEDURE p3a_calciplen(
  IN iplen VARCHAR(5), OUT olen INT)
BEGIN
  DECLARE clen INT DEFAULT 256;  #定义C段IP长度。
  DECLARE blen INT DEFAULT 65536;  #定义B段IP长度
  DECLARE ipfield VARCHAR(1);
  DECLARE ipnum VARCHAR(4);
  SET ipfield = substring(iplen, -1);
  SET ipnum = left(iplen,locate(substring(iplen,-1),iplen)-1);
  #DECLARE len INT DEFAULT 0;
  IF ipfield = "C" THEN
    SET olen = ipnum * clen;
  ElSEIF ipfield = "B" THEN
    SET olen = ipnum * blen;
  ELSE
    SET olen = 0;
  END IF;
END //
delimiter ;
CALL p3a_calciplen('128C', @len);
SELECT @len;

#将NOC的IP池按规定长度切割后存入表格中
DROP PROCEDURE IF EXISTS pnoc_ip_split;
delimiter //
CREATE PROCEDURE pnoc_ip_split(IN iplen INT)
BEGIN
  DECLARE noc_end INT DEFAULT 0;
  DECLARE noc_ipstart VARCHAR(50);
  DECLARE noc_ipend VARCHAR(50);
  DECLARE noc_quju VARCHAR(50);
  DECLARE ipsplit BIGINT;
  DECLARE a INT DEFAULT 1;
  DECLARE noc_ip_cur CURSOR FOR SELECT ipstart, ipend, quju FROM tnoc_usr_ippool;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET noc_end = 1;
  TRUNCATE TABLE tmp_tnoc_split_ippool;
  OPEN noc_ip_cur;
    FETCH NEXT FROM noc_ip_cur INTO noc_ipstart, noc_ipend, noc_quju;
    WHILE noc_end = 0 DO
      SET ipsplit = CEIL((INET_ATON(noc_ipend) - INET_ATON(noc_ipstart))/iplen); 
      IF ipsplit = 1 THEN
        INSERT INTO tmp_tnoc_split_ippool(ipstart, ipend, quju) 
        VALUES (INET_ATON(noc_ipstart), INET_ATON(noc_ipend), noc_quju);
      ELSEIF ipsplit > 1 THEN
        WHILE a <= ipsplit DO
          IF a = ipsplit THEN
            INSERT INTO tmp_tnoc_split_ippool(ipstart, ipend, quju) 
            VALUES (INET_ATON(noc_ipstart) + (a - 1)*iplen, INET_ATON(noc_ipend), noc_quju);
          ELSEIF a < ipsplit THEN
            #开始IP根据长度进行分拆，在没有到末尾前，从开始IP按长度循环增加。
            INSERT INTO tmp_tnoc_split_ippool(ipstart, ipend, quju) 
            VALUES (INET_ATON(noc_ipstart) + (a - 1)*iplen, INET_ATON(noc_ipstart) + a*iplen - 1, noc_quju);
          END IF;
          SET a = a + 1;
        END WHILE;
        SET a = 1;
      END IF;
      FETCH NEXT FROM noc_ip_cur INTO noc_ipstart, noc_ipend, noc_quju;
    END WHILE;
    COMMIT;
    CLOSE  noc_ip_cur;
END //
delimiter ;
CALL pnoc_ip_split(131072);

#将厂商IP池和NOCIP池合并入临时表
DROP PROCEDURE IF EXISTS `iptvyw01`.`pprovider_ip_split`;
delimiter //
CREATE PROCEDURE pprovider_ip_split(IN strmask VARCHAR(5), IN dayl INT(3), IN intmask INT, IN plat VARCHAR(5))
BEGIN
  DECLARE pro_end INT DEFAULT 0;
  DECLARE provideripstart VARCHAR(50);
  DECLARE provideripend VARCHAR(50);
  DECLARE providernodeid VARCHAR(50);
  DECLARE providerflat VARCHAR(20);
  DECLARE ipsplit BIGINT;
  DECLARE a BIGINT DEFAULT 1;
  DECLARE startip VARCHAR(20);
  DECLARE endip VARCHAR(20);
  DECLARE maskpoint VARCHAR(20);
  DECLARE provider_ip_cur CURSOR FOR 
    SELECT ipstart, ipend, nodeid, epgprovider FROM viparea;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET pro_end = 1;
  DROP TABLE IF EXISTS `iptvyw01`.`tmp_tusr_in_provider_ippool`;
  CREATE TEMPORARY TABLE IF NOT EXISTS `iptvyw01`.`tmp_tusr_in_provider_ippool` (
  `nocipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT 'NOC IP地址段开始',
  `nocipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT 'NOCIP地址段结束',
  `nocquju` VARCHAR(50) NOT NULL DEFAULT '没有noclquju' COMMENT 'NOC IP段所属区局',
  `popipstart` VARCHAR(50) NOT NULL DEFAULT '0.0.0.0' COMMENT '平台IP地址段开始',
  `popipend` VARCHAR(50) NOT NULL DEFAULT '255.255.255.255' COMMENT '平台IP地址段结束',
  `popid` VARCHAR(50) NOT NULL DEFAULT '没有nodeid' COMMENT 'POP节点唯一ID',
  `popname` VARCHAR(50) NOT NULL DEFAULT '没有nodename' COMMENT 'POP节点名称',
  `usrnum` BIGINT NOT NULL DEFAULT 0 COMMENT '用户数量',
  `platform` VARCHAR(50) NOT NULL DEFAULT '没有platform' COMMENT '所属平台',
  `ipfield` VARCHAR(50) NOT NULL DEFAULT '没有ipfield' COMMENT 'IP地址段落',
  `daylen` VARCHAR(50) NOT NULL DEFAULT '没有daylen' COMMENT '查询间隔'
  );

  #TRUNCATE TABLE `iptvyw01`.`tmp_tusr_in_provider_ippool`;
  #根据字符串的子网掩码查出点分十进制子网掩码
  SELECT netmaskpoint INTO maskpoint FROM `iptvyw01`.`tdic_netmask`
  WHERE netmaskstr = strmask;

  #根据不同平台生成view
  DROP VIEW IF EXISTS viparea;
  IF plat = 'HW' THEN
    SET @s = 'CREATE VIEW viparea AS SELECT ipstart, ipend, nodeid, epgprovider FROM thwiparea;';
  ElSEIF plat = 'ZTE' THEN
    SET @s = 'CREATE VIEW viparea AS SELECT ipstart, ipend, nodeid, epgprovider FROM tzteiparea;';
  END IF;
  PREPARE STMT1 FROM @s;
  EXECUTE STMT1;
  DEALLOCATE PREPARE STMT1;

  OPEN provider_ip_cur;
    FETCH NEXT FROM provider_ip_cur INTO provideripstart, provideripend, providernodeid, providerflat;

    WHILE pro_end = 0 DO
      IF provideripstart = provideripend THEN
        SET ipsplit = 1;
      ELSE
        CALL putil_calc_sip_eip(provideripstart, maskpoint, @startip, @endip);
        SET ipsplit = ceil((INET_ATON(provideripend) - INET_ATON(@startip))/intmask);
      END IF;
      IF ipsplit = 1 THEN
        INSERT INTO tmp_tusr_in_provider_ippool(nocipstart, nocipend, nocquju, popipstart, popipend, popid, ipfield, daylen, platform)
        SELECT noc.ipstart, noc.ipend, noc.quju, INET_ATON(provideripstart), INET_ATON(provideripend), 
            providernodeid, strmask, CONCAT(dayl,''), providerflat
          FROM tmp_tnoc_split_ippool noc
          WHERE INET_ATON(provideripstart) >= noc.ipstart
          AND INET_ATON(provideripend) <= noc.ipend;
      ELSEIF ipsplit > 1 THEN
        WHILE a <= ipsplit DO
          IF a = 1 THEN
            INSERT INTO tmp_tusr_in_provider_ippool(nocipstart, nocipend, nocquju, popipstart, popipend, popid, ipfield, daylen, platform)
            SELECT noc.ipstart, noc.ipend, noc.quju, 
              INET_ATON(provideripstart), INET_ATON(@startip) + a*intmask-1, providernodeid,
              strmask, CONCAT(dayl,''), providerflat
            FROM tmp_tnoc_split_ippool noc
            WHERE INET_ATON(provideripstart) >= noc.ipstart
            AND INET_ATON(@endip) <= noc.ipend;
          ELSEIF a = ipsplit THEN
            INSERT INTO tmp_tusr_in_provider_ippool(nocipstart, nocipend, nocquju, popipstart, popipend, popid, ipfield, daylen, platform)
            SELECT noc.ipstart, noc.ipend, noc.quju, 
              INET_ATON(@startip) + (a - 1)*@len, INET_ATON(provideripend), providernodeid, 
              strmask, CONCAT(dayl,''), providerflat
            FROM tmp_tnoc_split_ippool noc
            WHERE (INET_ATON(@startip) + (a - 1)*intmask) >= noc.ipstart
            AND INET_ATON(provideripend) <= noc.ipend;
          ElSEIF a < ipsplit THEN
            INSERT INTO tmp_tusr_in_provider_ippool(nocipstart, nocipend, nocquju, popipstart, popipend, popid, ipfield, daylen, platform)
            SELECT noc.ipstart, noc.ipend, noc.quju, 
              INET_ATON(@startip) + (a - 1)*intmask, INET_ATON(@startip) + a*intmask-1, providernodeid,
              strmask, CONCAT(dayl,''), providerflat
            FROM tmp_tnoc_split_ippool noc
            WHERE (INET_ATON(@startip) + (a - 1)*intmask) >= noc.ipstart
            AND (INET_ATON(@startip) + a*intmask-1) <= noc.ipend;
          END IF;
          SET a = a + 1;
        END WHILE;
        SET a = 1;
      END IF;
      FETCH NEXT FROM provider_ip_cur INTO provideripstart, provideripend, providernodeid, providerflat;
    END WHILE;
    COMMIT;
  CLOSE provider_ip_cur;
END //
delimiter ;

CALL pprovider_ip_split('128C',28, 32768, 'HW');

#将3a中的用户根据IP地址统计对应到所属的POP点IP段中。
DROP PROCEDURE IF EXISTS `iptvyw01`.`p3a_sum_usrs_in_pool`;
delimiter //
CREATE PROCEDURE `iptvyw01`.`p3a_sum_usrs_in_pool`(IN dayl INT(3), IN platform VARCHAR(20))
  BEGIN

    TRUNCATE TABLE `iptvyw01`.`tmp_tusrs_in_ip`;

    INSERT INTO tmp_tusrs_in_ip(usrip, popipstart, popipend)
    SELECT INET_ATON(a.ipaddr), t.popipstart, t.popipend
    FROM t3a_usr a, tmp_tusr_in_provider_ippool t
    WHERE unix_timestamp(a.logintime) > unix_timestamp(date_sub(curdate(), interval dayl day))
    AND  a.platform like CONCAT(platform, '%')
    AND INET_ATON(a.ipaddr) >= t.popipstart
    AND INET_ATON(a.ipaddr) <= t.popipend;
    
  END; //
delimiter ;
CALL p3a_sum_usrs_in_pool(4 , 'HW');


#将几个表中的数据整合入结果表中，结果表中保存了根据时间长度，IP段，平台3种情况的数据。
DROP PROCEDURE IF EXISTS `iptvyw01`.`p3a_usrs_in_ippool`;
delimiter //
CREATE PROCEDURE `iptvyw01`.`p3a_usrs_in_ippool`(IN iplen VARCHAR(5), IN dayl INT(3), IN platform VARCHAR(20))
BEGIN
  
  #根据输入参数，计算分割的IP段长度。根据根据

  DECLARE len INT;
  #declare time1 DATETIME;
  #SET time1 = now();
  CALL p3a_calciplen(iplen, @len);
  #@TODO: @len=0报出异常直接退出。 
  #SELECT CONCAT('calciplen ', TIMESTAMPDIFF(SECOND,time1,now()));
  #根据IP段长度分割NOC的IP段。
  CALL pnoc_ip_split(@len);
  #SELECT CONCAT('pnoc_ip_split ', TIMESTAMPDIFF(SECOND,time1,now()));
  #将华为地址段合入NOC表中
  CALL pprovider_ip_split(iplen, dayl , @len, platform);
  #SELECT CONCAT('pprovider_ip_split ', TIMESTAMPDIFF(SECOND,time1,now()));

  #TRUNCATE TABLE `iptvyw01`.`tmp_t3a_usrs_in_ippool`;
  #SELECT CONCAT('TRUNCATE ', TIMESTAMPDIFF(SECOND,time1,now()));
  #根据用户IP对比各IP地址段，计算出各段IP中的用户人数。
  CALL p3a_sum_usrs_in_pool(dayl , platform);
  #SELECT CONCAT('p3a_sum_usrs_in_pool ', TIMESTAMPDIFF(SECOND,time1,now()));

  #将临时表中的数据导入正式表中
  IF platform = 'HW' THEN
  INSERT INTO tusrsinippoolnum(nocipstart, nocipend, nocquju, popipstart, popipend, popid, popname,
    usrnum, platform, ipfield, daylen, updatetime, createowner, updateowner)
  SELECT INET_NTOA(pro.nocipstart), INET_NTOA(pro.nocipend), pro.nocquju, 
    INET_NTOA(pro.popipstart), INET_NTOA(pro.popipend), pro.popid, sj.jdname, 
    vu.usrnum , pro.platform, pro.ipfield, pro.daylen, now(), user(), user()
  FROM tmp_tusr_in_provider_ippool pro 
  INNER JOIN thwsheji sj ON pro.popid = sj.popid
  LEFT JOIN tmp_vusrscount vu ON pro.popipstart = vu.popipstart
                             AND pro.popipend = vu.popipend;

  ELSEIF platform = 'ZTE' THEN
  INSERT INTO tusrsinippoolnum(nocipstart, nocipend, nocquju, popipstart, popipend, popid, popname,
    usrnum, platform, ipfield, daylen, updatetime, createowner, updateowner)
  SELECT INET_NTOA(pro.nocipstart), INET_NTOA(pro.nocipend), pro.nocquju, 
    INET_NTOA(pro.popipstart), INET_NTOA(pro.popipend), pro.popid, sj.nodename, 
    vu.usrnum , pro.platform, pro.ipfield, pro.daylen, now(), user(), user()
  FROM tmp_tusr_in_provider_ippool pro
  INNER JOIN tztesheji sj ON pro.popid = sj.nodeid
  LEFT JOIN tmp_vusrscount vu ON pro.popipstart = vu.popipstart
                             AND pro.popipend = vu.popipend;
  END IF;
  COMMIT;
  #SELECT CONCAT('INSERT ', TIMESTAMPDIFF(SECOND,time1,now()));
END; //
delimiter ;
TRUNCATE TABLE tusrsinippoolnum;
CALL p3a_usrs_in_ippool('1B', 3, 'HW');#3'45
CALL p3a_usrs_in_ippool('4B', 3, 'HW');#3'24
CALL p3a_usrs_in_ippool('128C', 3, 'HW');#6'24
CALL p3a_usrs_in_ippool('1B', 34, 'HW');#5'31
CALL p3a_usrs_in_ippool('4B', 34, 'HW');#5'2
CALL p3a_usrs_in_ippool('128C', 34, 'HW');#9'42
CALL p3a_usrs_in_ippool('1B', 3, 'ZTE');#2'46
CALL p3a_usrs_in_ippool('4B', 3, 'ZTE');#1'18
CALL p3a_usrs_in_ippool('128C', 3, 'ZTE');#4'36
CALL p3a_usrs_in_ippool('1B', 34, 'ZTE');#3'14
CALL p3a_usrs_in_ippool('4B', 34, 'ZTE');#1'43
CALL p3a_usrs_in_ippool('128C', 34, 'ZTE');#6'2

#通过界面输入的参数返回IP段中的用户数
DROP PROCEDURE IF EXISTS `iptvyw01`.`pusrs_in_ippool_fin`;
delimiter //
CREATE PROCEDURE `iptvyw01`.`pusrs_in_ippool_fin`(
  IN iplen VARCHAR(5), IN daylenth VARCHAR(2), 
  IN plat VARCHAR(20), IN iptxt VARCHAR(50), IN zero VARCHAR(2))
BEGIN
  #DECLARE @sqltext VARCHAR(2000);
  SET @sqltext = 'SELECT nocipstart, nocipend, nocquju, popipstart, popipend, popname, usrnum, platform 
    FROM tusrsinippoolnum ';
  #添加筛选ip段的sql语句
  SET @sqltext = CONCAT(@sqltext, ' WHERE ipfield = \'', iplen, '\'');
  #添加筛选时间长度的sql语句 
  SET @sqltext = CONCAT(@sqltext, ' AND daylen = \'', daylenth, '\'');
  #添加指定ip地址的筛选条件
  IF iptxt != '' THEN
    SET @sqltext = CONCAT(@sqltext, ' AND ', INET_ATON(iptxt) ,' >= INET_ATON(popipstart)');
    SET @sqltext = CONCAT(@sqltext, ' AND ', INET_ATON(iptxt) ,' <= INET_ATON(popipend)');
  END IF;
  #添加指定平台的筛选条件
  IF plat !='' THEN
    SET @sqltext = CONCAT(@sqltext, ' AND platform like \'', plat, '%\'');
  END IF;
  IF zero = 'N' THEN
    SET @sqltext = CONCAT(@sqltext, ' AND usrnum > 0');
  END IF;
  SET @sqltext = CONCAT(@sqltext, ' ORDER BY popname, nocquju, INET_ATON(nocipstart), INET_ATON(popipstart)');
  SET @sqltext = CONCAT(@sqltext, ';');
  #SELECT @sqltext;
  PREPARE STMT FROM @sqltext;
  EXECUTE STMT;
END; //
delimiter ;

CALL pusrs_in_ippool_fin('1B', '31', 'HW','','');

##完成IP段内用户数的计算。


DROP PROCEDURE IF EXISTS phwDayRpt;
delimiter //
create procedure phwDayRpt()
begin
INSERT INTO thwDayRpt (quju, nodename, upid, nodeid, avgwidth, sjjdll, peakjdll, jdllper, sjepgbf, peakepgbf, 
            epgbfper, sjhmsbf, peakhmsbf, hmsbfper, sjdbkj, peakdbkj, dbkjper, 
                        createtime, updatetime, createowner, updateowner
                      )
select t4.quju, t4.jdname as jiedian, t2.upid, t2.popid, round(t3.smaxoutput*1024/t2.tjhmssy,2) as avgwidth,
t4.sjjdll as width, t3.smaxoutput as output, round(t3.smaxoutput/t4.sjjdll*100,0) as outputper, 
t4.sjepgbf as tjepgrl , t2.tjepgsy as tjepgsy, round(t2.tjepgsy/t4.sjepgbf*100,0) as tjepgsyl,
t4.sjbf as tjhmsrl , t2.tjhmssy as tjhmssy, round(t2.tjhmssy/t4.sjbf*100,0) as tjhmssyl, 
round(t2.tjdbkj/1024,2) as tjdbkj, round(t2.tjsykj/1024,2) as tjsykj, round(t2.tjsykj/t2.tjdbkj*100,0) as tjkjsyl
,NOW(), NOW(), USER(), USER()
from thwtongji t1 right join thwtongji t2
on t1.popid = t2.upid and t2.popid != 2 and t2.popid != 62
left join vhwethToday t3
on t2.jiedian = t3.sjiedian
left join thwsheji t4
on t2.jiedian = t4.jiedian
where unix_timestamp(t2.createtime) > unix_timestamp(current_date())
and (unix_timestamp(t1.createtime) > unix_timestamp(current_date()) || 
  t2.popid = '1')
order by t2.upid, t4.jdname;


INSERT INTO thwDayRptAreaSum(upname, upid, avgwidth, nodenum, sjjdllsum, peakjdllsum, jdllsumper, 
                          sjepgbfsum, peakepgbfsum, epgbfsumper, sjhmsbfsum, peakhmsbfsum, hmsbfsumper, 
                              sjdbkjsum, peakdbkjsum, dbkjsumper, createtime, updatetime, createowner, updateowner
                             )
select  t1.jiedian, t2.upid, round(sum(t3.smaxoutput)*1024/sum(t2.tjhmssy),2), count(t2.tjdbkj/1024) as hejinum, round(sum(t4.sjjdll),0) as hejiwidth, 
        round(sum(t3.smaxoutput),0) as hejioutput, round(sum(t3.smaxoutput)/sum(t4.sjjdll)*100,0) as hejioutputper, 
        sum(t4.sjepgbf) as hejiepgrl , sum(t2.tjepgsy) as hejiepgsy, round(sum(t2.tjepgsy)/sum(t4.sjepgbf)*100,0) as hejiepgsyl, 
        sum(t4.sjbf) as hejihmsrl , sum(t2.tjhmssy) as hejihmssy, round(sum(t2.tjhmssy)/sum(t4.sjbf)*100,0) as hejihmssyl, 
        round(sum(t2.tjdbkj/1024),2) as heji, round(sum(t2.tjsykj/1024),2) as kjheji, round(sum(t2.tjsykj)/sum(t2.tjdbkj)*100,0) as kjhejisyl
        ,NOW(), NOW(), USER(), USER()
from thwtongji t1 right join thwtongji t2
on t1.popid = t2.upid and t2.popid != 2 and t2.popid != 62
left join vhwethToday t3
on t2.jiedian = t3.sjiedian
left join thwsheji t4
on t2.jiedian = t4.jiedian
where unix_timestamp(t2.createtime) > unix_timestamp(current_date())
and (unix_timestamp(t1.createtime) > unix_timestamp(current_date()) || 
  t2.popid = '1')
group by t2.upid
order by t2.upid, t4.jdname;
COMMIT;
end //
delimiter ;

CREATE event IF NOT EXISTS ehwDayRpt
  ON SCHEDULE EVERY 1 Day 
  STARTS '2017-4-1 06:55:00'
  ON COMPLETION PRESERVE ENABLE
  DO call phwDayRpt();

select t1.upid, t1.popid, t2.upid, t2.popid, t1.jiedian, t2.jiedian
    from thwtongji t1 join thwtongji t2
    on t1.popid = t2.upid
    where unix_timestamp(t2.createtime) > unix_timestamp(current_date())
    and (unix_timestamp(t1.createtime) > unix_timestamp(current_date()) ||
      t2.popid = '1')
    order by t2.upid;

Alter TABLE thwsheji drop primary key;
ALTER TABLE thwsheji CHANGE podid popid  INT UNSIGNED NOT NULL;
ALTER TABLE thwsheji ADD UNIQUE idx_thwsheji_popid(popid);
ALTER TABLE thwsheji ADD UNIQUE idx_thwsheji_jiedian(jiedian);
ALTER TABLE thwsheji ADD UNIQUE idx_thwsheji_jdname(jdname);

ALTER TABLE thwtongji ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_thwtongji ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE thwethTraffic ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_thwethTraffic ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;

ALTER TABLE tztesheji ADD UNIQUE idx_tztesheji_nodeid(nodeid);
ALTER TABLE tztesheji ADD UNIQUE idx_tztesheji_nodename(nodename);
#ALTER TABLE tztesheji ADD UNIQUE idx_tztesheji_wgname(wgname);
#ALTER TABLE tztesheji ADD UNIQUE idx_tztesheji_epggroupname(epggroupname);
ALTER TABLE tzteepggrpsvr ADD UNIQUE idx_tzteepggrpsvr_epgterminalid(epgterminalid);
ALTER TABLE tzteepggrpsvr ADD UNIQUE idx_tzteepggrpsvr_epgname(epgname);
ALTER TABLE tmp_tztehmsbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tztehmsbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_tztedbkj ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tztedbkj ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_tzteepgbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tzteepgbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;

ALTER TABLE tfhsheji CHANGE nodeid nodeid VARCHAR(50) NOT NULL;
ALTER TABLE tfhsheji ADD UNIQUE idx_tfhsehji_nodeid(nodeid);
ALTER TABLE tfhsheji ADD UNIQUE idx_tfhsehji_nodeCname(nodeCname);
ALTER TABLE tfhsheji ADD UNIQUE idx_tfhsehji_nodeEname(nodeEname);
ALTER TABLE tfhepgsheji ADD UNIQUE idx_tfhepgsehji_epgid(epgip);
ALTER TABLE tfhyewu ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_tfhepgbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tfhepgbf ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tfhdbspace ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;
ALTER TABLE tmp_tfhdbspace ADD id INT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' PRIMARY KEY;

create table tztesheji20170328 as select * from tztesheji;
ALTER TABLE tztesheji ADD quju VARCHAR(50) NOT NULL;
delete from tztesheji where nodename = '高生核心节点';
update tztesheji set nodename = '核心节点' where nodename = '中心临时节点';
update tztesheji set quju = left(nodename, 2);
COMMIT;


select * from tzteDayRptAreaSum;

select  t4.quju, t2.upid, round(sum(t3.smaxoutput)*1024/sum(t2.tjhmssy),2), count(t2.tjdbkj/1024) as hejinum, round(sum(t4.sjjdll),0) as hejiwidth, 
        round(sum(t3.smaxoutput),0) as hejioutput, round(sum(t3.smaxoutput)/sum(t4.sjjdll)*100,0) as hejioutputper, 
        sum(t4.sjepgbf) as hejiepgrl , sum(t2.tjepgsy) as hejiepgsy, round(sum(t2.tjepgsy)/sum(t4.sjepgbf)*100,0) as hejiepgsyl, 
        sum(t4.sjbf) as hejihmsrl , sum(t2.tjhmssy) as hejihmssy, round(sum(t2.tjhmssy)/sum(t4.sjbf)*100,0) as hejihmssyl, 
        round(sum(t2.tjdbkj/1024),2) as heji, round(sum(t2.tjsykj/1024),2) as kjheji, round(sum(t2.tjsykj)/sum(t2.tjdbkj)*100,0) as kjhejisyl
        ,NOW(), NOW(), USER(), USER()
from thwtongji t1 right join thwtongji t2
on t1.popid = t2.upid and t2.popid != 2 and t2.popid != 62
left join vhwethToday t3
on t2.jiedian = t3.sjiedian
left join thwsheji t4
on t2.jiedian = t4.jiedian 
where (unix_timestamp(t2.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) and unix_timestamp(t2.createtime) < date_add(curdate(), interval - day(curdate()) + 1 day))
and (unix_timestamp(t1.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) 
     and unix_timestamp(t1.createtime) < date_add(curdate(), interval - day(curdate()) + 1 day) || 
  t2.popid = '1')
group by t4.quju, date_format(t2.createtime, '%Y-%m-%d')
order by t4.quju, date_format(t2.createtime, '%Y-%m-%d');
##完成烽火平台日报统计

##中兴平台统计
##1.得出各个区局的设计流量。
##2.得出1个月各个区局的峰值流量。
##3.合并成总体的表格。
CREATE OR REPLACE VIEW vztequjusheji AS
  select quju, round(sum(sjjdll)/1024,0) qujusjjdll, sum(sjepgbf) qujusjepgbf, sum(sjhmsbf) qujusjhmsbf, 
         round(sum(sjdbkj)/1024/1024,0) qujusjdbkj from tztesheji
  where nodeid not in('unit11050821053447','unit09021821012954','node12101515273172','unit09032311541565',
                     'unit11040715055389','unit10040119365361','unit11060619232513','unit11082516064825',
                     'node12101214102273','unit11040715360471','unit10080421002640','node13062320551431')
  group by quju
  order by substring_index('核心,浦东,东区,北区,西区,莘闵,南汇,嘉定,崇明,青浦,松江,奉贤,金山,',quju,1);

  ##将区域节点的设计能力计算在内
  CREATE OR REPLACE VIEW vztequjusheji AS
    SELECT quju, round(sum(sjjdll)/1024,0) qujusjjdll, sum(sjepgbf) qujusjepgbf, sum(sjhmsbf) qujusjhmsbf, 
         round(sum(sjdbkj)/1024/1024,0) qujusjdbkj 
    FROM tztesheji
    GROUP BY quju
    ORDER BY substring_index('核心,浦东,东区,北区,西区,莘闵,南汇,嘉定,崇明,青浦,松江,奉贤,金山,',quju,1);

CREATE OR REPLACE VIEW vztequjuMonthsum AS
  SELECT sj.quju quju, dr.createtime createtime, SUM(dr.peakjdll) jdllsum, SUM(dr.peakepgbf) epgbfsum, 
        SUM(dr.peakhmsbf) hmsbfsum, SUM(peakdbkj) dbkjsum
  FROM tztesheji sj, tzteDayRpt dr
  WHERE sj.nodeid = dr.nodeid
  AND unix_timestamp(dr.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) 
  AND unix_timestamp(dr.createtime) < unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
  GROUP BY sj.quju, dr.createtime
;

CREATE OR REPLACE VIEW vztequjuMonthmax AS
  SELECT quju, ROUND(MAX(jdllsum),0) djllmax, MAX(epgbfsum) epgbfmax, MAX(hmsbfsum) hmsbfmax, MAX(dbkjsum) dbkjmax
  FROM vztequjuMonthsum 
  GROUP BY quju
;
#生成月报存储过程
DROP PROCEDURE IF EXISTS pzteMonRpt;
delimiter //
CREATE PROCEDURE pzteMonRpt()
BEGIN
INSERT INTO tzteMonRpt(quju, avgwidth, qujusjjdll, jdllmax, jdllper, 
       qujusjepgbf, epgbfmax, epgbfper, qujusjhmsbf, hmsbfmax, hmsbfper,
       qujusjdbkj, dbkjmax, dbkjper, updatetime, createowner, updateowner)
SELECT sj.quju '区局', ROUND(qj.djllmax*1024/qj.hmsbfmax, 2) '平均码流(Mbps)', 
       sj.qujusjjdll '设计流量(Gbps)', qj.djllmax '最大流量(Gbps)', ROUND(qj.djllmax/sj.qujusjjdll*100,0) '流量(%)',
       sj.qujusjepgbf 'EPG设计并发', qj.epgbfmax 'EPG实际最大并发', ROUND(qj.epgbfmax/sj.qujusjepgbf*100, 0) 'EPG(%)',
       sj.qujusjhmsbf '流媒体设计并发', qj.hmsbfmax '流媒体实际最大并发', ROUND(qj.hmsbfmax/sj.qujusjhmsbf*100, 0) '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', sj.qujusjdbkj-qj.dbkjmax '实际最大点播存储空间(T)', ROUND((sj.qujusjdbkj-qj.dbkjmax)/sj.qujusjdbkj*100, 0) '存储空间(%)',
       NOW(), USER(), USER()
FROM vztequjusheji sj, vztequjuMonthmax qj
WHERE sj.quju = qj.quju
;
COMMIT;
END //
delimiter ;

#生成月报定时任务事件
DROP EVENT IF EXISTS ezteMonRpt;
CREATE EVENT IF NOT EXISTS ezteMonRpt
  ON SCHEDULE EVERY 1 MONTH 
  STARTS '2017-5-2 07:02:00'
  ON COMPLETION PRESERVE ENABLE
  DO call pzteMonRpt();

#生成中兴当月月报数据
SELECT sj.quju '区局', sj.avgwidth '平均码流(Mbps)', 
       sj.qujusjjdll '设计流量(Gbps)', sj.jdllmax '最大流量(Gbps)', sj.jdllper '流量(%)',
       sj.qujusjepgbf 'EPG设计并发', sj.epgbfmax 'EPG实际最大并发', sj.epgbfper 'EPG(%)',
       sj.qujusjhmsbf '流媒体设计并发', sj.hmsbfmax '流媒体实际最大并发', sj.hmsbfper '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', sj.dbkjmax '实际最大点播存储空间(T)', sj.dbkjper '存储空间(%)',
       DATE_FORMAT(sj.createtime, '%Y%m') '月份'
FROM tzteMonRpt sj
WHERE unix_timestamp(sj.createtime) > unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
;
#完成中兴平台月报统计。

##华为平台月度统计
##1.得出各个区局的设计流量。
##2.得出1个月各个区局的峰值流量。
##3.合并成总体的表格。
update thwsheji set quju = '核心' where popid = 1;
COMMIT;

CREATE OR REPLACE VIEW vhwqujusheji AS
SELECT quju, round(sum(sjjdll),0) qujusjjdll, sum(sjepgbf) qujusjepgbf, sum(sjbf) qujusjhmsbf, round(sum(sjdbkj),0) qujusjdbkj 
FROM thwsheji
WHERE popid not in(2,3,4,19,23,35,37,39,40,49,62)
GROUP BY quju
ORDER BY substring_index('核心,浦东,南区,中区,西区,宝山,莘闵,嘉定,崇明,青浦,松江,奉贤,金山',quju,1); 

##将区域节点能力计算在设计能力内
CREATE OR REPLACE VIEW vhwqujusheji AS
SELECT quju, round(sum(sjjdll),0) qujusjjdll, sum(sjepgbf) qujusjepgbf, sum(sjbf) qujusjhmsbf, round(sum(sjdbkj),0) qujusjdbkj 
FROM thwsheji
WHERE popid not in(2,62)
GROUP BY quju
ORDER BY substring_index('核心,浦东,南区,中区,西区,宝山,莘闵,嘉定,崇明,青浦,松江,奉贤,金山',quju,1); 

CREATE OR REPLACE VIEW vhwqujuMonthsum AS
SELECT sj.quju, dr.createtime, SUM(dr.peakjdll) djllsum, SUM(dr.peakepgbf) epgbfsum, 
       SUM(dr.peakhmsbf) hmsbfsum, SUM(dr.peakdbkj) dbkjsum
FROM thwsheji sj, thwDayRpt dr
WHERE sj.popid = dr.nodeid
AND unix_timestamp(dr.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) 
AND unix_timestamp(dr.createtime) < unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
GROUP BY dr.quju, dr.createtime
;

CREATE OR REPLACE VIEW vhwqujuMonthmax AS
SELECT quju, ROUND(MAX(djllsum), 0) djllmax, MAX(epgbfsum) epgbfmax, MAX(hmsbfsum) hmsbfmax, MAX(dbkjsum) dbkjmax 
FROM vhwqujuMonthsum 
GROUP BY quju
;

#生成华为月报存储过程
DROP PROCEDURE IF EXISTS phwMonRpt;
delimiter //
CREATE PROCEDURE phwMonRpt()
BEGIN
INSERT INTO thwMonRpt(quju, avgwidth, qujusjjdll, jdllmax, jdllper, 
       qujusjepgbf, epgbfmax, epgbfper, qujusjhmsbf, hmsbfmax, hmsbfper,
       qujusjdbkj, dbkjmax, dbkjper, updatetime, createowner, updateowner)
SELECT sj.quju '区局', ROUND(qj.djllmax*1024/qj.hmsbfmax, 2) '平均码流(Mbps)', 
       sj.qujusjjdll '设计流量(Gbps)', qj.djllmax '最大流量(Gbps)', ROUND(qj.djllmax/sj.qujusjjdll*100,0) '流量(%)',
       sj.qujusjepgbf 'EPG设计并发', qj.epgbfmax 'EPG实际最大并发', ROUND(qj.epgbfmax/sj.qujusjepgbf*100, 0) 'EPG(%)',
       sj.qujusjhmsbf '流媒体设计并发', qj.hmsbfmax '流媒体实际最大并发', ROUND(qj.hmsbfmax/sj.qujusjhmsbf*100, 0) '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', qj.dbkjmax '实际最大点播存储空间(T)', ROUND(qj.dbkjmax/sj.qujusjdbkj*100, 0) '存储空间(%)',
       NOW(), USER(), USER()
FROM vhwqujusheji sj, vhwqujuMonthmax qj
WHERE sj.quju = qj.quju
;
COMMIT;
END //
delimiter ;

#生成月报定时任务事件
DROP EVENT IF EXISTS ehwMonRpt;
CREATE EVENT IF NOT EXISTS ehwMonRpt
  ON SCHEDULE EVERY 1 MONTH 
  STARTS '2017-5-2 07:05:00'
  ON COMPLETION PRESERVE ENABLE
  DO call phwMonRpt();

#生成华为当月月报数据
SELECT sj.quju '区局', sj.avgwidth '平均码流(Mbps)', 
       sj.qujusjjdll '设计流量(Gbps)', sj.jdllmax '最大流量(Gbps)', sj.jdllper '流量(%)',
       sj.qujusjepgbf 'EPG设计并发', sj.epgbfmax 'EPG实际最大并发', sj.epgbfper 'EPG(%)',
       sj.qujusjhmsbf '流媒体设计并发', sj.hmsbfmax '流媒体实际最大并发', sj.hmsbfper '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', sj.dbkjmax '实际最大点播存储空间(T)', sj.dbkjper '存储空间(%)',
       DATE_FORMAT(sj.createtime, '%Y%m') '月份'
FROM thwMonRpt sj
WHERE unix_timestamp(sj.createtime) > unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
;
#完成华为平台月度统计。

#烽火平台月度统计
##1.得出各个区局的设计流量。
##2.得出1个月各个区局的峰值流量。
##3.合并成总体的表格。
ALTER TABLE tfhsheji ADD quju VARCHAR(50) NOT NULL COMMENT 'POP点对应的区局' AFTER nodearea;
UPDATE tfhsheji SET quju = '南汇' WHERE nodeCname like ('南汇%');
UPDATE tfhsheji SET quju = '浦东' WHERE nodeCname like ('高东%');
UPDATE tfhsheji SET quju = '核心' WHERE nodeCname like ('高生%');
COMMIT;

#计算各区局的设计流量
CREATE OR REPLACE VIEW vfhqujusheji AS
SELECT quju, round(sum(sjjdll),0) qujusjjdll, sum(sjjdbf) qujusjhmsbf, round(sum(sjdbkj),0) qujusjdbkj 
FROM tfhsheji
WHERE nodeid  != '23120600'
GROUP BY quju
ORDER BY substring_index('浦东,南汇',quju,1); 


drop table IF EXISTS `iptvyw01`.`tfhDayRpt`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tfhDayRpt` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `quju` VARCHAR(50) NOT NULL COMMENT '区局名字',
  `nodeCname` VARCHAR(50) NOT NULL COMMENT '节点名字',
  `nodeid` VARCHAR(50) NOT NULL default '没有匹配' COMMENT '节点ID',
  `avgwidth` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `sjjdll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量',
  `peakjdll` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量',
  `jdllper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量百分比',
  `sjjdbf` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发',
  `peakjdbf` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发',
  `jdbfper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发百分比',
  `sjdbkj` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间',
  `peakdbkj` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间',
  `dbkjper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间百分比',
  `mangguoll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '芒果流量',
  `mangguoper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '芒果/总流量占比',
  `4Kll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '4K流量',
  `4Kper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '4K/总流量占比',
  `youkull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '优酷土豆流量',
  `youkuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '优酷土豆/总流量占比',
  `bestvll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '芒果流量',
  `bestvoper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '芒果/总流量占比',
  `cesull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '测速流量',
  `cesuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '测速/总流量占比',
  `boboll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '播播流量',
  `boboper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '播播/总流量占比',
  `tianyill` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '天翼视讯流量',
  `tianyiper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '天翼视讯/总流量占比',
  `jiaoyull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '教育流量',
  `jiaoyuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '教育/总流量占比',
  `huasull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '华数流量',
  `huasuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '华数/总流量占比',
  `jiayoull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '嘉攸流量',
  `jiayouper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '嘉攸/总流量占比',
  `jylivell` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '嘉攸直播流量',
  `jyliveper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '嘉攸直播/总流量占比',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_tfhDayRpt_id` (`id` ASC));

#烽火tfhDayRpt添加一列nodeid
ALTER TABLE `iptvyw01`.`tfhDayRpt` 
ADD nodeid VARCHAR(50) NOT NULL DEFAULT '没有匹配' 
COMMENT '节点ID' AFTER nodeCname;
UPDATE `iptvyw01`.`tfhDayRpt` dr INNER JOIN `iptvyw01`.`tfhsheji` sj 
ON  sj.nodeCname = dr.nodeCname
SET dr.nodeid = sj.nodeid;


DROP PROCEDURE IF EXISTS pfhDayRpt;
delimiter //
create procedure pfhDayRpt()
BEGIN
INSERT INTO tfhDayRpt (quju, nodeCname, nodeid, avgwidth, sjjdll, peakjdll, jdllper, 
  sjjdbf,peakjdbf,jdbfper,sjdbkj,peakdbkj,dbkjper,
  mangguoll,mangguoper,4Kll,4Kper,youkull,youkuper,stbdown, stbdownper,bestvll,bestvoper,cesull,cesuper,
  boboll,boboper,tianyill,tianyiper,jiaoyull,jiaoyuper,huasull,huasuper,
  jiayoull,jiayouper,jylivell,jyliveper,updatetime, createowner, updateowner
                      )
SELECT sj.quju, sj.nodeCname, sj.nodeid, 
        ROUND(SUM(hms.maxoutput)/SUM(hms.maxhmsbf),0) avgwidth, sj.sjjdll, 
        ROUND(SUM(hms.maxoutput),0) maxoutput, 
        ROUND(SUM(hms.maxoutput)/sj.sjjdll*100,0) outputper,
        sj.sjjdbf, SUM(hms.maxhmsbf) hmsbf, ROUND(SUM(hms.maxhmsbf)/sj.sjjdbf*100, 0) bfper,
        sj.sjdbkj, ROUND(db.usedspace/1024/1024, 0) useddb, 
        ROUND(db.usedspace/1024/1024/sjdbkj*100, 0) dbper,
        sum(if (hms.cpname = '芒果tv', round(hms.maxoutput, 0), 0)) as mangguo,
        ROUND(sum(if (hms.cpname = '芒果tv', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS mangguoPer,
        sum(if (hms.cpname = '4K' , round(hms.maxoutput, 0) , 0)) 4K, 
        ROUND(sum(if (hms.cpname = '4K', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS 4KPer,
        sum(if (hms.cpname = '优酷土豆', round(hms.maxoutput, 0), 0)) youku,
        ROUND(sum(if (hms.cpname = '优酷土豆', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS youkuPer,
        sum(if (hms.cpname = '机顶盒升级包', round(hms.maxoutput, 0), 0)) stbdown,
        ROUND(sum(if (hms.cpname = '机顶盒升级包', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS stbdownPer,
        sum(if (hms.cpname = '百事通回源', round(hms.maxoutput, 0), 0)) bestvsrc,
        ROUND(sum(if (hms.cpname = '百事通回源', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS bestvsrcPer,
        sum(if (hms.cpname = '测速', round(hms.maxoutput, 0), 0)) cesu,
        ROUND(sum(if (hms.cpname = '测速', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS cesuPer,
        sum(if (hms.cpname = 'bobo', round(hms.maxoutput, 0), 0)) bobo,
        ROUND(sum(if (hms.cpname = 'bobo', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS boboPer,
        sum(if (hms.cpname = '天翼视讯', round(hms.maxoutput, 0), 0)) tianyi,
        ROUND(sum(if (hms.cpname = '天翼视讯', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS tianyiPer,
        sum(if (hms.cpname = '教育中心', round(hms.maxoutput, 0), 0)) jiayu,
        ROUND(sum(if (hms.cpname = '教育中心', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jiaoyuPer,
        sum(if (hms.cpname = '华数', round(hms.maxoutput, 0), 0)) huasu,
        ROUND(sum(if (hms.cpname = '华数', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS huasuPer,
        sum(if (hms.cpname = '嘉攸', round(hms.maxoutput, 0), 0)) jiayou,
        ROUND(sum(if (hms.cpname = '嘉攸', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jiayouPer,
        sum(if (hms.cpname = '嘉攸直播', round(hms.maxoutput, 0), 0)) jylive,
        ROUND(sum(if (hms.cpname = '嘉攸直播', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jylivePer,
        NOW(), USER(), USER()
 FROM tfhsheji sj 
 LEFT JOIN tfhhmsbf hms
 ON sj.nodeEname = hms.nodeEname
 LEFT JOIN tfhdbspace db
 ON sj.nodeEname = db.nodeEname
 WHERE sj.nodeCname <> '高生节点'
 AND    (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)
 AND    (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)
 GROUP BY sj.nodeCname
 ORDER BY substring_index('烽火汇总',sj.nodeCname,1), sj.nodeCname;
COMMIT;
END //
delimiter ;

DROP event IF EXISTS efhDayRpt;
CREATE event IF NOT EXISTS efhDayRpt
  ON SCHEDULE EVERY 1 Day 
  STARTS '2017-4-23 06:57:00'
  ON COMPLETION PRESERVE ENABLE
  DO call pfhDayRpt();

#计算烽火平台前1个月的最大流量
#日期范围>前1个月的1号，<本月的1号
CREATE OR REPLACE VIEW vfhqujuMonthsum AS
SELECT sj.quju, dr.createtime, SUM(dr.peakjdll) djllsum, SUM(dr.peakjdbf) hmsbfsum, 
        SUM(dr.peakdbkj) dbkjsum, SUM(mangguoll) mangguollsum ,SUM(4Kll) 4Kllsum,
        SUM(youkull) youkullsum, SUM(stbdown) stbdownllsum, SUM(bestvll) bestvllsum, SUM(cesull) cesullsum,
        SUM(boboll) bobollsum, SUM(tianyill) tianyillsum, SUM(jiaoyull) jiaoyullsum,
        SUM(huasull) huasullsum, SUM(jiayoull) jiayoullsum, SUM(jylivell) jylivellsum
FROM tfhsheji sj, tfhDayRpt dr
WHERE sj.nodeid = dr.nodeid
AND unix_timestamp(dr.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) 
AND unix_timestamp(dr.createtime) < unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
GROUP BY dr.quju, DATE_FORMAT(dr.createtime, '%Y%m%d')
;

#根据烽火日报按天汇总每个区的实际流量
CREATE OR REPLACE VIEW vfhqujuMonthSum AS
SELECT sj.quju, dr.createtime, SUM(dr.peakjdll) djllsum, 
       SUM(dr.peakjdbf) hmsbfsum, SUM(dr.peakdbkj) dbkjsum
FROM tfhsheji sj, tfhDayRpt dr
WHERE sj.nodeid = dr.nodeid
#AND unix_timestamp(dr.createtime) > unix_timestamp(date_add(curdate() - day(curdate()) + 1, interval -1 month)) 
#AND unix_timestamp(dr.createtime) < unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
GROUP BY DATE_FORMAT(dr.createtime, '%Y%m%d'), dr.quju
;


CREATE OR REPLACE VIEW vfhqujuMonthmax AS
SELECT quju, ROUND(MAX(djllsum), 0) djllmax, MAX(hmsbfsum) hmsbfmax, MAX(dbkjsum) dbkjmax,
        MAX(mangguollsum) mangguollmax, MAX(4Kllsum) 4Kllmax, MAX(youkullsum) youkullmax,
        MAX(stbdownllsum) stbdownllmax, MAX(bestvllsum) bestvllmax, MAX(cesullsum) cesullmax, MAX(bobollsum) bobollmax,
        MAX(tianyillsum) tianyillmax, MAX(jiaoyullsum) jiaoyullmax, MAX(huasullsum) huasullmax,
        MAX(jiayoullsum) jiayoullmax, MAX(jylivellsum) jylivellmax
FROM vfhqujuMonthsum 
GROUP BY quju
;

#生成烽火平台月报存储过程
DROP PROCEDURE IF EXISTS pfhMonRpt;
delimiter //
CREATE PROCEDURE pfhMonRpt()
BEGIN
INSERT INTO tfhMonRpt(quju, avgwidth, qujusjjdll, jdllmax, jdllper, 
        qujusjhmsbf, hmsbfmax, hmsbfper, qujusjdbkj, dbkjmax, dbkjper,
        mangguoll, mangguoper, 4Kll, 4Kper, youkull, youkuper,stbdown, stbdownper, bestvll, bestvoper, 
        cesull, cesuper, boboll, boboper, tianyill, tianyiper, jiaoyull, jiaoyuper, 
        huasull, huasuper, jiayoull, jiayouper, jylivell, jyliveper,
        updatetime, createowner, updateowner)
SELECT sj.quju '区局', ROUND(qj.djllmax/qj.hmsbfmax, 2) '平均码流(Mbps)', 
       ROUND(sj.qujusjjdll/1024,0) '设计流量(Gbps)', ROUND(qj.djllmax/1024, 0) '最大流量(Gbps)', 
       ROUND(qj.djllmax/sj.qujusjjdll*100,0) '流量(%)',
       sj.qujusjhmsbf '流媒体设计并发', qj.hmsbfmax '流媒体实际最大并发', 
       ROUND(qj.hmsbfmax/sj.qujusjhmsbf*100, 0) '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', qj.dbkjmax '实际最大点播存储空间(T)', 
       ROUND(qj.dbkjmax/sj.qujusjdbkj*100, 0) '存储空间(%)',
       ROUND(qj.mangguollmax/1024,0) '芒果流量(Gbps)', ROUND(qj.mangguollmax/sj.qujusjjdll*100,0) '芒果流量(%)',
       ROUND(qj.4Kllmax/1024,0) '4K流量(Gbps)', ROUND(qj.4Kllmax/sj.qujusjjdll*100,0) '4K流量(%)',
       ROUND(qj.youkullmax/1024,0) '优酷土豆流量(Gbps)', ROUND(qj.youkullmax/sj.qujusjjdll*100,0) '优酷土豆流量(%)',
       ROUND(qj.stbdownllmax/1024,0) '机顶盒下载流量(Gbps)', ROUND(qj.stbdownllmax/sj.qujusjjdll*100,0) '机顶盒下载流量(%)',
       ROUND(qj.bestvllmax/1024,0) '百视通流量(Gbps)', ROUND(qj.bestvllmax/sj.qujusjjdll*100,0) '百视通流量(%)',
       ROUND(qj.cesullmax/1024,0) '测速流量(Gbps)', ROUND(qj.cesullmax/sj.qujusjjdll*100,0) '测速流量(%)',
       ROUND(qj.bobollmax/1024,0) '播播流量(Gbps)', ROUND(qj.bobollmax/sj.qujusjjdll*100,0) '播播流量(%)',
       ROUND(qj.tianyillmax/1024,0) '天翼流量(Gbps)', ROUND(qj.tianyillmax/sj.qujusjjdll*100,0) '天翼流量(%)',
       ROUND(qj.jiaoyullmax/1024,0) '教育中心流量(Gbps)', ROUND(qj.jiaoyullmax/sj.qujusjjdll*100,0) '教育中心流量(%)',
       ROUND(qj.huasullmax/1024,0) '华数流量(Gbps)', ROUND(qj.huasullmax/sj.qujusjjdll*100,0) '华数流量(%)',
       ROUND(qj.jiayoullmax/1024,0) '嘉攸流量(Gbps)', ROUND(qj.jiayoullmax/sj.qujusjjdll*100,0) '嘉攸流量(%)',
       ROUND(qj.jylivellmax/1024,0) '嘉攸直播流量(Gbps)', ROUND(qj.jylivellmax/sj.qujusjjdll*100,0) '嘉攸直播流量(%)',
       NOW(), USER(), USER()
FROM vfhqujusheji sj, vfhqujuMonthmax qj
WHERE sj.quju = qj.quju
;
COMMIT;
END //
delimiter ;

#生成烽火月报定时任务事件
DROP EVENT IF EXISTS efhMonRpt;
CREATE EVENT IF NOT EXISTS efhMonRpt
  ON SCHEDULE EVERY 1 MONTH 
  STARTS '2017-5-2 07:10:00'
  ON COMPLETION PRESERVE ENABLE
  DO call pfhMonRpt();

#生成烽为前一月月报数据
SELECT sj.quju '区局', sj.avgwidth '平均码流(Mbps)', 
       sj.qujusjjdll '设计流量(Gbps)', sj.jdllmax '最大流量(Gbps)', sj.jdllper '流量(%)',
       sj.qujusjhmsbf '流媒体设计并发', sj.hmsbfmax '流媒体实际最大并发', sj.hmsbfper '流媒体(%)',
       sj.qujusjdbkj '设计点播存储空间(T)', sj.dbkjmax '实际最大点播存储空间(T)', sj.dbkjper '存储空间(%)',
       sj.mangguoll '芒果流量(Gbps)', sj.mangguoper '芒果流量(%)', sj.4Kll '4K流量(Gbps)', sj.4Kper '4K流量(%)', 
       sj.youkull '优酷土豆流量(Gbps)', sj.youkuper '优酷土豆流量(%)', sj.bestvll '百视通流量(Gbps)', sj.bestvoper '百视通流量(%)', 
       sj.cesull '测速流量(Gbps)', sj.cesuper '测速流量(%)', sj.boboll '播播流量(Gbps)', sj.boboper '播播流量(%)', 
       sj.tianyill '天翼流量(Gbps)', sj.tianyiper '天翼流量(%)', sj.jiaoyull '教育中心流量(Gbps)', sj.jiaoyuper '教育中心流量(%)', 
       sj.huasull '华数流量(Gbps)', sj.huasuper '华数流量(%)', sj.jiayoull '嘉攸流量(Gbps)', sj.jiayouper '嘉攸流量(%)', 
       sj.jylivell '嘉攸直播流量(Gbps)', sj.jyliveper '嘉攸直播流量(%)',
       DATE_FORMAT(sj.createtime, '%Y%m') '月份'
FROM tfhMonRpt sj
WHERE unix_timestamp(sj.createtime) > unix_timestamp(date_add(curdate(), interval - day(curdate()) + 1 day))
;


#创建中兴月报表
DROP TABLE IF EXISTS tzteMonRpt;
CREATE TABLE `iptvyw01`.`tzteMonRpt` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `quju` VARCHAR(50) NOT NULL COMMENT '区局名字',
  `avgwidth` FLOAT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)，精确到小数点后2位',
  `qujusjjdll` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计设计节点流量，含区域节点值(Gbps)',
  `jdllmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点流量最大值(Bbps)',
  `jdllper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjepgbf` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计EPG并发，含区域节点值',
  `epgbfmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点EPG并发最大值',
  `epgbfper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjhmsbf` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计流媒体并发，含区域节点值',
  `hmsbfmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点流媒体并发最大值',
  `hmsbfper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjdbkj` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计存储空间，含区域节点值(TB)',
  `dbkjmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点存储空间最大值(TB)',
  `dbkjper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表未删除，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_tzteMonRpt_id` (`id` ASC)) 
  COMMENT '统计一个月中兴平台最大值' ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建华为月报表
DROP TABLE IF EXISTS thwMonRpt;
CREATE TABLE `iptvyw01`.`thwMonRpt` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `quju` VARCHAR(50) NOT NULL COMMENT '区局名字',
  `avgwidth` FLOAT UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)，精确到小数点后2位',
  `qujusjjdll` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计设计节点流量，含区域节点值(Gbps)',
  `jdllmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点流量最大值(Bbps)',
  `jdllper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjepgbf` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计EPG并发，含区域节点值',
  `epgbfmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点EPG并发最大值',
  `epgbfper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjhmsbf` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计流媒体并发，含区域节点值',
  `hmsbfmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点流媒体并发最大值',
  `hmsbfper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `qujusjdbkj` BIGINT UNSIGNED NOT NULL DEFAULT 1 COMMENT '按区局统计节点设计存储空间，含区域节点值(TB)',
  `dbkjmax` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '按区局统计1个月实际节点存储空间最大值(TB)',
  `dbkjper` BIGINT UNSIGNED NOT NULL DEFAULT 0 COMMENT '实际流量/设计流量',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表未删除，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_thwMonRpt_id` (`id` ASC)) 
  COMMENT '统计一个月华为平台最大值' ENGINE=InnoDB DEFAULT CHARSET=utf8;

#创建烽火月报表
drop table IF EXISTS `iptvyw01`.`tfhMonRpt`;
CREATE TABLE IF NOT EXISTS `iptvyw01`.`tfhMonRpt` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '自增长ID' ,
  `quju` VARCHAR(50) NOT NULL COMMENT '区局名字',
  `avgwidth` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '平均码流(Mbps)',
  `qujusjjdll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '设计节点流量',
  `jdllmax` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量',
  `jdllper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点峰值流量百分比',
  `qujusjhmsbf` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点流媒体设计并发',
  `hmsbfmax` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发',
  `hmsbfper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点流媒体峰值并发百分比',
  `qujusjdbkj` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '节点存储设计空间',
  `dbkjmax` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间',
  `dbkjper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '节点存储峰值空间百分比',
  `mangguoll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '芒果流量',
  `mangguoper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '芒果/总流量占比',
  `4Kll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '4K流量',
  `4Kper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '4K/总流量占比',
  `youkull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '优酷土豆流量',
  `youkuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '优酷土豆/总流量占比',
  `stbdown` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '机顶盒下载流量',
  `stbdownper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '机顶盒下载/总流量' ,
  `bestvll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '芒果流量',
  `bestvoper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '芒果/总流量占比',
  `cesull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '测速流量',
  `cesuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '测速/总流量占比',
  `boboll` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '播播流量',
  `boboper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '播播/总流量占比',
  `tianyill` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '天翼视讯流量',
  `tianyiper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '天翼视讯/总流量占比',
  `jiaoyull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '教育流量',
  `jiaoyuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '教育/总流量占比',
  `huasull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '华数流量',
  `huasuper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '华数/总流量占比',
  `jiayoull` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '嘉攸流量',
  `jiayouper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '嘉攸/总流量占比',
  `jylivell` double UNSIGNED NOT NULL DEFAULT 1 COMMENT '嘉攸直播流量',
  `jyliveper` double UNSIGNED NOT NULL DEFAULT 0 COMMENT '嘉攸直播/总流量占比',
  `createtime` TIMESTAMP NOT NULL DEFAULT current_timestamp COMMENT '创建时间，创建记录后需要填写',
  `updatetime` DATETIME NULL COMMENT '更新时间，更新记录后需要填写。',
  `deletetime` DATETIME NULL COMMENT '删除时间，删除标志变为1后需要填写',
  `createowner` VARCHAR(30) NULL COMMENT '创建人，创建记录时需要填写',
  `updateowner` VARCHAR(30) NULL COMMENT '更新人，更新记录后需要填写',
  `deleteowner` VARCHAR(30) NULL COMMENT '删除人，删除标志变为1时，需要填写。',
  `deleteflag` VARCHAR(3) NOT NULL DEFAULT 'N' COMMENT '删除标志，N代表正常，Y代表删除，默认值N',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `idx_tfhDayRpt_id` (`id` ASC))
  COMMENT '按区局统计一个月烽火平台最大值' ENGINE=InnoDB DEFAULT CHARSET=utf8;

#烽火日报表中增加2列机顶盒下载数据
ALTER TABLE tfhDayRpt ADD stbdown double UNSIGNED NOT NULL DEFAULT 0 COMMENT '机顶盒下载流量' AFTER youkuper;
ALTER TABLE tfhDayRpt ADD stbdownper double UNSIGNED NOT NULL DEFAULT 0 COMMENT '机顶盒下载/总流量' AFTER stbdown;
#完成3个平台日报月报统计


#2017-7-8
#烽火设计表中添加一列汇总数据。
INSERT INTO tfhsheji
(nodearea, quju, nodeCname, nodeEname, nodeid, sjkyll, sjjdll, sjjdbf, sjdbkj, createtime, createowner)
VALUES ('上海烽火','上海烽火','烽火汇总','spidAll','01','120000','150000','18750','1440',NOW(),USER());
COMMIT;