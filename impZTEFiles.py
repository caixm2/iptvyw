#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

from datetime import timedelta, date
from dbConnection import MysqlConn
from iptvUtil import IptvUtil
import zipfile, os, xlsxwriter,csv,sys

TITLE = ['节点','设计带宽(Gbps)','输出带宽(Gbps)','输出带宽占比(%)',
        'EPG总并发(个)','EPG峰值并发(个)','EPG并发率(%)',
           '流媒体总并发(个)','流媒体峰值并发(个)','流媒体并发率(%)',
           '存储总空间(T)','已使用空间(T)','空间使用率(%)', 
           '区域设计带宽(Gbps)','区域输出带宽(Gbps)','区域输出带宽占比(%)',
           '区域EPG总并发合计(个)','区域EPG峰值并发合计(个)','区域EPG并发率(%)',
           '区域流媒体总并发合计(个)','区域流媒体峰值并发合计(个)','区域流媒体并发率(%)',
           '区域空间合计(T)', '区域使用空间合计(T)','区域空间使用率(%)']
FILEPATHDBH = os.getcwd() + '/tmp/8000H节点空间_413_201607280100.csv'
FILEPATHDBC = os.getcwd() + '/tmp/8000C节点空间_414_201607280200.csv'
FILEPATHTRAFFICC = os.getcwd() + '/tmp/8000C码率级别_416_201607281230.csv'
FILEPATHTRAFFICH = os.getcwd() + '/tmp/8000H码率统计_415_201607281230.csv'
ENCODES = 'GB2312'
DELIMITER = ','
dbInsertTmp_tztedbkj = "INSERT INTO tmp_tztedbkj "
dbInsertTmp_tztedbkj += " (seqnum, starttime, endtime, qryinterval, hmsname, dbsjkj, dbsykj) "
dbInsertTmp_tztedbkj += " VALUES ( %s, %s, %s, %s, %s, %s, %s);"

dbInsertTmp_tztehmsbf = "INSERT INTO tmp_tztehmsbf "
dbInsertTmp_tztehmsbf += " (seqnum, starttime, endtime, qryinterval, hmsname, livenum, livebandwidth, "
dbInsertTmp_tztehmsbf += " vodnum, vodbandwidth, tvodnum, tvodbandwidth, tstvnum, tstvbandwidth) "
dbInsertTmp_tztehmsbf += " VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"

truncateTmp_tztedbkj = "truncate table tmp_tztedbkj;"
truncateTmp_tztehmsbf = "truncate table tmp_tztehmsbf;"


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
        #result = conn.getAll('select * from thwsheji;')
        tvutil = IptvUtil('/output/dRpt/中兴并发日报', '中兴并发')
        tvutil.writerow(1,0, TITLE)
        
#         '''
#                 导入8000H存储数据
#             '''
#         ztezippath = os.getcwd() + '/input/zte/8000H节点空间_413_201607280100' + '.zip'
#         print(ztezippath)
# 
#         tvutil.unzipfile(ztezippath, os.getcwd() +  '/tmp/')
#         conn.printInfo()

#      
#         csv_data = csv.reader(open(FILEPATHDBH, encoding=ENCODES), delimiter = DELIMITER ) 
#         print('unzipfile complete')   
#         next(csv_data)
#         #n = 0
#         for row in csv_data:
#             conn.insertOne(dbInsertTmp_tztedbkj, row)  
#         conn.commit()
#         print('H commit')
#         '''
#                 导入8000C存储数据
#             '''
#         ztezippath = os.getcwd() + '/input/zte/8000C节点空间_414_201607280200' + '.zip'
#         print('c' + ztezippath)
#         tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
#         csv_data = csv.reader(open(FILEPATHDBC, encoding=ENCODES), delimiter = DELIMITER ) 
#         next(csv_data)
#         for row in csv_data:
#             conn.insertOne(dbInsertTmp_tztedbkj, row)  
#         conn.commit()
#         print(tmp2dbkj)
#         conn.insertOne(tmp2dbkj)
#         conn.commit();
#         
#         '''
#                 导入8000H流量和并发
#             '''
#         ztezippath = os.getcwd() + '/input/zte/8000H码率统计_415_201607281230' + '.zip'
#         print('c' + ztezippath)
#         tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
#         csv_data = csv.reader(open(FILEPATHTRAFFICH, encoding=ENCODES), delimiter = DELIMITER ) 
#         next(csv_data)
#         for row in csv_data:
#             conn.insertOne(dbInsertTmp_tztehmsbf, row)  
#         conn.commit()
#         
#         '''
#                 导入8000C流量和并发
#             '''
#         ztezippath = os.getcwd() + '/input/zte/8000C码率级别_416_201607281230' + '.zip'
#         print('c' + ztezippath)
#         tvutil.unzipfile(ztezippath, os.getcwd() + '/tmp/')
#         csv_data = csv.reader(open(FILEPATHTRAFFICC, encoding=ENCODES), delimiter = DELIMITER ) 
#         next(csv_data)
#         for row in csv_data:
#             conn.insertOne(dbInsertTmp_tztehmsbf, row)  
#         conn.commit()
#         
#         print(tmp2hmsbf)
#         conn.insertOne(tmp2hmsbf)
#         conn.commit();
    except Exception as e:
        conn.rollback()
        print('Error: ', e)
    finally:
        print(conn.getAll('select * from tztedbkj;'))
        conn.close()
        tvutil.close()

    print ('complete')
#     print(len(result))
#     print(*result[1])
        