import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.15
import "../controls"

Item {
    Rectangle{
        id: excelFilePageContent
        color: "#F8FBFF"
        anchors.fill: parent

        Rectangle {
            id: fileOpenBg
            width: 500
            color: "#ffffff"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: excelFilePageContent.height/1.5

            anchors.rightMargin: 100
            anchors.leftMargin: 100
            anchors.topMargin: 30
            border.color: "#808080"
            border.width: 1
            radius: 5

            property string hoveredBtn: "../../images/svg/folder (3).svg"
            property string noHoveredBtn: "../../images/svg/folder (5).svg"
            property bool isEntered: false


            Button {
                id: fileOpenBtn

                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.bottomMargin: 0
                anchors.topMargin: 0
                QtObject{
                    id: internal
                    property url btnIconSource: if(fileOpenBtn.hovered || fileOpenBg.isEntered) return fileOpenBg.hoveredBtn; else fileOpenBg.noHoveredBtn

                }
                implicitWidth: 200
                implicitHeight: 200

                background: Rectangle{
                    id: bgBtn
                    color: "#00000000"
                }

                contentItem: Item{
                    anchors.fill: parent
                    id: content
                    Image {
                        id: iconBtn
                        source: internal.btnIconSource
                        anchors.horizontalCenter: parent.horizontalCenter
                        sourceSize.width: 100
                        sourceSize.height: 100
                        fillMode: Image.PreserveAspectFit
                        visible: false
                        anchors.verticalCenter: parent.verticalCenter
                        antialiasing: true
                    }

                    ColorOverlay{
                        anchors.fill: iconBtn
                        source: iconBtn
            //            color: "#0033A0" //#333333
                        anchors.verticalCenter: parent.verticalCenter
                        antialiasing: true
                        width: 200
                        height: 200
                    }

                }
                Text {
                    id: name
                    color: "#808080"
                    text: qsTr("Click or drop file here")
                    anchors.bottom: parent.bottom
                    font.pointSize: 12
                    minimumPixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: 5
                }
                FileDialog {
                    id: fileOpen
                    title: "Open excel file"
                    folder: shortcuts.home
                    selectMultiple: false
                    nameFilters: ["Excel File (*.exl)"]
                    onAccepted: {
                        btnSaveExcel.visible = true
                        print("okay")
                    }
                }
                onPressed: {
                    fileOpen.open()
                }
                DropArea {
                    id: fileDrop
                    anchors.fill: parent

                    onDropped: {
                        fileOpenBg.isEntered = false
                        btnSaveExcel.visible = true
                        print(drop.text)
                    }

                    onEntered: {
                        fileOpenBg.isEntered = true
                    }

                    onExited: {
                        fileOpenBg.isEntered = false
                    }
                }
            }
        }

        CustomButton{
            id: btnSaveExcel
            width: {
                if(excelFilePageContent.width>1350) return 150
                else if(excelFilePageContent.width>1000) return 125
                else return 110
            }

            height: {
                if(excelFilePageContent.width>1350) return 45
                else if(excelFilePageContent.width>1000) return 40
                else return 35
            }
            visible: false

            text: "Save"
            anchors.right: parent.right
            anchors.top: fileOpenBg.bottom
            anchors.rightMargin: 100
            anchors.topMargin: 15
            Layout.maximumWidth: 200
            Layout.fillWidth: true
            Layout.preferredWidth: 50
            Layout.preferredHeight: 40
            onClicked: {
                visible = false
                fileConfirmationText.showHideFileStatus(false)
                print("file saved")
            }
        }

        Label {
            id: fileConfirmationText
            visible: false
            text: qsTr("")
            anchors.left: parent.left
            anchors.top: fileOpenBg.bottom
            anchors.leftMargin: 100
            font.italic: true
            anchors.topMargin: 10
            font.pointSize: {
                if(excelFilePageContent.width>1350) return 12
                else if(excelFilePageContent.width>1000) return 11
                else return 10
            }

            PropertyAnimation {
                id: showHideFileConfirmationText
                running: true
                target: fileConfirmationText
                property: 'visible'
                to: false
                duration: 3000 // turns to false after 3000 ms
            }
            function showHideFileStatus(flag){
                if(flag){
                    text = qsTr("File saved successfully!")
                    color = "#13805A"
                }
                else{
                    text = qsTr("Can't save file!")
                    color = "#FF5252"
                }

                visible = true
                showHideFileConfirmationText.start()
            }
        }


    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:13}
}
##^##*/
