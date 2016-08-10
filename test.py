# -*- coding: utf-8 -*-

from datetime import timedelta, date
import zipfile, os

def calc(numbers):
    sum = 0
    for n in numbers:
        sum += n*n
    return sum

def getYesterday():
    yesterday = date.today() - timedelta(days = 1)
    return yesterday

def getCurrentPath():
    currentPath = os.getcwd()
    return currentPath

def sliceList(L , pos = 1):

    return L[pos:]
password = 'JxP#Q9z'
def unzipfile(zip_file, output_dir):
    f_zip = zipfile.ZipFile(zip_file, 'r', )

    f_zip.extractall(output_dir, pwd = password.encode('utf-8'))
    for f in f_zip.namelist():
        f_zip.extract(f, os.path.join(output_dir, 'bak'), pwd = password.encode('utf-8'))


if __name__ == "__main__":
    print(calc([1,2,3]))
    
    print(getYesterday())
    
    print(sliceList( ['1', '2', '3', '4', '5'], 2))
    
#     try:
#         #unzipfile('/home/caixiaoming/workspace/iptvyw/cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#         unzipfile('./cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#     except Exception as e:
#         print('unzipfile error',e)
    print(getCurrentPath())
        
        