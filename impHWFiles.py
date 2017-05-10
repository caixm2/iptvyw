#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

import csv,os,pymysql,sys, xlsxwriter,zipfile
from datetime import timedelta, date

'''
1. open a xls file.
2. read a sheet.
3. read cell or row or col.
4. import mysql temple table.
5. insert mysql normal table.
6. export xls file.
'''
host = '127.0.0.1'
port = 3306
user = 'caixiaoming'
pwd = 'toor'
db = 'iptvyw01'
sqltruncate = 'TRUNCATE TABLE tmp_thwtongji;'
sqltruncate2 = 'TRUNCATE TABLE tmp_thwethTraffic;'
filepathmdn = os.getcwd() + '/tmp/out_mdn_pop.csv'
filepathtraffic = os.getcwd() + '/tmp/out_dev_traffic.csv'
encodes = 'GB2312'
delimiter = ','
sqlInsertTmp = 'INSERT INTO tmp_thwtongji(popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl, '
sqlInsertTmp += 'tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl, tjgfdb, tjgfzb, tjgq, tjbq, opt1) ' 
sqlInsertTmp += 'VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'

sqlInsertTmpTraffic = 'INSERT INTO tmp_thwethTraffic (jiedian, ipaddr, srvtype, ethport, '
sqlInsertTmpTraffic += 'ethbandwidth, avginput, avgoutput, maxinput, maxoutput, inputper, '
sqlInsertTmpTraffic += 'outputper, status, ethinfo, errornum) '
sqlInsertTmpTraffic += 'VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);'

sqlTmp2thwtongji = "insert into thwtongji(popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl, "
sqlTmp2thwtongji += "tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl, "
sqlTmp2thwtongji += "tjgfdb, tjgfzb, tjgq, tjbq, opt1, opt2, opt3, opt4, opt5, "
sqlTmp2thwtongji += "createtime, updatetime, createowner, updateowner) "
sqlTmp2thwtongji += "select popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl, "
sqlTmp2thwtongji += "tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl, "
sqlTmp2thwtongji += "tjgfdb, tjgfzb, tjgq, tjbq, opt1, opt2, opt3, opt4, opt5, "
sqlTmp2thwtongji += "now(), now(), user(), user() "
sqlTmp2thwtongji += "from tmp_thwtongji;"

sqlTmp2thwethTraffic = "INSERT INTO thwethTraffic(jiedian, ipaddr, srvtype, ethport, "
sqlTmp2thwethTraffic += "       ethbandwidth, avginput, avgoutput, maxinput, maxoutput, inputper, " 
sqlTmp2thwethTraffic += "       outputper, status, ethinfo, errornum, opt1, opt2, opt3, opt4, opt5, "
sqlTmp2thwethTraffic += "       createtime, updatetime, createowner, updateowner) "
sqlTmp2thwethTraffic += "SELECT jiedian, ipaddr, srvtype, ethport, "
sqlTmp2thwethTraffic += "       ethbandwidth, avginput, avgoutput, maxinput, maxoutput, inputper, "
sqlTmp2thwethTraffic += "       outputper, status, ethinfo, errornum, opt1, opt2, opt3, opt4, opt5, "
sqlTmp2thwethTraffic += "       now(), now(), user(), user() "
sqlTmp2thwethTraffic += "FROM tmp_thwethTraffic;"

sqlQuery1 = "select t4.jdname as jiedian,t4.sjjdll as width, "
sqlQuery1 += "t3.smaxoutput as output, round(t3.smaxoutput/t4.sjjdll*100,0) as outputper, "
sqlQuery1 += "t4.sjbf as tjhmsrl , t2.tjhmssy as tjhmssy, round(t2.tjhmssy/t4.sjbf*100,0) as tjhmssyl, "
sqlQuery1 += "t4.sjepgbf as tjepgrl , t2.tjepgsy as tjepgsy, round(t2.tjepgsy/t4.sjepgbf*100,0) as tjepgsyl, "
sqlQuery1 += "round(t2.tjdbkj/1024,2) as tjdbkj, round(t2.tjsykj/1024,2) as tjsykj, round(t2.tjsykj/t2.tjdbkj*100,0) as tjkjsyl "
sqlQuery1 += "from thwtongji t1 right join thwtongji t2 "
sqlQuery1 += "on t1.popid = t2.upid and t2.popid != 2 and t2.popid != 62 "
sqlQuery1 += "left join vhwethToday t3 "
sqlQuery1 += "on t2.jiedian = t3.sjiedian "
sqlQuery1 += "left join thwsheji t4 "
sqlQuery1 += "on t2.jiedian = t4.jiedian "
sqlQuery1 += "where unix_timestamp(t2.createtime) > unix_timestamp(current_date()) "
sqlQuery1 += "and (unix_timestamp(t1.createtime) > unix_timestamp(current_date()) ||  "
sqlQuery1 += "    t2.popid = '1') "
sqlQuery1 += "order by t2.upid, t4.jdname; "

sqlQuerySum = "select  count(t2.tjdbkj/1024) as hejinum, round(sum(t4.sjjdll),0) as hejiwidth, "
sqlQuerySum += "        round(sum(t3.smaxoutput),0) as hejioutput, round(sum(t3.smaxoutput)/sum(t4.sjjdll)*100,0) as hejioutputper, "
sqlQuerySum += "        sum(t4.sjbf) as hejihmsrl , sum(t2.tjhmssy) as hejihmssy, round(sum(t2.tjhmssy)/sum(t4.sjbf)*100,0) as hejihmssyl, "
sqlQuerySum += "        sum(t4.sjepgbf) as hejiepgrl , sum(t2.tjepgsy) as hejiepgsy, round(sum(t2.tjepgsy)/sum(t4.sjepgbf)*100,0) as hejiepgsyl, "
sqlQuerySum += "        round(sum(t2.tjdbkj/1024),2) as heji, round(sum(t2.tjsykj/1024),2) as kjheji, round(sum(t2.tjsykj)/sum(t2.tjdbkj)*100,0) as kjhejisyl "
sqlQuerySum += "from thwtongji t1 right join thwtongji t2 "
sqlQuerySum += "on t1.popid = t2.upid and t2.popid != 2 and t2.popid != 62 "
sqlQuerySum += "left join vhwethToday t3 "
sqlQuerySum += "on t2.jiedian = t3.sjiedian "
sqlQuerySum += "left join thwsheji t4 "
sqlQuerySum += "on t2.jiedian = t4.jiedian "
sqlQuerySum += "where unix_timestamp(t2.createtime) > unix_timestamp(current_date()) "
sqlQuerySum += "and (unix_timestamp(t1.createtime) > unix_timestamp(current_date()) ||  "
sqlQuerySum += "   t2.popid = '1') "
sqlQuerySum += "group by t2.upid "
sqlQuerySum += "order by t2.upid, t4.jdname; "



title = ['节点','设计带宽(Gbps)','输出带宽(Gbps)','输出带宽占比(%)',
           '流媒体总并发(个)','流媒体峰值并发(个)','流媒体并发率(%)',
        'EPG总并发(个)','EPG峰值并发(个)','EPG并发率(%)',
           '存储总空间(T)','已使用空间(T)','空间使用率(%)', 
           '区域设计带宽(Gbps)','区域输出带宽(Gbps)','区域输出带宽占比(%)',
           '区域流媒体总并发合计(个)','区域流媒体峰值并发合计(个)','区域流媒体并发率(%)',
           '区域EPG总并发合计(个)','区域EPG峰值并发合计(个)','区域EPG并发率(%)',
           '区域空间合计(T)', '区域使用空间合计(T)','区域空间使用率(%)']

zippwd = 'JxP#Q9z'


def getCurrentPath():
    currentPath = os.getcwd()
    return currentPath

def getYesterday():
    yesterday = date.today() - timedelta(days = 1)
    return yesterday

def connectMysql(user=user, host=host, port=port, passwd=pwd, db=db):
    conn = pymysql.connect(host=host, port=port, user=user, passwd=pwd, db=db)
    return conn

def sliceList(L , pos = 1):
    return L[pos:]

def formatHead():
    formathead = workbook.add_format()
    formathead.set_bold(3)
    formathead.set_align('center')
    formathead.set_align('vcenter')
    formathead.set_font_size(20)
    return formathead

def formatTitle():
    formattitle = workbook.add_format()
    formattitle.set_bold(2)
    formattitle.set_border(2)
    formattitle.set_align('center')
    formattitle.set_align('vcenter')
    return formattitle

def formatCell():
    formatcell = workbook.add_format()
    formatcell.set_border(1)
    formatcell.set_align('center')
    formatcell.set_align('vcenter')
    return formatcell

def formatRed():
    '''formatred = workbook.add_format()
    formatred.set_bg_color('red')
    return formatred'''
    #format1 = workbook.add_format({'bg_color': '#FFC7CE',
    #                           'font_color': '#9C0006'})
    formatred = workbook.add_format({'bg_color': '#FFC7CE'})
    return formatred

def formatYellow():
    formatyellow = workbook.add_format({'bg_color': '#FFD700'})
    return formatyellow

def formatWarning(worksheet,  formatR, formatY):
    worksheet.conditional_format('D:D', {
                                            'type':    'cell',
                                            'criteria': '>=',
                                            'value':     90,
                                            'format':    formatR})
    
    worksheet.conditional_format('D:D', {
                                            'type':    'cell',
                                            'criteria': '<',
                                            'value':     20,
                                            'format':    formatY})
def unzipfile(zip_file, output_dir):
    f_zip = zipfile.ZipFile(zip_file, 'r', )

    f_zip.extractall(output_dir, pwd = zippwd.encode('utf-8'))
    for f in f_zip.namelist():
        f_zip.extract(f, os.path.join(output_dir), pwd = zippwd.encode('utf-8'))

def sliceList(L , pos = 1):
    return L[pos:]

try:
    hwzippath = os.getcwd() + '/input/ShangHai_Telecom_Cacti3.0_iptv_check_' + str(getYesterday()) + '.zip'
    print(hwzippath)
    #unzipfile('/home/caixiaoming/workspace/iptvyw/cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
    unzipfile(hwzippath, os.getcwd() +  '/tmp/')
except Exception as e:
    print('unzipfile error',e)
    exit()

try:
    
    #conn = pymysql.connect(host=host, port=port, user=user, passwd=pwd, db=db)
    conn = connectMysql()
    print('conn')
    cur = conn.cursor()
    cur.execute('SET NAMES utf8mb4')
    cur.execute('SET CHARACTER SET utf8mb4')
    cur.execute('SET character_set_connection=utf8mb4')
    workbook = xlsxwriter.Workbook(os.getcwd() + '/output/dRpt/并发日报' +str(getYesterday()) +  '.xlsx')
    worksheet = workbook.add_worksheet('华为并发')
    worksheet.write_row(1, 0, title, formatTitle())
    cur.execute(sqltruncate)
    cur.execute(sqltruncate2)
    conn.commit()
    print('cur.sqltruncate')
    csv_data = csv.reader(open(filepathmdn, encoding=encodes), delimiter = delimiter )  
    next(csv_data)
except Exception as e:
    print('open error',e)
try:   

    print(sqlInsertTmp)
    for row in csv_data:
        cur.execute(sqlInsertTmp, row)                 
    conn.commit()
    


    cur.execute(sqlTmp2thwtongji)
    conn.commit()
    
    csv_data = csv.reader(open(filepathtraffic, encoding=encodes), delimiter = delimiter )  
    next(csv_data)
    for row in csv_data:
        cur.execute(sqlInsertTmpTraffic, row)
    conn.commit()
    print('traffic commit', row)

    cur.execute(sqlTmp2thwethTraffic)
    conn.commit()
    print('sqlTmp2eth' + sqlTmp2thwethTraffic)
    cur.execute(sqlQuery1)
    print('cur.sqlQuery1 ')
    row = 1
    col = 0
    for jiedian, width, output, outputper, tjhmsrl, tjhmssy, tjhmssyl, tjepgrl, tjepgsy, tjepgsyl, tjdbkj, tjsykj, tjkjsyl in cur:
        row += 1
        worksheet.write_row(row, col, [jiedian, width, output, outputper,  
                                       tjhmsrl, tjhmssy, tjhmssyl, tjepgrl, tjepgsy, tjepgsyl, 
                                       tjdbkj, tjsykj, tjkjsyl], formatCell())
        print([jiedian, width, output, outputper,  
                     tjhmsrl, tjhmssy, tjhmssyl, tjepgrl, tjepgsy, tjepgsyl, 
                     tjdbkj, tjsykj, tjkjsyl])
    print('worksheet.write_row done')
    #col += len([jiedian, width, output, outputper, tjhmsrl, tjhmssy, 
    #            tjhmssyl, tjepgrl, tjepgsy, tjepgsyl, tjdbkj, tjsykj, tjkjsyl])
    col += 13
    print(col)
    row = 2
    #nextcol = 0
    cur.execute(sqlQuerySum)
    for hejinum, hejiwidth, hejioutput, hejioutputper, hejihmsrl, hejihmssy, hejihmssyl, hejiepgrl, hejiepgsy, hejiepgsyl, hejikjrl, hejikjsy, hejikjsyl  in cur:
        firstrow = row
        if int(hejinum) == 1:
            worksheet.write_row(firstrow, col, [hejiwidth, hejioutput, hejioutputper, hejihmsrl, hejihmssy, hejihmssyl, hejiepgrl, hejiepgsy, hejiepgsyl, hejikjrl, hejikjsy, hejikjsyl], formatCell())
        else:
            row += int(hejinum) -1
            #nextcol = 0
            for i in range(12):
                #nextcol += col + i
                worksheet.merge_range(firstrow, col + i, row, col + i, '')

        worksheet.write_row(firstrow, col, [hejiwidth, hejioutput, hejioutputper, hejihmsrl, hejihmssy, hejihmssyl, hejiepgrl, hejiepgsy, hejiepgsyl, hejikjrl, hejikjsy, hejikjsyl], formatCell())
        row += 1
    col += len([hejioutput, hejioutputper, hejihmsrl, hejihmssy, hejihmssyl, hejiepgrl, hejiepgsy, hejiepgsyl, hejikjrl, hejikjsy, hejikjsyl])
    print(col)
    worksheet.merge_range(0,0,0, col - 1,'华为日报并发', formatHead())
    worksheet.set_row(0, 30)
    worksheet.set_column(0, col - 1, 20)
    #formatWarning(worksheet, formatRed())
    worksheet.conditional_format('D3:D67', {
                                            'type':    'cell',
                                            'criteria': '>=',
                                            'value':     90,
                                            'format':    formatRed()})
    worksheet.conditional_format('D3:D67', {
                                            'type':    'cell',
                                            'criteria': '<',
                                            'value':     20,
                                            'format':    formatYellow()})
    worksheet.conditional_format('G3:G67', {
                                            'type':    'cell',
                                            'criteria': '>=',
                                            'value':     90,
                                            'format':    formatRed()})
    worksheet.conditional_format('G3:G67', {
                                            'type':    'cell',
                                            'criteria': '<',
                                            'value':     20,
                                            'format':    formatYellow()})
    worksheet.conditional_format('J3:J67', {
                                            'type':    'cell',
                                            'criteria': '>=',
                                            'value':     90,
                                            'format':    formatRed()})
    worksheet.conditional_format('J3:J67', {
                                            'type':    'cell',
                                            'criteria': '<',
                                            'value':     20,
                                            'format':    formatYellow()})
    worksheet.conditional_format('M3:M67', {
                                            'type':    'cell',
                                            'criteria': '>=',
                                            'value':     90,
                                            'format':    formatRed()})
    worksheet.conditional_format('M3:M67', {
                                            'type':    'cell',
                                            'criteria': '<',
                                            'value':     20,
                                            'format':    formatYellow()})
except Exception as e:
    conn.rollback()
    print('Error: ', e)
finally:
    cur.close()
    conn.close()
    workbook.close()



 