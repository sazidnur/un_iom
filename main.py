# This Python file uses the following encoding: utf-8
import numpy as np
import os
from pathlib import Path
import sys
import time
import datetime
import random

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCharts import QtCharts
from PySide2 import QtCore, QtGui, QtWidgets, QtQml
from PySide2.QtWidgets import *
from PySide2.QtCore import QObject, Slot, Signal, QTimer

from modules import processData, reportData

data = processData.DataClass()
report= reportData.DataClass()

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)

        # QTimer - Run Timer
        self.timer = QTimer()
        self.timer2 = QTimer()
        self.timer.timeout.connect(lambda: self.setTime())
        self.timer2.timeout.connect(lambda: self.reachable())
        self.timer2.timeout.connect(lambda: self.frontendData())
        self.timer2.timeout.connect(lambda: self.staticData())
        self.timer.start(1000)
        self.timer2.start(1000)
#        self.reachable()

    printTime = Signal(str)
    setCheckValidExcelFile = Signal(bool)
    setCheckValidFilePath = Signal(bool)
    setSaveExcelFileData = Signal(bool)
    getLastLocationOfFolder = Signal(str)
    setProcessData = Signal(bool)
    setRefreshData = Signal(int, int)
    setFrontendData = Signal(str)
    setStaticData = Signal(str)

    def setTime(self):
        now = datetime.datetime.now()
        fomatdate = now.strftime("%A, %I:%M:%S %p, %d-%b-%Y")
        self.printTime.emit(fomatdate)

    @Slot()
    def staticData(self):
#        print(report.getStatic())
        data = report.getStatic()
        self.setStaticData.emit(data)

    @Slot(str)
    def checkValidExcelFile(self, path):
        self.setCheckValidExcelFile.emit(data.checkExcelFile(path))

    @Slot(str)
    def checkValidFilePath(self, path):
        self.setCheckValidFilePath.emit(data.checkFilePath(path))

    @Slot(str)
    def saveExcelFileData(self, path):
        self.setSaveExcelFileData.emit(data.saveFileData(path))

    @Slot()
    def checkLastLoacationOfFolder(self):
        self.getLastLocationOfFolder.emit(data.getLastFolderLocation())

    @Slot()
    def saveLastLocationOfFolder(self, path):
        self.getLastLocationOfFolder.emit(data.setLastFolderLocation(path))

    @Slot()
    def processData(self):
        self.setProcessData.emit(data.process())

    @Slot()
    def updateSearchCount(self):
        report.updateSearchCnt()

    @Slot()
    def reachable(self):
#        print("foundffffffffffffffffffffffffffffffffffffffffffffffffffffff")
#        self.setRefreshData.emit(random.randint(50,100), random.randint(1,49))
        a, b = report.getReachable()
#        print(a, b)
        self.setRefreshData.emit(a, b)

    @Slot()
    def frontendData(self):
        data = report.getData()
#        print(data)
        self.setFrontendData.emit(data)


if __name__ == "__main__":
#    app = QGuiApplication(sys.argv)
    app = QApplication([])
    engine = QQmlApplicationEngine()

    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)

    app.setOrganizationName("UN IMO Bangladesh");
    app.setOrganizationDomain("un.com");
    app.setApplicationName("QPack");
#    chart = QtCharts
#    ff()
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
#    print(appContainer.text().toStr())
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

#    def ff(self):
#        print(self.appContainer.text().toStr())























































import requests
import bs4
import xlsxwriter
import time

# user list
user_list_api = "https://codeforces.com/api/user.ratedList"

ulistdata = requests.get(user_list_api)
ulistdata = ulistdata.json()
user = list()
vuser = list()
flag = 0
wb = xlsxwriter.Workbook('data2.xlsx')
ws = wb.add_worksheet()
ws.write('A1', 'handle')
ws.write('B1', 'country')
ws.write('C1', 'currentRating')
ws.write('D1', 'maxRating')
ws.write('E1', 'problemSolved')
ws.write('F1', 'contestCount')
ws.write('G1', 'AvgRatOfLst20Con')
count = 1
for letter in range (72, 72+30):
    temp = letter
    if temp>90:
        temp-=90
        temp+=64
        let = 'A'+chr(temp)+'1'
        des = str(count)+"_ConrRatFrmLast"
        print(let, des)
        ws.write(let, des)
    else:
        let = chr(temp) + '1'
        des = str(count) + "_ConRatFrmLast"
        print(let, des)
        ws.write(let, des)
    count += 1

wbbd = xlsxwriter.Workbook('data_bd2.xlsx')
wsbd = wbbd.add_worksheet()
wsbd.write('A1', 'handle')
wsbd.write('B1', 'country')
wsbd.write('C1', 'currentRating')
wsbd.write('D1', 'maxRating')
wsbd.write('E1', 'problemSolved')
wsbd.write('F1', 'contestCount')
wsbd.write('G1', 'AvgRatOfLst20Con')
bdcount = 1
for letter in range (72, 72+30):
    temp = letter
    if temp>90:
        temp-=90
        temp+=64
        let = 'A'+chr(temp)+'1'
        des = str(bdcount)+"_ConRatFrmLast"
        print(let, des)
        ws.write(let, des)
    else:
        let = chr(temp) + '1'
        des = str(bdcount) + "_ConRatFrmLast"
        print(let, des)
        ws.write(let, des)
    bdcount += 1

row = 2
bdrow = 2
skipped = 0
# handle, country, rating, maxRating, contestCount, lastTwentyContestAvg, solvedProblemCount, contestRating
for idx in ulistdata['result']:
    # if flag == 5:
    #     break
    if idx["rating"] >= 1200: # user's handle list who has atleat 1200 rating
        # print(idx['handle'])
        # user.append()
        contest_List_Api = "https://codeforces.com/api/user.rating?handle="
        contest_List_Api += str(idx['handle'])
        try:
            # time.sleep(1)
            contest_List_data = requests.get(contest_List_Api)
            contest_List_data = contest_List_data.json()
        except:
            time.sleep(3)
            try:
                contest_List_data = requests.get(contest_List_Api)
                contest_List_data = contest_List_data.json()
            except:
                skipped += 1
                print("\nskipped for api ", skipped)
                continue

        if len(contest_List_data['result']) >= 35: # user who has atleast 1200 rating and perticipate atleast 30 contest
            # user.append(idx['handle'])
            flag += 1
            handle = idx['handle']
            try:
                country = idx['country']
            except:
                country = "Not Specified"
            rating = idx['rating']
            maxRating = idx['maxRating']
            contestCount = len(contest_List_data['result'])
            contestRating = list()
            ratingSum = 0
            for contest in range(1, 31):
                # print(contest_List_data["result"][len(contest_List_data["result"])-contest], contest)
                contestRating.append(contest_List_data["result"][len(contest_List_data["result"])-contest]['newRating'])
                ratingSum += contest_List_data["result"][len(contest_List_data["result"])-contest]['newRating']

            ratingAvg = int(ratingSum/30)

            user_profile_link = "https://codeforces.com/profile/"
            try:
                data = requests.get(user_profile_link+idx['handle'])
                soup = bs4.BeautifulSoup(data.text, "lxml")
                soup = soup.find_all('div', attrs={'class': '_UserActivityFrame_counterValue'})
                soup = str(soup[0]).split('>')
                soup = str(soup[1]).split(" ")

                problemSolved = soup[0]
            except:
                time.sleep(3)
                try:
                    data = requests.get(user_profile_link + idx['handle'])
                    soup = bs4.BeautifulSoup(data.text, "lxml")
                    soup = soup.find_all('div', attrs={'class': '_UserActivityFrame_counterValue'})
                    soup = str(soup[0]).split('>')
                    soup = str(soup[1]).split(" ")

                    problemSolved = soup[0]
                except:
                    skipped += 1
                    print("\nskipped for loading page ", skipped)
                    continue
            # print(soup[0])

            print(handle, country, rating, maxRating, ratingAvg, problemSolved, contestCount, contestRating)

            # wb = xlsxwriter.Workbook('hello.xlsx')
            # ws = wb.add_worksheet()

            ws.write('A'+str(row), str(handle))
            ws.write('B'+str(row), str(country))
            ws.write('C'+str(row), str(rating))
            ws.write('D'+str(row), str(maxRating))
            ws.write('E'+str(row), str(problemSolved))
            ws.write('F'+str(row), str(contestCount))
            ws.write('G'+str(row), str(ratingAvg))

            cnt = 1
            for letter in range (72, 72+30):
                temp = letter
                if temp>90:
                    temp-=90
                    temp+=64
                    let = 'A'+chr(temp) + str(row)
                    des = str(contestRating[cnt-1])
                    # print(let, des)
                    ws.write(let, des)
                else:
                    let = chr(temp) + str(row)
                    des = str(contestRating[cnt-1])
                    # print(let, des)
                    ws.write(let, des)
                cnt += 1
            # wb.close()
            row += 1

            if country == "Bangladesh":
                wsbd.write('A' + str(bdrow), str(handle))
                wsbd.write('B' + str(bdrow), str(country))
                wsbd.write('C' + str(bdrow), str(rating))
                wsbd.write('D' + str(bdrow), str(maxRating))
                wsbd.write('E' + str(bdrow), str(problemSolved))
                wsbd.write('F' + str(bdrow), str(contestCount))
                wsbd.write('G' + str(bdrow), str(ratingAvg))

                cntbd = 1
                for letter in range(72, 72 + 30):
                    temp = letter
                    if temp > 90:
                        temp -= 90
                        temp += 64
                        let = 'A' + chr(temp) + str(bdrow)
                        des = str(contestRating[cntbd - 1])
                        # print(let, des)
                        ws.write(let, des)
                    else:
                        let = chr(temp) + str(bdrow)
                        des = str(contestRating[cntbd - 1])
                        # print(let, des)
                        ws.write(let, des)
                    cntbd += 1
                # wb.close()
                bdrow += 1

wb.close()
wbbd.close()


# print(user)




