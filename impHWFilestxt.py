# -*- coding: utf-8 -*-

import csv,os,pymysql,sys, chardet 


'''
1. open a xls file.
2. read a sheet.
3. read cell or row or col.
4. import mysql temple table.
5. insert mysql normal table.
'''
   
conn = pymysql.connect(host='127.0.0.1', port=3306, user='root', passwd='toor',
db='iptvyw01')

print(sys.getdefaultencoding())
fo = open('/home/caixiaoming/workspace/iptvyw/out_mdn_pop.csv', 'rb')
try:
    cur = conn.cursor()
    cur.execute('TRUNCATE TABLE tmp_thwtongji;')

    flines = fo.readlines()
    #ff1 = csv.reader(tt1)
    
    for fline in flines:
        #print(chardet.detect(ff1)['encoding'])
        print(fline.decode('GB2312'))

except Exception as e:
    print('open error', e)
try:   
    '''
    for fline in flines:
        cur.execute('INSERT INTO tmp_thwtongji(popid, upid, jiedian, tjdbkj, tjsykj, tjkjsyl, tjepgrl, tjepgsy, tjepgsyl, tjhmsrl, tjhmssy, tjhmssyl, tjgfdb, tjgfzb, tjgq, tjbq)' 
                ' VALUES("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s")', fline.decode('GB2312'))
    conn.commit()
    '''
    pass
except Exception as e:
    conn.rollback()
    print('Error: ', e)
    pass
finally:
    fo.close()
    cur.close()
    conn.close()

for row in csv.reader(['one,two,three']):
    print(row)
    
csvfile = open('csv_test.csv', 'w',newline='')

writer = csv.writer(csvfile,delimiter=' ',quotechar='|', quoting=csv.QUOTE_MINIMAL)

writer.writerow(['姓名', '年龄', '电话'])
data = [
     ('小河','25','2343454'),
     ('小芳',18,235365)
]

writer.writerows(data)

csvfile.close()
 