# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCharts import QtCharts
from PySide2 import QtCore, QtGui, QtWidgets, QtQml
from PySide2.QtWidgets import *


if __name__ == "__main__":
#    app = QGuiApplication(sys.argv)
    app = QApplication([])
    engine = QQmlApplicationEngine()
#    chart = QtCharts
#    ff()
    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
#    print(appContainer.text().toStr())
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())

#    def ff(self):
#        print(self.appContainer.text().toStr())

