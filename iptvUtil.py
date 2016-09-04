# -*- coding: utf-8 -*-

from datetime import timedelta, date
import zipfile, os, sys, xlsxwriter
from glob import glob

class IptvUtil(object):
    def __init__(self, xlsxfilename, xlsxsheetname):
        self._workbook = xlsxwriter.Workbook(os.getcwd() + xlsxfilename + str(date.today() - timedelta(days = 1)) +  '.xlsx')
        self._worksheet = self._workbook.add_worksheet(xlsxsheetname)
        
    def close(self):
        self._workbook.close()
        
        
    def formatHead(self):
        formathead = self._workbook.add_format()
        formathead.set_bold(3)
        formathead.set_align('center')
        formathead.set_align('vcenter')
        formathead.set_font_size(20)
        return formathead

    def formatTitle(self):
        self._formattitle = self._workbook.add_format()
        self._formattitle.set_bold(2)
        self._formattitle.set_border(2)
        self._formattitle.set_align('center')
        self._formattitle.set_align('vcenter')
        #return self._formattitle

    def formatCell(self):
        formatcell = self._workbook.add_format()
        formatcell.set_border(1)
        formatcell.set_align('center')
        formatcell.set_align('vcenter')
        return formatcell
    
    def formatRed(self):
        formatred = self._workbook.add_format({'bg_color': '#FFC7CE'})
        return formatred
    
    def formatYellow(self):
        formatyellow = self._workbook.add_format({'bg_color': '#FFD700'})
        return formatyellow
    
    def formatColwidth(self, col, head, formatH):
        self._worksheet.merge_range(0,0,0, col - 1,head, formatH)
        self._worksheet.set_row(0, 30)
        self._worksheet.set_column(0, col - 1, 20)
    
    def formatConditional(self, rowcol, criteria, value, formatColor):
        self._worksheet.conditional_format(rowcol, {
                                            'type':    'cell',
                                            'criteria': criteria,
                                            'value':     value,
                                            'format':    formatColor})

    def writerow(self, row, col, celltext):
        self._worksheet.write_row(row, col, celltext, self.formatCell())
        
    def mergerange(self, row1, col1, row2, col2):
        self._worksheet.merge_range(row1, col1, row2, col2, '')
        
    def calc(self, numbers):
        sum = 0
        for n in numbers:
            sum += n*n
        return sum

    def getYesterday(self, minusDay = 1):
        yesterday = date.today() - timedelta(days = minusDay)
        return yesterday

    def sliceList(self, L , pos = 1):
        return L[pos:]
    #password = 'JxP#Q9z'
    def search_file(self, file_name, search_path, pathsep = os.pathsep):
#         print(search_path)
#         print(search_path.split(pathsep)) 
#         for path in search_path.split(pathsep): 
#  
#             print(os.pathsep)
#             print(path)
#             print(file_name)
#             candidate = os.path.join(path, file_name) 
#             print(str(candidate))
#             if os.path.isfile(candidate): 
#                 return os.path.abspath(candidate) 
#         return None

        for path in search_path.split(os.pathsep):
            print('match1' + file_name)
            for match in glob(os.path.join(path, str(file_name))):
                print('match ' + match)
                if match:
                    return match
            return None


    def findfile(self, start, name):
        pass
    
    def unzipfile(self, zip_file, output_dir, password=None):
        f_zip = zipfile.ZipFile(zip_file, 'r', )
        if password is None:
            '''
                      替换压缩文件中的文件名，绕过解压缩乱码问题。
                      属于硬编码，临时解决方法，还要改进。
                  '''
            filename = ''.join(zip_file.split('/')[-1]).split('.')[0] + '.csv'
            for file_info in f_zip.infolist():
                open(output_dir + filename, 'wb').write(f_zip.read(file_info.filename))
        else:
            f_zip.extractall(output_dir, pwd = password.encode('utf-8'))
            for f in f_zip.namelist():
                f_zip.extract(f, os.path.join(output_dir), pwd = password.encode('utf-8'))


if __name__ == "__main__":
#    print(calc([1,2,3]))
    util = IptvUtil('/output/dRpt/中兴并发日报', '中兴并发')
    s = str(util.getYesterday(0)).replace('-','')
    
    print(s)
#     
#     print(sliceList( ['1', '2', '3', '4', '5'], 2))
#     
#     try:
#         #unzipfile('/home/caixiaoming/workspace/iptvyw/cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#         unzipfile('./cacti/ShangHai_Telecom_Cacti3.0_iptv_check_2016-03-31.zip', './2016-03-31/')
#     except Exception as e:
#         print('unzipfile error',e)
        
        
