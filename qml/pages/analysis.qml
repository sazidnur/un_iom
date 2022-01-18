import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
//import Qt.labs.platform 1.1
import "../controls"
import QtCharts 2.3

Item {

    Rectangle{
        id: analysisBg
        color: "#F8FBFF"
        anchors.fill: parent

        ChartView {
            id: agebar
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: {
                if(analysisBg.width>1350) return 50;
                else return 20;
            }

            anchors.leftMargin: 20
            width: analysisBg.width/1.75
            height: analysisBg.height/2.5

            legend.alignment: Qt.AlignTop
            BarSeries {
                name: "BarSeries"
                axisX: BarCategoryAxis {
                    id: ageCat
                    categories: []
                }
                BarSet {
                    id: agebarset
                    values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 150]
                    label: "Age vs Migrant Bar Chart"
                }
            }

        }
        ChartView {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.leftMargin: 20
            anchors.topMargin: {
                if(analysisBg.width>1350) return 50;
                else return 20;
            }
            anchors.rightMargin: 20

            height: analysisBg.height/2.5
            anchors.left: agebar.right

            //                    theme: ChartView.ChartThemeQt
            PieSeries {
                id: pieSeries
                PieSlice {
                    id: reach;
                    label: "Reachable";
                    value: 0
                }
                PieSlice { id: unreach; label: "Unreachable"; value: 0 }
            }
        }
        ChartView {
            id: distbar
            anchors.left: parent.left
            anchors.right: countrybar.left
            anchors.top: agebar.bottom
            anchors.rightMargin: 20
            anchors.topMargin: 50
            anchors.leftMargin: 20
            height: analysisBg.height/2.5
            width: analysisBg.width/1.5
            legend.alignment: Qt.AlignTop
            BarSeries {
                name: "BarSeries"
                axisX: BarCategoryAxis {
                    id: distbarcat
                    categories: []
                }
                BarSet {
                    id: distbarcnt
                    values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 100]
                    label: "Most Vurnable District"
                    color: "green"
                }
            }

        }
        ChartView {
            id: countrybar
            anchors.right: parent.right
            anchors.top: agebar.bottom
            anchors.leftMargin: 20
            anchors.topMargin: 50
            anchors.rightMargin: 20
            width: analysisBg.width/2.5
            height: analysisBg.height/2.5

            legend.alignment: Qt.AlignTop
            BarSeries {
                name: "BarSeries"
                axisX: BarCategoryAxis {
                    id: countrybarcat
                    categories: []
                }
                BarSet {
                    id: countrybarcnt
                    values: [0, 0, 0, 0, 0, 0, 0, 0, 0, 600]
                    label: "Most Vurnable Return Country"
                    color: "orange"
                }
            }

        }

    }
    Connections{
        target: backend

        function onSetFrontendData(json_string){
            const data = JSON.parse(json_string)
            var agec = []
            var agecnt = []
            var distc = []
            var distcnt = []
            var countryc = []
            var countrycnt = []

            const orderedAge = Object.keys(data.agelist).sort().reduce(
              (obj, key) => {
                obj[key] = data.agelist[key];
                return obj;
              },
              {}
            );
            for (var key in orderedAge) {
                agec.push(key)
                agecnt.push(orderedAge[key])
            }

            const orderedDist = Object.keys(data.district).sort().reduce(
              (obj, key) => {
                obj[key] = data.district[key];
                return obj;
              },
              {}
            );
            for (key in orderedDist) {
                distc.push(key)
                distcnt.push(orderedDist[key])
                if(distc.length ==10 ) break;
            }

            const orderedCountry = Object.keys(data.country).sort().reduce(
              (obj, key) => {
                obj[key] = data.country[key];
                return obj;
              },
              {}
            );
            for (key in orderedCountry) {
                countryc.push(key)
                countrycnt.push(orderedCountry[key])
                if(countryc.length ==10 ) break;
            }
            ageCat.categories = agec
            agebarset.values = agecnt
            reach.value = data.reachable
            unreach.value = data.unreachable
            distbarcat.categories = distc
            distbarcnt.values = distcnt
            countrybarcat.categories = countryc
            countrybarcnt.values = countrycnt
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}D{i:6}D{i:10}
}
##^##*/
