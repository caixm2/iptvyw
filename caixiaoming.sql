use iptvyw01;

create table tmp_thwtongji
as select * from thwtongji;

create table tmp_thwethTraffic
as select * from thwethTraffic;

delete from thwtongji;
select * from thwtongji;

select current_user() from dual;
select current_date() from DUAL;
select t2.upid, t2.popid, t1.jiedian as upjiedian, t2.jiedian as downjiedian,
t1.tjdbkj/1024 as '上级总空间', t1.tjsykj/1024 as '上级使用空间', t1.tjkjsyl as '上级空间使用率',
t2.tjdbkj/1024 as '下级总空间', t2.tjsykj/1024 as '下级使用空间', t2.tjkjsyl as '下级空间使用率',
t2.createtime
from tmp_thwtongji t1 right join tmp_thwtongji t2
on t1.popid = t2.upid
where unix_timestamp(t2.createtime) > current_date()
order by t2.upid;

select t2.jiedian as jiedian,
t2.tjdbkj/1024 as tjdbkj, t2.tjsykj/1024 as tjsykj, t2.tjkjsyl as tjkjsyl
from thwtongji t2
where unix_timestamp(t2.createtime) > unix_timestamp('2016-04-04 20:30')
and t2.upid = 0
order by t2.upid, t2.jiedian;

select t1.*, t2.*
from thwtongji t1 right join thwtongji t2
on t1.popid = t2.upid
where unix_timestamp(t2.createtime) > unix_timestamp('2016-04-04 20:30')
and (unix_timestamp(t1.createtime) > unix_timestamp('2016-04-04 20:30') || 
	t2.popid = '1')
order by t2.upid, t2.jiedian;

select t4.jdname as jiedian,t4.sjjdll as width, 
t3.smaxoutput as output, round(t3.smaxoutput/t4.sjjdll*100,0) as outputper, 
t4.sjbf as tjhmsrl , t2.tjhmssy as tjhmssy, round(t2.tjhmssy/t4.sjbf*100,0) as tjhmssyl, 
t4.sjepgbf as tjepgrl , t2.tjepgsy as tjepgsy, round(t2.tjepgsy/t4.sjepgbf*100,0) as tjepgsyl, 
round(t2.tjdbkj/1024,2) as tjdbkj, round(t2.tjsykj/1024,2) as tjsykj, round(t2.tjsykj/t2.tjdbkj*100,0) as tjkjsyl
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
SELECT * from vhwethToday;

select  count(t2.tjdbkj/1024) as hejinum, round(sum(t4.sjjdll),0) as hejiwidth, 
        round(sum(t3.smaxoutput),0) as hejioutput, round(sum(t3.smaxoutput)/sum(t4.sjjdll)*100,0) as hejioutputper, 
        sum(t4.sjbf) as hejihmsrl , sum(t2.tjhmssy) as hejihmssy, round(sum(t2.tjhmssy)/sum(t4.sjbf)*100,0) as hejihmssyl, 
        sum(t4.sjepgbf) as hejiepgrl , sum(t2.tjepgsy) as hejiepgsy, round(sum(t2.tjepgsy)/sum(t4.sjepgbf)*100,0) as hejiepgsyl, 
        round(sum(t2.tjdbkj/1024),2) as heji, round(sum(t2.tjsykj/1024),2) as kjheji, round(sum(t2.tjsykj)/sum(t2.tjdbkj)*100,0) as kjhejisyl
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

CREATE USER 'caixiaoming'@'localhost' IDENTIFIED BY 'toor';
GRANT ALL ON iptvyw01.* TO 'caixiaoming'@'localhost';

insert into thwtongji(popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl,
    tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl,
    tjgfdb, tjgfzb, tjgq, tjbq, opt1, opt2, opt3, opt4, opt5, 
    createtime, updatetime, createowner, updateowner)
select popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl,
    tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl,
    tjgfdb, tjgfzb, tjgq, tjbq, opt1, opt2, opt3, opt4, opt5,
    now(), now(), user(), user()
from tmp_thwtongji;
delete from thwtongji;
commit;
rollback;
SELECT * from thwtongji;
delete from thwtongji
where unix_timestamp(createtime) > unix_timestamp(current_date());
select * from tmp_thwtongji;
truncate table tmp_thwtongji;
show variables like 'autocommit';
set autocommit = 0;

DELETE from tmp_thwethTraffic;
delete from thwethTraffic
where unix_timestamp(createtime) > unix_timestamp(current_date());


select jiedian, ROUND(sum(ethbandwidth)/1000, 0) as sethbandwidth, 
	   ROUND(sum(maxoutput)/1000/1000/1000, 2) as smaxoutput, 
       ROUND(sum(maxinput)/1000/1000/1000, 2) as smaxinput, 
       ROUND((sum(maxoutput)/1000/1000/1000)/(sum(ethbandwidth)/1000)*100, 2) as soutputper, 
       ROUND((sum(maxinput)/1000/1000/1000)/(sum(ethbandwidth)/1000)*100, 2) as sinputper
from thwethTraffic
where unix_timestamp(createtime) > unix_timestamp(current_date())
group by jiedian;

INSERT INTO thwethTraffic(jiedian, ipaddr, srvtype, ethport, 
       ethbandwidth, avginput, avgoutput, maxinput, maxoutput, inputper, 
       outputper, status, ethinfo, errornum, opt1, opt2, opt3, opt4, opt5,
       createtime, updatetime, createowner, updateowner)
SELECT jiedian, ipaddr, srvtype, ethport, 
       ethbandwidth, avginput, avgoutput, maxinput, maxoutput, inputper, 
       outputper, status, ethinfo, errornum, opt1, opt2, opt3, opt4, opt5,
       now(), now(), user(), user() 
FROM tmp_thwethTraffic;

CREATE or REPLACE VIEW vhwethToday 
AS select jiedian as sjiedian, 
	   ROUND(sum(maxoutput)/1024/1024/1024, 2) as smaxoutput, 
       ROUND(sum(maxinput)/1024/1024/1024, 2) as smaxinput
from thwethTraffic
where unix_timestamp(createtime) > unix_timestamp(current_date())
group by jiedian; 

select * from vhwethToday;


  TRUNCATE table thwtongji;               
  truncate table thwethTraffic;
show variables like '%character_set%';

select * from thwsheji;
select * from thwtongji ;
select * from thwethTraffic WHERE id > 39000;

select version();
delimiter ;//

call p1();


CREATE TABLE `iptvyw01`.`tztehmsbf` (
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

CREATE TABLE `iptvyw01`.`tztedbkj` (
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

CREATE PROCEDURE dbInsertTmp_tztedbkj()
INSERT INTO tmp_tztedbkj
(seqnum, starttime, endtime, qryinterval, hmsname, dbsjkj, dbsykj)  
VALUES(%s, %s, %s, %s, %s, %s, %s);//

select * from tmp_tztedbkj;

select * from tmp_thwethTraffic;

INSERT INTO tztedbkj(hmsname, dbsjkj, dbsykj, updatetime, 
                     createowner, updateowner) 
SELECT hmsname, MAX(dbsjkj), MAX(dbsykj),  NOW(), USER(), USER() 
FROM tmp_tztedbkj
GROUP BY hmsname; commit;
truncate table tztedbkj;
truncate table tztehmsbf;
delete from tztedbkj;commit;
select * from tztedbkj order by createtime desc;
select * from tztehmsbf order by createtime desc;

INSERT INTO tztedbkj(hmsname, dbsjkj, dbsykj, createtime, updatetime, 
                   createowner, updateowner)  
SELECT hmsname, MAX(dbsjkj), MAX(dbsykj), NOW(), NOW(), USER(), USER()  
FROM tmp_tztedbkj  GROUP BY hmsname; commit;

INSERT INTO tztehmsbf(hmsname, livenum, livebandwidth, vodnum, vodbandwidth, 
                    tvodnum, tvodbandwidth, tstvnum, tstvbandwidth, 
                    updatetime, createowner, updateowner)
SELECT hmsname, MAX(livenum), MAX(livebandwidth), MAX(vodnum), MAX(vodbandwidth),
	    MAX(tvodnum), MAX(tvodbandwidth), MAX(tstvnum), MAX(tstvbandwidth), 
        NOW(), USER(), USER()
FROM tmp_tztehmsbf
GROUP BY hmsname;COMMIT;

SELECT hmsname, livenum + vodnum + tvodnum +tstvnum AS num,
	    (livebandwidth + vodbandwidth + tvodbandwidth + tstvbandwidth)/1024/1024 AS bandwidthGbps, 
        (livebandwidth + vodbandwidth + tvodbandwidth + tstvbandwidth)/1024/(livenum + vodnum + tvodnum +tstvnum)
FROM tztehmsbf;

TITLE = ['节点','设计带宽(Gbps)','输出带宽(Gbps)','输出带宽占比(%)',
        'EPG总并发(个)','EPG峰值并发(个)','EPG并发率(%)',
           '流媒体总并发(个)','流媒体峰值并发(个)','流媒体并发率(%)',
           '存储总空间(T)','已使用空间(T)','空间使用率(%)', 
           '区域设计带宽(Gbps)','区域输出带宽(Gbps)','区域输出带宽占比(%)',
           '区域EPG总并发合计(个)','区域EPG峰值并发合计(个)','区域EPG并发率(%)',
           '区域流媒体总并发合计(个)','区域流媒体峰值并发合计(个)','区域流媒体并发率(%)',
           '区域空间合计(T)', '区域使用空间合计(T)','区域空间使用率(%)']
select sj.nodename,ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,
       sj.sjjdll, ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 2) AS bandwidthGbps, 
       ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/sj.sjjdll*100,0) AS bandper,
--       sj.sjepgbf, sj.sjepgbf, round(sj.sjepgbf/sj.sjepgbf*100,0) as epgper,
       epg.epggrpmaxnum, epg.epggrpbf, round(epg.epggrpbf/epg.epggrpmaxnum*100,0) as epgper,
       sj.sjhmsbf, hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum AS hmsbf, 
	   round((hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sj.sjhmsbf*100,0) AS hmsper,
       sj.sjdbkj/1024/1024, db.dbsykj/1024/1024, round(db.dbsykj/sj.sjdbkj*100, 0) as dbper
from tztehmsbf hms, tztedbkj db, tztesheji sj, vzteepggrpbf epg
where hms.hmsname = sj.wgname
and   db.hmsname = sj.wgname
and   epg.epggrpname = sj.epggroupname
and   unix_timestamp(hms.createtime) > unix_timestamp(current_date())
and   unix_timestamp(db.createtime) > unix_timestamp(current_date())
order by sj.nodecluster, sj.nodename;

select count(sj.nodename) as countsum, ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,
       sum(sj.sjjdll), ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 2) AS bandwidthGbps, 
       ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/sum(sj.sjjdll)*100,0) AS bandper,
       sum(sj.sjepgbf), sum(sj.sjepgbf), round(sum(sj.sjepgbf)/sum(sj.sjepgbf)*100,0) as epgper,
       sum(sj.sjhmsbf), sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum) AS hmsbf, 
	   round(sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sum(sj.sjhmsbf)*100,0) AS hmsper,
       sum(sj.sjdbkj)/1024/1024, sum(db.dbsykj)/1024/1024, round(sum(db.dbsykj)/sum(sj.sjdbkj)*100, 0) as dbper
from tztehmsbf hms, tztedbkj db, tztesheji sj
where hms.hmsname = sj.wgname
and   db.hmsname = sj.wgname
and   unix_timestamp(hms.createtime) > unix_timestamp(current_date())
and   unix_timestamp(db.createtime) > unix_timestamp(current_date())
group by sj.nodecluster
order by sj.nodecluster, sj.nodename;

INSERT INTO tzteepgbf(epgname, epgbf, updatetime, createowner, updateowner)
SELECT epgname, MAX(epgbf), NOW(), USER(), USER()
FROM tmp_tzteepgbf epg
GROUP BY epgname;

drop view vzteepggrpbf;
CREATE SQL SECURITY INVOKER VIEW vzteepggrpbf
AS SELECT grp.epggroupname AS epggrpname, SUM(grp.epgmaxnum) AS epggrpmaxnum, SUM(bf.epgbf) AS epggrpbf
FROM tzteepggrpsvr grp, tzteepgbf bf
WHERE grp.epgname = bf.epgname
and unix_timestamp(bf.createtime) > unix_timestamp(current_date())
GROUP BY grp.epggroupname
ORDER BY grp.epggroupid;

select * from vzteepggrpbf;

select * from tzteepgbf;


select count(*) from tmp_tzteepgbf;

select * from tztesheji;