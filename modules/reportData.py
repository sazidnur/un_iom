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
