import os
import pandas as pd
import numpy as np
import time
import json
from modules import reportData
#import main

report= reportData.DataClass()
#mainClass = MainWindow()
class DataClass:
    df = pd.DataFrame()
    data = dict()
    report = dict()
    def saveFileData(self, path):
        try:
            self.df = pd.read_excel(path, engine='openpyxl')
            return True
        except:
            return False


    def checkFilePath(self, path):
        if os.path.isfile(path):
            print("file okay")
            return True
        else:
            return False

    def checkExcelFile(self, path):
        print(path)
        try:
            df = pd.read_excel(path, engine='openpyxl')
            return True
        except:
            return False

    def setLastFolderLocation(self):
        pass

    def getLastFolderLocation(self):
        return "null"

    def process(self):
        if self.df.columns[0] != 'SL':
#            print("ssssssssssssss")
            return False
        reachable = 0
        male = 0
        female = 0
        agelist = dict()
        district = dict()
        country = dict()
        for row in range(len(self.df)):
            self.data[self.df.iloc[row, 1]] = {}
            r_count = 0
#            print(self.df.iloc[row, 1])
            for col in range(0, 29):
                if self.df.columns[col] == 'Age ':
                    try:
                        self.data[self.df.iloc[row, 1]][self.df.columns[col]] = int(self.df.iloc[row, col].split(' ')[0])
                    except:
                        self.data[self.df.iloc[row, 1]][self.df.columns[col]] = -1

                    if self.data[self.df.iloc[row, 1]][self.df.columns[col]] == -1:
                        if "Not Given" in agelist.keys():
                            agelist["Not Given"] += 1
                        else:
                            agelist["Not Given"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=0 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<18:
                        if "0-17" in agelist.keys():
                            agelist["0-17"] += 1
                        else:
                            agelist["0-17"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=18 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=25:
                        if "18-25" in agelist.keys():
                            agelist["18-25"] += 1
                        else:
                            agelist["18-25"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=26 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=30:
                        if "26-30" in agelist.keys():
                            agelist["26-30"] += 1
                        else:
                            agelist["26-30"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=31 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=35:
                        if "31-35" in agelist.keys():
                            agelist["31-35"] += 1
                        else:
                            agelist["31-35"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=36 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=40:
                        if "36-40" in agelist.keys():
                            agelist["36-40"] += 1
                        else:
                            agelist["36-40"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=41 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=45:
                        if "41-45" in agelist.keys():
                            agelist["41-45"] += 1
                        else:
                            agelist["41-45"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=46 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=50:
                        if "46-50" in agelist.keys():
                            agelist["46-50"] += 1
                        else:
                            agelist["46-50"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=51 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=55:
                        if "51-55" in agelist.keys():
                            agelist["51-55"] += 1
                        else:
                            agelist["51-55"] = 1
                    elif self.data[self.df.iloc[row, 1]][self.df.columns[col]] >=56 and self.data[self.df.iloc[row, 1]][self.df.columns[col]]<=60:
                        if "55-60" in agelist.keys():
                            agelist["55-60"] += 1
                        else:
                            agelist["55-60"] = 1
                    else:
                        if "60+" in agelist.keys():
                            agelist["60+"] += 1
                        else:
                            agelist["60+"] = 1

                elif self.df.columns[col] == 'SL':
                    self.data[self.df.iloc[row, 1]][self.df.columns[col]] = int(self.df.iloc[row, col])
                else:
                    self.data[self.df.iloc[row, 1]][self.df.columns[col]] = str(self.df.iloc[row, col])

                if self.df.columns[col] == 'Contact no. 1 working? (Yes/No)' or self.df.columns[col] == 'Contact no. 2 working? (Yes/No)':
                    if str(self.df.iloc[row, col]) != 'nan':
                        r_count += 1
                if self.df.columns[col] == 'Gender':
                    if str(self.df.iloc[row, col]) == 'M':
                        male += 1
                    else:
                        female += 1
                if self.df.columns[col] == 'District':
                    if str(self.df.iloc[row, col]) in district.keys():
                        district[str(self.df.iloc[row, col])] += 1
                    else:
                        district[str(self.df.iloc[row, col])] = 1

                if self.df.columns[col] == 'Country of Return':
                    if str(self.df.iloc[row, col]) == 'Libya ':
                        self.df.iloc[row, col] = "Libya"
                    if str(self.df.iloc[row, col]) == 'nan':
                        self.df.iloc[row, col] = "Not Given"
                    if str(self.df.iloc[row, col]) == 'Country of Return':
                        self.df.iloc[row, col] = "Not Given"
                    if str(self.df.iloc[row, col]) in country.keys():
                        country[str(self.df.iloc[row, col])] += 1
                    else:
                        country[str(self.df.iloc[row, col])] = 1
            if r_count > 0:
                reachable += 1
#        print(self.data["BD_BBR_0003"])
        self.report["reachable"] = reachable
        self.report["unreachable"] = len(self.df) - reachable
        self.report["male"] = male
        self.report["female"] = female
        self.report["agelist"] = agelist
        self.report["district"] = district
        self.report["country"] = country

        report.updateFileCnt()
        report.updatePeople(len(self.df))

#        print(self.report["reachable"])
#        print(self.report["unreachable"])

        try:
            with open("data.json", "w") as outfile:
                json.dump(self.data, outfile)
        except:
            return False

        with open("report.json", "w") as outfile:
            json.dump(self.report, outfile)

        return True
