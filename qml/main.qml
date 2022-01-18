import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15
import "controls"


Window {
    id: mainWindow
    width: 1000
    height: 580
    minimumWidth: 800
    minimumHeight: 500
    visible: true
    color: "#00000000"

    title: qsTr("UN IOM")

    //Remove Title Bar
    flags: Qt.Window | Qt.FramelessWindowHint


    //Property
    property int windowStatus: 0
    property int windowMargin: 10
    property bool logoFlag: true
    property string topRightText: {
        if(btnHome.isActiveMenu) return "| HOME"
        else if(btnLoadExcel.isActiveMenu) return "| LOAD EXCEL FILE"
        else if(btnSetting.isActiveMenu) return "| SETTINGS"
        else if(btnHistory.isActiveMenu) return "| HISTORY"
        else if(btnAnalysis.isActiveMenu) return "| ANALYSIS"
    }


    //Internal functions
    QtObject{
        id: internal

        function resetResizeBorders(flag){
            resizeLeft.visible = flag
            resizeRight.visible = flag
            resizeBottom.visible = flag
            resizeWindow.visible = flag
        }

        function maximizeRestore(){
            if(windowStatus == 0){
                mainWindow.showMaximized()
                windowStatus = 1
                windowMargin = 0

                //Resize visibility
                internal.resetResizeBorders(false)

                btnMaximizeRestore.btnIconSource = "../images/svg/restore_icon.svg"
            }
            else{
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10

                //Resize visibility
                internal.resetResizeBorders(true)

                btnMaximizeRestore.btnIconSource = "../images/svg/maximize_icon.svg"
            }
        }

        function ifMaximizedWindowRestore(){
            if(windowStatus == 1){
                mainWindow.showNormal()
                windowStatus = 0
                windowMargin = 10

                //Resize visibility
                internal.resetResizeBorders(true)

                btnMaximizeRestore.btnIconSource = "../images/svg/maximize_icon.svg"
            }
        }

        function restoreMargins(){
            windowStatus = 0
            windowMargin = 10


            //Resize visibility
            internal.resetResizeBorders(true)

            btnMaximizeRestore.btnIconSource = "../images/svg/maximize_icon.svg"
        }
    }


    Rectangle {
        id: background
        color: "#f9f9f9"
        border.color: "#c0c0c0"
        border.width: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: windowMargin
        anchors.leftMargin: windowMargin
        anchors.bottomMargin: windowMargin
        anchors.topMargin: windowMargin
        z: 1

        Rectangle {
            id: appContainer
            color: "#00000000"
            anchors.fill: parent
            anchors.rightMargin: 1
            anchors.leftMargin: 1
            anchors.bottomMargin: 1
            anchors.topMargin: 1

            Rectangle {
                id: topBar
                height: 60
                color: "#ffffff"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 0
                anchors.leftMargin: 0
                anchors.topMargin: 0

                ToggleButton{
                    btnColorClicked: "#add6ff"
                    onClicked: {
                        if(logoFlag){
                            logoFlag = false
                            logoHide.start()
                            animationMenu.running = true
                        }
                        else{
                            logoFlag = true
                            logoShow.start()
                            animationMenu.running = true
                        }
                    }

                }

                Rectangle {
                    id: topBarDescription
                    y: 20
                    height: 25
                    color: "#eaf4ff"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.rightMargin: 0
                    anchors.leftMargin: 70
                    anchors.bottomMargin: 0

                    Label {
                        id: labelTopInfo
                        color: "#808080"
                        text: qsTr("Saturday 12:45 PM")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 300
                        anchors.leftMargin: 10
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }

                    Label {
                        id: topRightInfo
                        color: "#808080"
                        text: topRightText
                        anchors.left: labelTopInfo.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        horizontalAlignment: Text.AlignRight
                        verticalAlignment: Text.AlignVCenter
                        anchors.rightMargin: 10
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                    }
                }

                Rectangle {
                    id: titleBar
                    height: 35
                    color: "#00000000"
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 105
                    anchors.leftMargin: 70
                    anchors.topMargin: 0

                    DragHandler{
                        onActiveChanged: if(active){
                                             mainWindow.startSystemMove()
                                             internal.ifMaximizedWindowRestore()
                                         }
                    }

                    Image {
                        id: iconApp
                        width: 22
                        height: 22
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        source: "../images/svg/app_top.svg"
                        sourceSize.height: 300
                        sourceSize.width: 300
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 0
                        anchors.topMargin: 0
                        fillMode: Image.PreserveAspectFit
                    }

                    Label {
                        id: title
                        color: "#333333"
                        text: qsTr("QPack")
                        anchors.left: iconApp.right
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        font.weight: Font.Thin
                        font.family: "MS Shell Dlg 2"
                        font.pointSize: 12
                        anchors.leftMargin: 5
                    }
                }

                Row {
                    id: rowBtns
                    width: 105
                    height: 35
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.rightMargin: 0
                    anchors.topMargin: 0

                    TopBarButton{
                        id: btnMinimize

                        onClicked:{
                            mainWindow.showMinimized()
                            internal.restoreMargins()
                        }
                    }

                    TopBarButton {
                        id: btnMaximizeRestore
                        btnIconSource: "../images/svg/maximize_icon.svg"

                        onClicked: internal.maximizeRestore()
                    }

                    TopBarButton {
                        id: btnClose
                        btnColorMouseOver: "#f48891"
                        btnColorClicked: "#ed414f"
                        btnIconSource: "../images/svg/close_icon.svg"

                        onClicked: mainWindow.close()
                    }
                }
            }

            Rectangle {
                id: content
                color: "#f9f9f9"
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: topBar.bottom
                anchors.bottom: parent.bottom
                anchors.topMargin: 0

                Rectangle {
                    id: leftMenu
                    width: 200
                    color: "#ffffff"
                    border.color: "#ffffff"
                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0

                    PropertyAnimation{
                        id: animationMenu
                        target: leftMenu
                        property: "width"
                        to: if(leftMenu.width == 70) return 200; else return 70
                        duration: 500
                        easing.type: Easing.InOutQuint //OutBounce
                    }

                    Column {
                        id: columnMenus
                        width: 70
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.leftMargin: 0
                        anchors.bottomMargin: 90
                        anchors.topMargin: 0

                        LeftMenuBtn {
                            id: btnHome
                            width: leftMenu.width
                            text: qsTr("Home")
                            font.letterSpacing: 1
                            font.weight: Font.ExtraLight
                            font.pointSize: 10
                            btnIconSource: "../images/svg/home_icon.svg"
                            isActiveMenu: true
                            onClicked: {
                                btnHome.isActiveMenu = true
                                btnSetting.isActiveMenu = false
                                btnAnalysis.isActiveMenu = false
                                btnLoadExcel.isActiveMenu = false
                                btnHistory.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/HomePage.qml"))
                            }

                        }

                        LeftMenuBtn {
                            id: btnAnalysis
                            width: leftMenu.width
                            text: qsTr("Analysis")
                            font.letterSpacing: 1
                            font.weight: Font.ExtraLight
                            font.pointSize: 10
                            btnIconSource: "../images/svg/resize_icon.svg"
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSetting.isActiveMenu = false
                                btnAnalysis.isActiveMenu = true
                                btnLoadExcel.isActiveMenu = false
                                btnHistory.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/analysis.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnLoadExcel
                            width: leftMenu.width
                            text: qsTr("Load Excel File")
                            font.letterSpacing: 1
                            font.weight: Font.ExtraLight
                            font.pointSize: 10
                            btnIconSource: "../images/svg/open_icon.svg"
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSetting.isActiveMenu = false
                                btnAnalysis.isActiveMenu = false
                                btnLoadExcel.isActiveMenu = true
                                btnHistory.isActiveMenu = false
                                stackView.push(Qt.resolvedUrl("pages/LoadExcelFilePage.qml"))
                            }
                        }

                        LeftMenuBtn {
                            id: btnHistory
                            width: leftMenu.width
                            text: qsTr("Histoy")
                            font.letterSpacing: 1
                            font.weight: Font.ExtraLight
                            font.pointSize: 10
                            btnIconSource: "../images/svg/history.svg"
                            onClicked: {
                                btnHome.isActiveMenu = false
                                btnSetting.isActiveMenu = false
                                btnAnalysis.isActiveMenu = false
                                btnLoadExcel.isActiveMenu = false
                                btnHistory.isActiveMenu = true
                            }
                        }
                    }

                    LeftMenuBtn {
                        id: btnSetting
                        x: 0
                        y: 323
                        width: leftMenu.width
                        text: qsTr("Settings")
                        font.letterSpacing: 1
                        font.weight: Font.ExtraLight
                        font.pointSize: 10
                        anchors.bottom: parent.bottom
                        anchors.bottomMargin: 25
                        btnIconSource: "../images/svg/settings_icon.svg"
                        onClicked: {
                            btnHome.isActiveMenu = false
                            btnSetting.isActiveMenu = true
                            btnAnalysis.isActiveMenu = false
                            btnLoadExcel.isActiveMenu = false
                            btnHistory.isActiveMenu = false
                            stackView.push(Qt.resolvedUrl("pages/aSDAD.qml"))
                        }
                    }

                    Image {
                        id: logo
                        width: 80
                        height: 80
                        visible: true
                        anchors.left: parent.left
                        anchors.bottom: btnSetting.top
                        source: "../images/logo.png"
                        anchors.leftMargin: 60
                        anchors.bottomMargin: 5
                        fillMode: Image.PreserveAspectFit

                        PropertyAnimation {
                            id: logoShow
                            running: false
                            to: true
                            target: logo
                            property: "visible"
                            duration: 250
                        }
                        PropertyAnimation {
                            id: logoHide
                            //                            running: true
                            to: false
                            target: logo
                            property: "visible"
                            duration: 250
                        }
                    }
                }

                Rectangle {
                    id: contentPages
                    color: "#f8fbff"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: parent.top
                    anchors.bottom: parent.bottom
                    clip: true
                    anchors.rightMargin: 0
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 25
                    anchors.topMargin: 0

                    StackView {
                        id: stackView
                        anchors.fill: parent
                        initialItem: Qt.resolvedUrl("pages/HomePage.qml")
                    }
                }

                Rectangle {
                    id: notificationBar
                    width: 250
                    height: 45
                    visible: false
                    color: "#72b58d"
                    radius: 5
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 35
                    anchors.rightMargin: 10
                    z: 1
                    layer.enabled: true
                    layer.effect: DropShadow {
                        transparentBorder: true
                        horizontalOffset: 0
                        verticalOffset: 0
                        radius: 10
                        samples: 21
                        color: "#66000000"
                    }


                    PropertyAnimation {
                        id: showNotification
                        target: notificationBar
                        to: {if(notificationBar.visible) return false; else return true;}
                        duration: 3000
                        property: "visible"
                        easing: Easing.OutBounce
                    }

                    Text {
                        id: notificationText
                        color: "#ffffff"
                        text: qsTr("Notification Text")
                        anchors.verticalCenter: parent.verticalCenter
                        font.pixelSize: 13
                        font.italic: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    function callNotification(notificationColor, text){
                        notificationBar.color = notificationColor
                        notificationText.text = text
                        notificationBar.visible = true
                        showNotification.start()
                    }

//                    DropShadow{
//                        id: notificationBarShadow
//                        horizontalOffset: 0
//                        verticalOffset: 0
//                        radius: 5
//                        anchors.fill: parent
//                        samples: 11
//                        color: "#80000000"
//                        source: parent
//                        spread: 0
//                    }
                }

                Rectangle {
                    id: bottomBar
                    color: "#eaf4ff"
                    anchors.left: leftMenu.right
                    anchors.right: parent.right
                    anchors.top: contentPages.bottom
                    anchors.bottom: parent.bottom
                    anchors.leftMargin: 0
                    anchors.bottomMargin: 0
                    anchors.topMargin: 0
                    anchors.rightMargin: 0

                    Label {
                        id: versionLabel
                        color: "#808080"
                        text: qsTr("v1.2")
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        verticalAlignment: Text.AlignVCenter
                        anchors.bottomMargin: 0
                        anchors.rightMargin: 30
                        anchors.leftMargin: 10
                        anchors.topMargin: 0
                    }

                    MouseArea {
                        id: resizeWindow
                        x: 892
                        y: 0
                        width: 25
                        height: 25
                        opacity: 0.75
                        anchors.right: parent.right
                        anchors.bottom: parent.bottom
                        anchors.rightMargin: 0
                        anchors.bottomMargin: 0
                        cursorShape: Qt.SizeFDiagCursor

                        DragHandler{
                            target: null
                            onActiveChanged: if(active){
                                                 mainWindow.startSystemResize(Qt.RightEdge | Qt.BottomEdge)
                                             }
                        }

                        Image {
                            id: resizeImage
                            width: 16
                            height: 16
                            anchors.fill: parent
                            source: "../images/svg/resize_icon.svg"
                            anchors.leftMargin: 5
                            anchors.topMargin: 5
                            sourceSize.height: 16
                            sourceSize.width: 16
                            fillMode: Image.PreserveAspectFit
                            antialiasing: false
                        }
                    }
                }

            }
        }
    }


    DropShadow{
        id: mainWindowShadow
        anchors.fill: background
        horizontalOffset: 0
        verticalOffset: 0
        radius: 10
        samples: 16
        color: "#80000000"
        source: background
        z: 0
    }

    MouseArea {
        id: resizeLeft
        x: 10
        y: 20
        width: 10
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.LeftEdge)
                             }
        }
    }

    MouseArea {
        id: resizeRight
        x: 10
        y: 20
        width: 10
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.rightMargin: 0
        anchors.bottomMargin: 10
        anchors.topMargin: 10
        cursorShape: Qt.SizeHorCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.RightEdge)
                             }
        }
    }


    MouseArea {
        id: resizeBottom
        x: 10
        y: 20
        height: 10
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.rightMargin: 10
        anchors.leftMargin: 10
        anchors.bottomMargin: 0
        cursorShape: Qt.SizeVerCursor

        DragHandler{
            target: null
            onActiveChanged: if(active){
                                 mainWindow.startSystemResize(Qt.BottomEdge)
                             }
        }
    }

    Connections{
        target: backend

        function onPrintTime(time){
            labelTopInfo.text = time
        }
    }

}
