import os
import pandas as pd
import numpy as np
import time
import json

class DataClass:

    reach = 0
    unreach = 0
    check = str()
    def load(self):
        with open("report.json", "r") as outfile:
            data = json.load(outfile)
            self.check = json.dumps(data)
        self.reach = data['reachable']
        self.unreach = data['unreachable']
    def getReachable(self):
        self.load()
        return self.reach, self.unreach

    def getData(self):
        return self.check

    def updatePeople(self, value):
        with open("static.json", "r") as outfile:
            temp = json.load(outfile)
        temp["people"] = str(value)
        with open("static.json", "w") as outfile:
            json.dump(temp, outfile)

    def updateSearchCnt(self):
        with open("static.json", "r") as outfile:
            temp = json.load(outfile)
        temp["searchCnt"] = str(int(temp["searchCnt"]) + 1)
        with open("static.json", "w") as outfile:
            json.dump(temp, outfile)

    def updateFileCnt(self):
        with open("static.json", "r") as outfile:
            temp = json.load(outfile)
        temp["fileCnt"] = str(int(temp["fileCnt"]) + 1)
        with open("static.json", "w") as outfile:
            json.dump(temp, outfile)


    def getStatic(self):
        temp = str()
        with open("static.json", "r") as outfile:
            data = json.load(outfile)
            temp = json.dumps(data)

#        print(temp[0])
        return temp
