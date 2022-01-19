import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import QtQuick.Dialogs 1.3
import QtQuick.Layouts 1.15
import QtQuick.Controls.Styles 1.4
//import Qt.labs.platform 1.1
import "../controls"

Item {

    Rectangle{
        id: excelFilePageContent
        color: "#F8FBFF"
        anchors.fill: parent

        Rectangle {

            property string hoveredBtn: "../../images/svg/folder (3).svg"
            property string noHoveredBtn: "../../images/svg/folder (5).svg"
            property bool isEntered: false
            property string lastFilePath: ""

            function showSaveBtn(){
                fileSaveProgressBar.visible = true
                btnSaveExcel.visible = false
            }

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
//            border.color: "#808080"
//            border.width: 1
            radius: 5

            layer.enabled: true
            layer.effect: DropShadow {
                transparentBorder: true
                horizontalOffset: 0
                verticalOffset: 0
                radius: 10
                samples: 21
                color: "#66000000"
            }

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
                    id: fileUploadLabel
                    color: "#808080"
                    text: qsTr("Click or drop file here")
                    anchors.bottom: parent.bottom
                    font.pointSize: {
                        if(excelFilePageContent.width<1000) return 10
                        else return 12
                    }

                    minimumPixelSize: 12
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottomMargin: {
                        if(excelFilePageContent.width<1000) return 4
                        else if(excelFilePageContent.width<1350) return 30
                        else return 35
                    }
                }
                FileDialog {
                    id: fileOpen
                    title: "Open excel file"
                    folder: fileName(backend.checkLastLoacationOfFolder())
                    selectMultiple: false
                    nameFilters: ["Excel File (*.xlsx)"]
                    onAccepted: {
                        fileOpenBg.lastFilePath = fileOpen.fileUrl
                        fileOpenBg.lastFilePath = fileOpenBg.lastFilePath.split("///")[1]
                        filename.text = fileOpenBg.lastFilePath
                        print(fileOpenBg.lastFilePath, "okay")
//                        backend.checkValidExcelFile(fileOpenBg.lastFilePath)
                        btnSaveExcel.visible = true
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
                        fileOpenBg.lastFilePath = drop.text.split("///")[1]
                        filename.text = fileOpenBg.lastFilePath
                    }
                    onEntered: {
                        if(drag.urls.length>1){
                            drag.accepted = false
//                            fileConfirmationText.showHideFileStatus(2)
                            notificationBar.callNotification("#CCFF5252", "Drop only one excel file!")
                            return
                        }
                        if(validateFileExtension(drag.urls[0]))
                        {
                            drag.accept()
                            return // drag accepted
                        }
                        else{           //if not accepted (file type not matched)
//                            fileConfirmationText.showHideFileStatus(3)
                            notificationBar.callNotification("#CCFF5252", "Only excel file allowed!")
                            drag.accepted = false
                        }

//                        for(var i = 0; i < drag.urls.length; i++)
//                        {
                            //for multiple file
//                        }

                    }

                    onExited: {
                        fileOpenBg.isEntered = false
                    }

                    function validateFileExtension(filePath){
                        return filePath.split('.').pop() === "xlsx"
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
                fileOpenBg.showSaveBtn()
                backend.checkValidFilePath(fileOpenBg.lastFilePath)
            }
        }

        ProgressBar {
            id: fileSaveProgressBar
            width: {
                if(excelFilePageContent.width>1350) return 450
                else return 350
            }

            visible: false
            indeterminate: true
            anchors.verticalCenter: btnSaveExcel.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            //            value: 0.5
        }

        Label {
            id: filename
            text: qsTr("")
            anchors.left: fileOpenBg.left
            anchors.top: fileOpenBg.bottom
            anchors.leftMargin: 0
            anchors.topMargin: 25
            color: "#808080"
            font.pointSize: {
                if(excelFilePageContent.width<1000) return 8
                else return 12
            }

            minimumPixelSize: 12
        }

//        Label {
//            id: fileConfirmationText
//            visible: false
//            text: qsTr("")
//            anchors.left: parent.left
//            anchors.top: fileOpenBg.bottom
//            anchors.leftMargin: 100
//            font.italic: true
//            anchors.topMargin: 10
//            font.pointSize: {
//                if(excelFilePageContent.width>1350) return 12
//                else if(excelFilePageContent.width>1000) return 11
//                else return 10
//            }

//            PropertyAnimation {
//                id: showHideFileConfirmationText
//                running: true
//                target: fileConfirmationText
//                property: 'visible'
//                to: false
//                duration: 3000 // turns to false after 3000 ms
//            }
//            function showHideFileStatus(flag){
//                if(flag===1){
//                    text = qsTr("File saved successfully!")
//                    color= "#13805A"
//                }
//                else if(flag===2){
//                    text = qsTr("Choose only one file!")
//                    color = "#FF5252"
//                }
//                else if(flag===3){
//                    text = qsTr("Only excel file allowed!")
//                    color = "#FF5252"
//                }
//                else{
//                    text = qsTr("Can't save file!")
//                    color = "#FF5252"
//                }

//                visible = true
//                showHideFileConfirmationText.start()
//            }
//        }


    }
    Connections{
        target: backend

        function onSetCheckValidFilePath(flag){
            fileOpenBg.showSaveBtn()
            if(!flag){
                notificationBar.callNotification("#CCFF5252", "File not found!")
            }
            else{
                backend.checkValidExcelFile(fileOpenBg.lastFilePath)
            }
        }

        function onSetCheckValidExcelFile(flag){
            if(!flag){
                notificationBar.callNotification("#CCFF5252", "Invalid Excel file!")
            }
            else{
                btnSaveExcel.visible = false
                fileSaveProgressBar.visible = true
                backend.saveExcelFileData(fileOpenBg.lastFilePath)
            }
        }

        function onSetSaveExcelFileData(flag){
            if(!flag){
                notificationBar.callNotification("#CCFF5252", "Unknown error, Can't save file!")
                fileSaveProgressBar.visible = false
                btnSaveExcel.visible = true
            }
            else{
                fileOpenBg.lastFilePath = ""
                filename.text = ""
                notificationBar.callNotification("#72B58D", "File saved successfully!")
                btnSaveExcel.visible = false
                fileSaveProgressBar.visible = true
                fileUploadLabel.text = "Processing Data..."
//                fileDrop.visible = false
//                fileOpen.visible = false
                backend.processData()
            }
        }
        function onSetProcessData(flag){
            print(flag)
            if(flag){
                notificationBar.callNotification("#72B58D", "Data processed successfully!")
                fileSaveProgressBar.visible = false
                fileUploadLabel.text = "Click or drop file here"
//                fileDrop.visible = true
//                fileOpen.Ignore = false
//                fileOpen.visible = true
                backend.reachable()
            }
            else{
                notificationBar.callNotification("#CCFF5252", "Can't Process Data!")
                fileSaveProgressBar.visible = false
                fileUploadLabel.text = "Click or drop file here"
//                fileDrop.visible = true
//                fileOpen.Ignore = false
//                fileOpen.visible = true
            }

        }

        function onGetLastLocationOfFolder(path){
            if(path==="null") return qsTr('file:\\\C')
            else return path
        }
//        function onSetRefreshData(a){
//            print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
//            data.refresh(a)
//        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:800}D{i:15}
}
##^##*/
