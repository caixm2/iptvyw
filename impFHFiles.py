#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

from datetime import timedelta, date
from dbConnection import MysqlConn
from iptvUtil import IptvUtil
import zipfile, os, xlsxwriter,csv,sys
from tkinter.tix import ROW

TITLE = ['节点','平均码流(Mbps)','设计带宽(Gbps)','输出带宽(Gbps)','输出带宽占比(%)',
           '流媒体总并发(个)','流媒体峰值并发(个)','流媒体并发率(%)','存储总空间(T)',
           '已使用空间(T)','空间使用率(%)', '芒果tv(Mbps)','芒果tv(%)','4K(Mbps)','4K(%)',
           '优酷(Mbps)','优酷(%)','机顶盒升级(Mbps)','机顶盒升级(%)', '百事通回源(Mbps)','百事通回源(%)', 
           '测速(Mbps)','测速(％)','播播(Mbps)','播播(%)','天翼视讯(Mbps)','天翼视讯(%)',
           '教育中心(Mbps)','教育中心(%)','华数(Mbps)','华数(%)',
           '嘉攸(Mbps)','嘉攸(%)','嘉攸直播(Mbps)','嘉攸直播(%)',
        'EPG名字','EPG总并发(个)','EPG IP','EPG峰值并发(个)','EPG并发率(%)']


ENCODES = 'GB2312'
DELIMITER = ','
dbInsertTmp_tfhhmsbf = "INSERT INTO tmp_tfhhmsbf "
dbInsertTmp_tfhhmsbf += " (hmsdatetime, nodeEname, cpname, maxoutput, maxinput, maxhmsbf) "
dbInsertTmp_tfhhmsbf += " VALUES ( %s, %s, %s, %s, %s, %s);"

dbInsertTmp_tfhepgbf = "INSERT INTO tmp_tfhepgbf "
dbInsertTmp_tfhepgbf += " (epgname, epgip, epgmaxbf) "
dbInsertTmp_tfhepgbf += " VALUES (%s, %s, %s);"

dbInsertTmp_tfhdbspace = "INSERT INTO tmp_tfhdbspace "
dbInsertTmp_tfhdbspace += " (nodeEname, dbdatetime, usedspace, freespace, totalspace, usedpercent)"
dbInsertTmp_tfhdbspace += " VALUES(%s, %s, %s, %s, %s, %s);"

truncateTmp_tfhhmsbf = "truncate table tmp_tfhhmsbf;"
truncateTmp_tfhepgbf = "truncate table tmp_tfhepgbf;"
truncateTmp_tfhdbspace = "truncate table tmp_tfhdbspace;"


tmp2dbspace = "INSERT INTO tfhdbspace(nodeEname, dbdatetime, usedspace, freespace, totalspace, usedpercent, updatetime, "
tmp2dbspace += "                   createowner, updateowner) "
tmp2dbspace += " SELECT nodeEname, dbdatetime, usedspace, freespace, totalspace, usedpercent, NOW(), USER(), USER() "
tmp2dbspace += " FROM tmp_tfhdbspace;"

tmp2hmsbf = "INSERT INTO tfhhmsbf(hmsdatetime, nodeEname, cpname, maxoutput, maxinput, maxhmsbf, "
tmp2hmsbf += "                     updatetime, createowner, updateowner) "
tmp2hmsbf += " SELECT hmsdatetime, nodeEname, cpname, maxoutput, maxinput, maxhmsbf, NOW(), USER(), USER() "
tmp2hmsbf += " FROM tmp_tfhhmsbf "
#tmp2hmsbf += " WHERE cpname <> 'ALLSP';"
tmp2hmsbf += "WHERE nodeEname = 'spidAll' or cpname <> 'ALLSP';"

tmp2epgbf = "INSERT INTO tfhepgbf(epgip, epgname, epgmaxbf, updatetime, createowner, updateowner)"
tmp2epgbf += " SELECT epgip, epgname, epgmaxbf, NOW(), USER(), USER()"
tmp2epgbf += " FROM tmp_tfhepgbf"
tmp2epgbf += " WHERE epgip <> 'allIp' ;"

fhpop =  "SELECT sj.nodeCname, ROUND(SUM(hms.maxoutput)/SUM(hms.maxhmsbf),0) avgwdith, sj.sjjdll, "
fhpop += "        ROUND(SUM(hms.maxoutput),0) maxoutput, "
fhpop += "        ROUND(SUM(hms.maxoutput)/sj.sjjdll*100,0) outputper,"
fhpop += "        sj.sjjdbf, SUM(hms.maxhmsbf) hmsbf, ROUND(SUM(hms.maxhmsbf)/sj.sjjdbf*100, 0) bfper,"
fhpop += "        sj.sjdbkj, ROUND(db.usedspace/1024/1024, 0) useddb, "
fhpop += "        ROUND(db.usedspace/1024/1024/sjdbkj*100, 0) dbper,"
fhpop += "        sum(if (hms.cpname = '芒果tv', round(hms.maxoutput, 0), 0)) as mangguo,"
fhpop += "        ROUND(sum(if (hms.cpname = '芒果tv', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS mangguoPer,"
fhpop += "        sum(if (hms.cpname = '4K' , round(hms.maxoutput, 0) , 0)) 4K, "
fhpop += "        ROUND(sum(if (hms.cpname = '4K', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS 4KPer,"
fhpop += "        sum(if (hms.cpname = '优酷土豆', round(hms.maxoutput, 0), 0)) youku,"
fhpop += "        ROUND(sum(if (hms.cpname = '优酷土豆', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS youkuPer,"
fhpop += "        sum(if (hms.cpname = '机顶盒升级包', round(hms.maxoutput, 0), 0)) stbdown,"
fhpop += "        ROUND(sum(if (hms.cpname = '机顶盒升级包', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS stbdownPer,"
fhpop += "        sum(if (hms.cpname = '百事通回源', round(hms.maxoutput, 0), 0)) bestvsrc,"
fhpop += "        ROUND(sum(if (hms.cpname = '百事通回源', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS bestvsrcPer,"
fhpop += "        sum(if (hms.cpname = '测速', round(hms.maxoutput, 0), 0)) cesu,"
fhpop += "        ROUND(sum(if (hms.cpname = '测速', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS cesuPer,"
fhpop += "        sum(if (hms.cpname = 'bobo', round(hms.maxoutput, 0), 0)) bobo,"
fhpop += "        ROUND(sum(if (hms.cpname = 'bobo', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS boboPer,"
fhpop += "        sum(if (hms.cpname = '天翼视讯', round(hms.maxoutput, 0), 0)) tianyi,"
fhpop += "        ROUND(sum(if (hms.cpname = '天翼视讯', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS tianyiPer,"
fhpop += "        sum(if (hms.cpname = '教育中心', round(hms.maxoutput, 0), 0)) jiayu,"
fhpop += "        ROUND(sum(if (hms.cpname = '教育中心', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jiaoyuPer,"
fhpop += "        sum(if (hms.cpname = '华数', round(hms.maxoutput, 0), 0)) huasu,"
fhpop += "        ROUND(sum(if (hms.cpname = '华数', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS huasuPer,"
fhpop += "        sum(if (hms.cpname = '嘉攸', round(hms.maxoutput, 0), 0)) jiayou,"
fhpop += "        ROUND(sum(if (hms.cpname = '嘉攸', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jiayouPer,"
fhpop += "        sum(if (hms.cpname = '嘉攸直播', round(hms.maxoutput, 0), 0)) jylive,"
fhpop += "        ROUND(sum(if (hms.cpname = '嘉攸直播', round(hms.maxoutput, 0), 0))/sj.sjjdll*100, 0) AS jylivePer"
fhpop += " FROM tfhsheji sj "
fhpop += " LEFT JOIN tfhhmsbf hms"
fhpop += " ON sj.nodeEname = hms.nodeEname"
fhpop += " LEFT JOIN tfhdbspace db"
fhpop += " ON sj.nodeEname = db.nodeEname"
fhpop += " WHERE sj.nodeCname <> '高生节点'"
fhpop += " AND    (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)"
fhpop += " AND    (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)"
fhpop += " GROUP BY sj.nodeCname"
fhpop += " ORDER BY substring_index('烽火汇总',sj.nodeCname,1), sj.nodeCname;"

epgbf = "SELECT epgsj.epgname, epgsj.epgsjbf, epgsj.epgip,epgbf.epgmaxbf, ROUND(epgbf.epgmaxbf/epgsj.epgsjbf*100,0)"
epgbf += " FROM tfhepgsheji epgsj, tfhepgbf epgbf"
epgbf += " WHERE epgsj.epgip = epgbf.epgip"
epgbf += " AND   unix_timestamp(epgbf.createtime) > unix_timestamp(current_date());"


if __name__ == "__main__":
    try:
        conn = MysqlConn()
        conn.getAll(truncateTmp_tfhhmsbf)
        conn.getAll(truncateTmp_tfhepgbf)
        conn.getAll(truncateTmp_tfhdbspace)
        tvutil = IptvUtil('/output/dRpt/烽火并发日报', '烽火并发')
        filedate = str(tvutil.getYesterday()).replace('-','')
        print(filedate)

#        FILEPATHEPG = os.getcwd() + '/input/fenhuo/epg_out_peak_' + filedate + '.csv'
        
        '''
                     检查文件是否完整
            '''
        epgfile = os.getcwd() + '/input/fenhuo/epg_out_peak_' + filedate + '.csv'
        if tvutil.isExistFile(epgfile) is False:
            print('文件不存在：' + epgfile)
            exit()

        ssfile = os.getcwd() + '/input/fenhuo/ss_out_peak_' + filedate + '.csv'
        if tvutil.isExistFile(ssfile) is False:
            print('文件不存在：' + ssfile)
            exit()
            
        dbfile = os.getcwd() + '/input/fenhuo/storage_UseRate_' + filedate + '.csv'
        if tvutil.isExistFile(dbfile) is False:
            print('文件不存在：' + dbfile)
            exit()
        
        '''
                导入烽火EPG数据
            '''
        csv_data = csv.reader(open(epgfile, encoding=ENCODES), delimiter = DELIMITER ) 
        next(csv_data)
     
        for row in csv_data:
            conn.insertOne(dbInsertTmp_tfhepgbf, row)  
        
        print(epgfile + 'EPG数据导入完成。')
            
        '''
                导入烽火流媒体数据
            '''
        csv_data = csv.reader(open(ssfile, encoding=ENCODES), delimiter = DELIMITER ) 
        next(csv_data)
     
        for row in csv_data:
            conn.insertOne(dbInsertTmp_tfhhmsbf, row)  

        print(ssfile + '流媒体数据导入完成。')
        
                    
        '''
                导入存储空间数据
            '''
        csv_data = csv.reader(open(dbfile, encoding=ENCODES), delimiter = DELIMITER ) 
        next(csv_data)
     
        for row in csv_data:
            conn.insertOne(dbInsertTmp_tfhdbspace, row)  
        conn.commit()

        print(dbfile + '存储空间数据导入完成。')

        '''
        EPG数据从临时表导入正式表
            ''' 
        print(tmp2epgbf)
        print(tmp2hmsbf)
        print(tmp2dbspace)                  
        conn.insertOne(tmp2epgbf)

        print('EPG数据从tmp_tfhepgbf导入tfhepgbf。')
        
        '''
               流媒体数据从临时表导入正式表
            ''' 
        conn.insertOne(tmp2hmsbf)

        print('EPG数据从tmp_tfhhmsbf导入tfhhmsbf。')
        '''
               存储空间数据从临时表导入正式表
            '''   
        conn.insertOne(tmp2dbspace)
        conn.commit();

        print('EPG数据从tmp_tfhdbspace导入tfhdbspace。')
 
         
        '''
                数据导出到xlsx文件
            '''
        tvutil.writerow(1,0, TITLE)
        row = 1
        col = 0
        res1 = conn.getAll(fhpop)
        print(len(res1[0]))
        if res1 is False:
            print('res1 is False, exit.')
            exit()
        else:
            for res in res1: 
                row += 1
                tvutil.writerow(row, col, res)
 
            print('cell done')
          
        col += len(res1[0])
        row = 1
        resSum = conn.getAll(epgbf)
        if resSum is False:
            print('烽火EPG并发统计返回值为0，出错退出')
        else:
            for res in resSum:
                row += 1
                tvutil.writerow(row, col, res)
                
         
        tvutil.formatConditional('E3:E8', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('E3:E8', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('H3:H8', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('H3:H8', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('K3:K8', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('K3:K8', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('AL3:AL8', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('AL3:AL8', '<=', 20, tvutil.formatYellow())
         
        tvutil.formatColwidth(37, '烽火并发日报', tvutil.formatHead())
        tvutil.freezecell()
            
    except Exception as e:
        conn.rollback()
        print('Error: ', e)
    finally:
        conn.close()
        tvutil.close()

        print ('complete')
        