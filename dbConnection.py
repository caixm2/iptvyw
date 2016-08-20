#!/usr/local/bin/python3
# -*- coding: utf-8 -*-

import csv,os,pymysql,sys, xlsxwriter,zipfile
from datetime import timedelta, date

version = '1.0'
def modelName():
    return __name__

class MysqlConn(object):
    host = '127.0.0.1'
    port = 3306
    user = 'caixiaoming'
    pwd = 'toor'
    db = 'iptvyw01'
    def __init__(self):
        self._conn = pymysql.connect(host=self.host, port=self.port, user=self.user, passwd=self.pwd, db=self.db)
           # 很重要的一行代码
        self._conn.set_charset('utf8')
        self._cursor = self._conn.cursor()
        self._cursor.execute('SET NAMES utf8mb4')
        self._cursor.execute('SET CHARACTER SET utf8mb4')
        self._cursor.execute('SET character_set_connection=utf8mb4')
        print(sys.getdefaultencoding())

    def insertOne(self, sql, value=None):
        if value is None:
            self._cursor.execute(sql)
        else:
            self._cursor.execute(sql, value)

        #return count

    def getAll(self, sql, param=None):
        if param is None:
            count = self._cursor.execute(sql)
        else:
            count = self._cursor.execute(sql, param)
#         if count > 0:
#             result = self._cursor.fetchall()
#         else:
#             resutl = False
        return count
    
    def getProcAll(self, proc):

        result = self._cursor.callproc(proc)

        return result
    
    def printInfo(self):
        print('调用方法')
        
    def commit(self):
        self._conn.commit()
    
    def rollback(self):
        self._conn.rollback()
            
    def close(self):
        self._cursor.close()
        self._conn.close()
    
if __name__ == "__main__":
    mysql = MysqlConn()
    #result = mysql.getAll('call p1()')
    result = mysql.getAll('select * from thwsheji')
    mysql.printInfo()
    print(len(result))
    print(result[0])
    
    print(__name__)
    
    
    
        