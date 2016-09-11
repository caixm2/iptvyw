#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

from datetime import timedelta, date
from dbConnection import MysqlConn
from iptvUtil import IptvUtil
import zipfile, os, xlsxwriter,csv,sys
from tkinter.tix import ROW

TITLE = ['节点','平均码流(Mbps)','设计带宽(Gbps)','输出带宽(Gbps)','输出带宽占比(%)',
        'EPG总并发(个)','EPG峰值并发(个)','EPG并发率(%)',
           '流媒体总并发(个)','流媒体峰值并发(个)','流媒体并发率(%)',
           '存储总空间(T)','已使用空间(T)','空间使用率(%)', '区域平均码流(Mbps)',
           '区域设计带宽(Gbps)','区域输出带宽(Gbps)','区域输出带宽占比(%)',
           '区域EPG总并发合计(个)','区域EPG峰值并发合计(个)','区域EPG并发率(%)',
           '区域流媒体总并发合计(个)','区域流媒体峰值并发合计(个)','区域流媒体并发率(%)',
           '区域空间合计(T)', '区域使用空间合计(T)','区域空间使用率(%)']


ENCODES = 'GB2312'
DELIMITER = ','
dbInsertTmp_tztedbkj = "INSERT INTO tmp_tztedbkj "
dbInsertTmp_tztedbkj += " (seqnum, starttime, endtime, qryinterval, hmsname, dbsjkj, dbsykj) "
dbInsertTmp_tztedbkj += " VALUES ( %s, %s, %s, %s, %s, %s, %s);"

dbInsertTmp_tztehmsbf = "INSERT INTO tmp_tztehmsbf "
dbInsertTmp_tztehmsbf += " (seqnum, starttime, endtime, qryinterval, hmsname, livenum, livebandwidth, "
dbInsertTmp_tztehmsbf += " vodnum, vodbandwidth, tvodnum, tvodbandwidth, tstvnum, tstvbandwidth) "
dbInsertTmp_tztehmsbf += " VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"

epgInsertTmp_tzteepgbf = "INSERT INTO tmp_tzteepgbf "
epgInsertTmp_tzteepgbf += " (epgdate, epgtime, epgname, epgbf)"
epgInsertTmp_tzteepgbf += " VALUES(%s, %s, %s, %s);"

truncateTmp_tztedbkj = "truncate table tmp_tztedbkj;"
truncateTmp_tztehmsbf = "truncate table tmp_tztehmsbf;"
truncateTmp_tzteepgbf = "truncate table tmp_tzteepgbf;"


tmp2dbkj = "INSERT INTO tztedbkj(hmsname, dbsjkj, dbsykj, createtime, updatetime, "
tmp2dbkj += "                   createowner, updateowner) "
tmp2dbkj += " SELECT hmsname, MAX(dbsjkj), MAX(dbsykj), NOW(), NOW(), USER(), USER() "
tmp2dbkj += " FROM tmp_tztedbkj "
tmp2dbkj += " GROUP BY hmsname;"

tmp2hmsbf = "INSERT INTO tztehmsbf(hmsname, livenum, livebandwidth, vodnum, vodbandwidth, "
tmp2hmsbf += "                    tvodnum, tvodbandwidth, tstvnum, tstvbandwidth, "
tmp2hmsbf += "                     updatetime, createowner, updateowner) "
tmp2hmsbf += " SELECT hmsname, MAX(livenum), MAX(livebandwidth), MAX(vodnum), MAX(vodbandwidth), "
tmp2hmsbf += "      MAX(tvodnum), MAX(tvodbandwidth), MAX(tstvnum), MAX(tstvbandwidth), "
tmp2hmsbf += "         NOW(), USER(), USER() "
tmp2hmsbf += " FROM tmp_tztehmsbf "
tmp2hmsbf += " GROUP BY hmsname;"

tmp2epgbf = "INSERT INTO tzteepgbf(epgname, epgbf, updatetime, createowner, updateowner)"
tmp2epgbf += " SELECT epgname, MAX(epgbf), NOW(), USER(), USER()"
tmp2epgbf += " FROM tmp_tzteepgbf epg"
tmp2epgbf += " GROUP BY epgname;"

ztepop = " select sj.nodename,ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,"
ztepop += "        round(sj.sjjdll/1024,0) jdll, ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 2) AS bandwidthGbps,"
ztepop += "        ROUND((hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/(sj.sjjdll/1024)*100,0) AS bandper,"
ztepop += "        epg.epggrpmaxnum, epg.epggrpbf, round(epg.epggrpbf/epg.epggrpmaxnum*100,0) as epgper,"
ztepop += "        sj.sjhmsbf, hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum AS hmsbf,"
ztepop += "        round((hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sj.sjhmsbf*100,0) AS hmsper,"
ztepop += "        round(sj.sjdbkj/1024/1024, 0) AS dbkj, round(db.dbsykj/1024/1024, 0) AS sykj, round(db.dbsykj/sj.sjdbkj*100, 0) as dbper"
ztepop += " from tztesheji sj"
ztepop += " left join  tztehmsbf hms"
ztepop += " on   sj.wgname = hms.hmsname"
ztepop += " left join tztedbkj db"
ztepop += " on   sj.wgname = db.hmsname"
ztepop += " left join vzteepggrpbf epg"
ztepop += " on   sj.epggroupname = epg.epggrpname"
ztepop += " where   (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)"
ztepop += " and   (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)"
ztepop += " order by sj.clusterid, sj.nodename;"


ztepopSum = "select count(sj.nodename) as countsum, ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum), 2) as avgwidth,"
ztepopSum += "        round(sum(sj.sjjdll)/1024, 0) AS jdllsum, ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024, 2) AS bandwidthGbps,"
ztepopSum += "        ROUND(sum(hms.livebandwidth + hms.vodbandwidth + hms.tvodbandwidth + hms.tstvbandwidth)/1024/1024/sum(sj.sjjdll)*100,0) AS bandper,"
ztepopSum += "        sum(epg.epggrpmaxnum), sum(epg.epggrpbf), round(sum(epg.epggrpbf)/sum(epg.epggrpmaxnum)*100,0) as epgper,"
ztepopSum += "        sum(sj.sjhmsbf), sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum) AS hmsbf,"
ztepopSum += "        round(sum(hms.livenum + hms.vodnum + hms.tvodnum + hms.tstvnum)/sum(sj.sjhmsbf)*100,0) AS hmsper,"
ztepopSum += "        round(sum(sj.sjdbkj)/1024/1024, 0) AS dbkjsum, round(sum(db.dbsykj)/1024/1024) AS sykjsum, round(sum(db.dbsykj)/sum(sj.sjdbkj)*100, 0) as dbper"
ztepopSum += " from tztesheji sj"
ztepopSum += " left join  tztehmsbf hms"
ztepopSum += " on   sj.wgname = hms.hmsname"
ztepopSum += " left join tztedbkj db"
ztepopSum += " on   sj.wgname = db.hmsname"
ztepopSum += " left join vzteepggrpbf epg"
ztepopSum += " on   sj.epggroupname = epg.epggrpname"
ztepopSum += " where   (unix_timestamp(hms.createtime) > unix_timestamp(current_date()) or hms.createtime is null)"
ztepopSum += " and   (unix_timestamp(db.createtime) > unix_timestamp(current_date()) or db.createtime is null)"
ztepopSum += " group by sj.clusterid"
ztepopSum += " order by sj.clusterid, sj.nodename;"



def calc(numbers):
    sum = 0
    for n in numbers:
        sum += n*n
    return sum

def getYesterday():
    yesterday = date.today() - timedelta(days = 1)
    return yesterday

def sliceList(L , pos = 1):

    return L[pos:]


if __name__ == "__main__":
    try:
        conn = MysqlConn()
        conn.getAll(truncateTmp_tztedbkj)
        conn.getAll(truncateTmp_tztehmsbf)
        conn.getAll(truncateTmp_tzteepgbf)
        tvutil = IptvUtil('/output/dRpt/中兴并发日报', '中兴并发')
        filedate = str(tvutil.getYesterday(0)).replace('-','')

        FILEPATHEPG = os.getcwd() + '/input/zte/epg' + filedate + '.txt'
        #result = conn.getAll('select * from thwsheji;')
        
        '''
                导入8000H存储数据
            '''
           
        search_path = os.getcwd() + '/input/zte'
   
  
        ztezippath = tvutil.search_file('8000Hkongjian_*_' + filedate + '0100.zip', search_path)
        print('8000Hkongjian_*_' + filedate + '0100.zip')
        if ztezippath is None:
             print('not file 8000Hkongjian_*_' + filedate + '0100.zip')
             exit()
        else:
            print(ztezippath)
       
            tvutil.unzipfile(ztezippath, os.getcwd() +  '/tmp/')
            conn.printInfo()
            FILEPATHDBH = os.getcwd() + '/tmp/' + os.path.basename(ztezippath).replace('.zip', '.csv')
            print(FILEPATHDBH)
            csv_data = csv.reader(open(FILEPATHDBH, encoding=ENCODES), delimiter = DELIMITER ) 
            print('unzipfile complete')   
            next(csv_data)
   
            for row in csv_data:
                conn.insertOne(dbInsertTmp_tztedbkj, row)  
            conn.commit()
            ztezippath = ''
            print('H commit')
        '''
                导入8000C存储数据
            '''
        print('search_path' + search_path)
        ztezippath = tvutil.search_file('8000Ckongjian_*_' + filedate + '0200.zip', search_path)
           
        print('8000Ckongjian_*_' + filedate + '0200.zip')
        if ztezippath is None:
            print('not file 8000Ckongjian_*_' + filedate + '0200.zip')
            exit()
        else:
            tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
            FILEPATHDBC = os.getcwd() + '/tmp/' + os.path.basename(ztezippath).replace('.zip', '.csv')
            print(FILEPATHDBC)
            csv_data = csv.reader(open(FILEPATHDBC, encoding=ENCODES), delimiter = DELIMITER ) 
            next(csv_data)
            for row in csv_data:
                conn.insertOne(dbInsertTmp_tztedbkj, row)  
            conn.commit()
            print(tmp2dbkj)
            conn.insertOne(tmp2dbkj)
            conn.commit();
            ztezippath = ''
        '''
                导入8000H流量和并发
            '''
        ztezippath = tvutil.search_file('8000Hmalvtongji_*_' + filedate + '0130.zip', search_path)
        print('8000Hmalvtongji_*_' + filedate + '0130.zip')
        if ztezippath is None:
            print('not file 8000Hmalvtongji_*_' + filedate + '0130.zip')
            exit()
        else:
            tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
            FILEPATHTRAFFICH = os.getcwd() + '/tmp/' + os.path.basename(ztezippath).replace('.zip', '.csv')
            print(FILEPATHTRAFFICH)
            csv_data = csv.reader(open(FILEPATHTRAFFICH, encoding=ENCODES), delimiter = DELIMITER ) 
            next(csv_data)
            for row in csv_data:
                conn.insertOne(dbInsertTmp_tztehmsbf, row)  
            conn.commit()
        ztezippath = ''
        '''
                导入8000C流量和并发
            '''
        ztezippath = tvutil.search_file('8000Cmalvtongji_*_' + filedate + '0130.zip', search_path)
        print('8000Cmalvtongji_*_' + filedate + '0130.zip')
        if ztezippath is None:
            print('not file 8000Cmalvtongji_*_' + filedate + '0130.zip')
            exit()
        else:
            tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
            FILEPATHTRAFFICC = os.getcwd() + '/tmp/' + os.path.basename(ztezippath).replace('.zip', '.csv')
            print(FILEPATHTRAFFICC)
            csv_data = csv.reader(open(FILEPATHTRAFFICC, encoding=ENCODES), delimiter = DELIMITER ) 
            next(csv_data)
            next(csv_data)
            for row in csv_data:
                conn.insertOne(dbInsertTmp_tztehmsbf, row)  
            conn.commit()
            ztezippath = ''
           
            print(tmp2hmsbf)
            conn.insertOne(tmp2hmsbf)
            conn.commit();
        '''
               导入epg数据
            '''
        csv_data = csv.reader(open(FILEPATHEPG, encoding = ENCODES), delimiter = ' ')
    
        for row in csv_data:
            conn.insertOne(epgInsertTmp_tzteepgbf, row)
        conn.commit();
            
        print(tmp2epgbf)
        conn.insertOne(tmp2epgbf)
        print('insert commit.')
        conn.commit();
        print('insert commit2.')
            
           
  
        '''
                数据导出到xlsx文件
            '''
        tvutil.writerow(1,0, TITLE)
        row = 1
        col = 0
        res1 = conn.getAll(ztepop)
        if res1 is False:
            print('res1 is False, exit.')
            exit()
        else:
 
            for res in res1: 
                row += 1
                tvutil.writerow(row, col, res)
 
            print('cell done')
         
        col += 14
        row = 2
        resSum = conn.getAll(ztepopSum)
        if resSum is False:
            print('中兴统计返回值为0，出错退出')
        else:
            for res in resSum:
#                 print(len(res))
#                 print(res[1:(len(res))])
                firstrow = row
                if int(res[0]) == 1:
                    tvutil.writerow(firstrow, col, res[1:len(res)])
                else:
                    row += int(res[0]) - 1
                    for i in range(13):
                        tvutil.mergerange(firstrow, col + i, row, col + i)
                tvutil.writerow(firstrow, col, res[1:len(res)])
                row += 1
         
        tvutil.formatConditional('E3:E90', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('E3:E90', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('H3:H90', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('H3:H90', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('K3:K90', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('K3:K90', '<=', 20, tvutil.formatYellow())
        tvutil.formatConditional('N3:N90', '>=', 90, tvutil.formatRed())
        tvutil.formatConditional('N3:N90', '<=', 20, tvutil.formatYellow())
         
        tvutil.formatColwidth(27, '中兴并发日报', tvutil.formatHead())
            
    except Exception as e:
        conn.rollback()
        print('Error: ', e)
    finally:
        conn.close()
        tvutil.close()

        print ('complete')
#     print(len(result))
#     print(*result[1])
        