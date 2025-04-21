from RecordReader import read_technical_records_from_excel
from appiumTableHelper import *     #search_row

alldata = read_technical_records_from_excel("../Data/Tables/dlgProfil_pagAbwesenheiten_tabAbwesenheiten.xlsx", "Abwesenheit Sylvester", "Pixel9Pro_API35", False)
print(alldata)
#print(search_row("//android.widget.GridView", 0, alldata))
#print(search_row("//android.widget.GridView", 1, alldata))
print(delete_row("//android.widget.GridView", alldata))

