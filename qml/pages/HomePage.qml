import QtQuick 2.0
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15
import QtCharts 2.3
import "../controls"
import "../../js/QMLChartData.js" as ChartsData
import "../../js/QChartJsTypes.js" as ChartTypes
import "../../js/Chart.js" as Chart

Item {

//    property int chart_width: dashChartBg.width
//    property int chart_height: dashChartBg.height

    Rectangle {
        id: homePageContent
        color: "#f8fbff"
        anchors.fill: parent

        Rectangle {
            id: dashBoxContainer
            height: 110
            Layout.maximumWidth: 1200
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin:{
                if(homePageContent.width>1300) return 160
                else if(homePageContent.width>1000) return 130
                else return 100
            }

            anchors.leftMargin: {
                if(homePageContent.width>1300) return 160
                else if(homePageContent.width>1000) return 130
                else return 100
            }
            anchors.topMargin: {
                if(homePageContent.width>1300) return 65
                else if(homePageContent.width>1000) return 40
                else return 30
            }

            GridLayout {
                id: dashBoxGrid
                height: 110
                anchors.fill: parent
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                columnSpacing: 30
                rowSpacing: 0
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                rows: 1
                columns: 3

                Rectangle {
                    id: dashBoxLeft
                    Layout.maximumWidth: 350
                    Layout.fillWidth: true
                    width: 200
                    height: 90
                    color: "#990033a0"
                    radius: 5
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.maximumHeight: 90

                    Image {
                        id: leftBoxImg
                        source: "../../images/svg/home_icon.svg"
                        anchors.leftMargin:{
                            if(dashBoxLeft.width>300) return 55
                            else if(dashBoxLeft.width>250) return 35
                            else return 10
                        }

                        anchors.bottomMargin: 30
                        sourceSize.height: 25
                        sourceSize.width: 25
                        height: 25
                        width: 25
                        fillMode: Image.PreserveAspectFit
                        visible: true
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                    }

                    ColorOverlay{
                        anchors.fill: leftBoxImg
                        source: leftBoxImg
                        color: "#ffffff"
                        antialiasing: false
                    }

                    Label {
                        id: leftBoxbar
                        y: 19
                        color: "#ffffff"
                        text: qsTr("|")
                        anchors.left: leftBoxImg.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.family: "Times New Roman"
                        font.weight: Font.Thin
                        font.pointSize: 35
                    }

                    Label {
                        id: leftBoxdescription
                        y: 50
                        color: "#ffffff"
                        text: qsTr("People's Data")
                        anchors.left: leftBoxbar.right
                        anchors.bottom: leftBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: -50
                        anchors.leftMargin: 15
                        font.pointSize: 10
                    }

                    Label {
                        id: leftBoxnumber
                        y: 30
                        color: "#ffffff"
                        text: qsTr("181")
                        anchors.left: leftBoxbar.right
                        anchors.bottom: leftBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.pointSize: 12
                        anchors.bottomMargin: -30
                    }
                }

                Rectangle {
                    id: dashBoxMid
                    Layout.maximumWidth: 350
                    Layout.fillWidth: true
                    width: 200
                    height: 90
                    color: "#ccef5350"
                    radius: 5
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.maximumHeight: 90

                    Image {
                        id: midBoxImg
                        source: "../../images/svg/open_icon.svg"
                        anchors.leftMargin:{
                            if(dashBoxMid.width>300) return 55
                            else if(dashBoxMid.width>250) return 35
                            else return 10
                        }

                        anchors.bottomMargin: 30
                        sourceSize.height: 25
                        sourceSize.width: 25
                        height: 25
                        width: 25
                        fillMode: Image.PreserveAspectFit
                        visible: true
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                    }

                    ColorOverlay{
                        anchors.fill: midBoxImg
                        source: midBoxImg
                        color: "#ffffff"
                        antialiasing: false
                    }

                    Label {
                        id: midBoxbar
                        y: 19
                        color: "#ffffff"
                        text: qsTr("|")
                        anchors.left: midBoxImg.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.family: "Times New Roman"
                        font.weight: Font.Thin
                        font.pointSize: 35
                    }

                    Label {
                        id: midBoxdescription
                        y: 50
                        color: "#ffffff"
                        text: qsTr("File Uploaded")
                        anchors.left: midBoxbar.right
                        anchors.bottom: midBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: -50
                        anchors.leftMargin: 15
                        font.pointSize: 10
                    }

                    Label {
                        id: midBoxnumber
                        y: 30
                        color: "#ffffff"
                        text: qsTr("35")
                        anchors.left: midBoxbar.right
                        anchors.bottom: midBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.pointSize: 12
                        anchors.bottomMargin: -30
                    }
                }

                Rectangle {
                    id: dashBoxRight
                    Layout.maximumWidth: 350
                    Layout.fillWidth: true
                    width: 200
                    height: 90
                    color: "#f26ab187"
                    radius: 5
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.maximumHeight: 90

                    Image {
                        id: rightBoxImg
                        source: "../../images/svg/settings_icon.svg"
                        anchors.leftMargin:{
                            if(dashBoxRight.width>300) return 55
                            else if(dashBoxRight.width>250) return 35
                            else return 10
                        }

                        anchors.bottomMargin: 30
                        sourceSize.height: 25
                        sourceSize.width: 25
                        height: 25
                        width: 25
                        fillMode: Image.PreserveAspectFit
                        visible: true
                        anchors.left: parent.left
                        anchors.bottom: parent.bottom
                    }

                    ColorOverlay{
                        anchors.fill: rightBoxImg
                        source: rightBoxImg
                        color: "#ffffff"
                        antialiasing: false
                    }

                    Label {
                        id: rightBoxbar
                        y: 19
                        color: "#ffffff"
                        text: qsTr("|")
                        anchors.left: rightBoxImg.right
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.family: "Times New Roman"
                        font.weight: Font.Thin
                        font.pointSize: 35
                    }

                    Label {
                        id: rightBoxDescription
                        y: 50
                        color: "#ffffff"
                        text: qsTr("Search Done")
                        anchors.left: rightBoxbar.right
                        anchors.bottom: rightBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: -50
                        anchors.leftMargin: 15
                        font.pointSize: 10
                    }

                    Label {
                        id: rightBoxnumber
                        y: 30
                        color: "#ffffff"
                        text: qsTr("346")
                        anchors.left: rightBoxbar.right
                        anchors.bottom: rightBoxbar.top
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors.leftMargin: 15
                        font.pointSize: 12
                        anchors.bottomMargin: -30
                    }
                }
            }
        }

        Rectangle {
            id: searchBarBackground
            height: 70
            color: "#f8fbff"
            radius: 10
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: dashBoxContainer.bottom
            anchors.rightMargin: 50
            anchors.leftMargin: 50
            anchors.topMargin: {
                if(homePageContent.width>1300) return 30
                else if(homePageContent.width>1000) return 25
                else return 20
            }

            GridLayout {
                id: dashSearchGrid
                anchors.fill: parent
                anchors.rightMargin: {
                    if(homePageContent.width>1300) return 130
                    else if(homePageContent.width>1000) return 100
                    else return 10
                }
                anchors.leftMargin: {
                    if(homePageContent.width>1300) return 130
                    else if(homePageContent.width>1000) return 100
                    else return 10
                }
                rows: 1
                columns: 3

                CustomSearchBar{
                    id: textField
                    Layout.maximumWidth: 65535
                    placeholderText: "Search by id..."
                    Layout.fillWidth: true
                    Keys.onEnterPressed: {
                        backend.welcomeText(textField.text)
                    }
                    Keys.onReturnPressed: {
                        backend.welcomeText(textField.text)
                    }
                }

                CustomButton{
                    id: btnChangeName
                    text: "Search"
                    Layout.maximumWidth: 200
                    Layout.fillWidth: true
                    Layout.preferredWidth: 50
                    Layout.preferredHeight: 40
                    onClicked: {
                        backend.welcomeText(textField.text)
                    }
                }
            }
        }

        Rectangle {
            id: dashChartBg
            Layout.maximumWidth: 1100
            color: "#00000000"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: searchBarBackground.bottom
            anchors.bottom: parent.bottom
            anchors.bottomMargin: {
                if(homePageContent.width>1300) return 125
                else if(homePageContent.width>1000) return 60
                else return 20
            }
            anchors.topMargin: {
                if(homePageContent.width>1300) return 125
                else if(homePageContent.width>1000) return 60
                else return 30
            }
            anchors.rightMargin:{
                if(homePageContent.width>1300) return 160
                else if(homePageContent.width>1000) return 75
                else return 30
            }

            anchors.leftMargin: {
                if(homePageContent.width>1300) return 160
                else if(homePageContent.width>1000) return 75
                else return 30
            }

            GridLayout {
                id: gridLayout
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                rows: 1
                columns: 3

                ChartView {
                    id: bar1
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: parent.width*(2/3)
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    theme: ChartView.ChartThemeQt
                    BarSeries {
                        name: "BarSeries"
                        BarSet {
                            values: [2, 2, 3]
                            label: "Set1"
                        }

                        BarSet {
                            values: [5, 1, 2]
                            label: "Set2"
                        }

                        BarSet {
                            values: [3, 5, 8]
                            label: "Set3"
                        }
                    }
                }
//                ChartView {
//                    id: bar2
//                    anchors.left: parent.left
//                    anchors.right: parent.right
//                    anchors.top: parent.top
//                    anchors.bottom: parent.bottom
//                    anchors.rightMargin: parent.width * (1/3)
//                    anchors.leftMargin: parent.width * (1/3)
//                    anchors.bottomMargin: 0
//                    anchors.topMargin: 0

//                    theme: ChartView.ChartThemeBlueIcy
//                    BarSeries {
//                        name: "BarSeries"
//                        BarSet {
//                            values: [2, 2, 3]
//                            label: "Set1"
//                        }

//                        BarSet {
//                            values: [5, 1, 2]
//                            label: "Set2"
//                        }

//                        BarSet {
//                            values: [3, 5, 8]
//                            label: "Set3"
//                        }
//                    }
//                }
                ChartView {
                    id: bar2
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: parent.width*(1/3)
                    anchors.leftMargin: parent.width*(1/3)
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    theme: ChartView.ChartThemeQt
                    antialiasing: true

//                    PieSeries {
//                        id: pieSeries
//                        PieSlice { label: "eaten"; value: 94.9 }
//                        PieSlice { label: "not yet eaten"; value: 5.1 }
//                    }
                    LineSeries {
                            name: "LineSeries"
                            XYPoint { x: 0; y: 0 }
                            XYPoint { x: 1.1; y: 2.1 }
                            XYPoint { x: 1.9; y: 3.3 }
                            XYPoint { x: 2.1; y: 2.1 }
                            XYPoint { x: 2.9; y: 4.9 }
                            XYPoint { x: 3.4; y: 3.0 }
                            XYPoint { x: 4.1; y: 3.3 }
                        }
                }
                ChartView {
                    id: bar3
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: parent.width*(2/3)
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    theme: ChartView.ChartThemeQt
                    PieSeries {
                                            id: pieSeries
                                            PieSlice { label: "eaten"; value: 94.9 }
                                            PieSlice { label: "not yet eaten"; value: 5.1 }
                                        }
                }
            }


         }
     }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:27}D{i:26}
}
##^##*/
