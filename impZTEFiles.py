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
FILEPATHDBC = os.getcwd() + '/tmp/8000H节点空间_413_201607280100.csv'
FILEPATHTRAFFICC = ''
FILEPATHDBH = ''
FILEPATHTRAFFICH = ''
ENCODES = 'GB2312'
DELIMITER = ','
dbInsertTmp_tztedbkj = "INSERT INTO tmp_tztedbkj "
dbInsertTmp_tztedbkj += " (seqnum, starttime, endtime, qryinterval, hmsname, dbsjkj, dbsykj) "
dbInsertTmp_tztedbkj += " VALUES ( %s, %s, %s, %s, %s, %s, %s);"

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
password = 'JxP#Q9z'
# def unzipfile(zip_file, output_dir):
#     f_zip = zipfile.ZipFile(zip_file, 'r', )
# 
#     f_zip.extractall(output_dir, pwd = password.encode('utf-8'))
#     for f in f_zip.namelist():
#         f_zip.extract(f, os.path.join(output_dir, 'bak'), pwd = password.encode('utf-8'))


if __name__ == "__main__":
#     print(calc([1,2,3]))
#     
#     print(getYesterday())
#     
#     print(sliceList( ['1', '2', '3', '4', '5'], 2))
    
#     try:
#         #unzipfile('/home/caixiaoming/workspace/iptvyw/cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#         unzipfile('./cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#     except Exception as 
#         print('unzipfile error',e)
    try:
        conn = MysqlConn()
        result = conn.getAll('select * from thwsheji;')
        tvutil = IptvUtil('/output/dRpt/中兴并发日报', '中兴并发')
        ztezippath = os.getcwd() + '/input/zte/8000H节点空间_413_201607280100' + '.zip'
        print(ztezippath)
    #unzipfile('/home/caixiaoming/workspace/iptvyw/cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
    #unzipfile(hwzippath, os.getcwd() +  '/tmp/')
        tvutil.unzipfile(ztezippath, os.getcwd() +  '/tmp/')
    #result = mysql.getProcAll('p1')
        conn.printInfo()
        #workbook = xlsxwriter.Workbook(os.getcwd() + '/output/dRpt/中兴并发日报' +str(tvutil.getYesterday()) +  '.xlsx')
        #worksheet = workbook.add_worksheet('中兴并发')
        #worksheet.write_row(1, 0, title, formatTitle())
        tvutil.writerow(1,0, TITLE)
        
        csv_data = csv.reader(open(FILEPATHDBC, encoding=ENCODES), delimiter = DELIMITER ) 
        next(csv_data)
        n = 0
        for row in csv_data:
            n = n + 1
            print( n )
            print(row)
            #cur.execute(sqlInsertTmp, row)  
            #print(dbInsertTmp_tztedbkj % ['1', '2016-07-27 00:00:00', '2016-07-27 00:15:00', '15分钟', '七期扩容,ZXUSS_VS8000HID=bqpop6-1', '3813612', '764693'])
            conn.insertOne(dbInsertTmp_tztedbkj, row)  

            print(n)         
            conn.commit()
            print('commit' + n)
        print('插入 ' + n)
    except Exception as e:
        conn.rollback()
        print('Error: ', e)
    finally:
        #cur.close()
        conn.close()
        tvutil.close()

    print(len(result))
    print(*result[1])
        