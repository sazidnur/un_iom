import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: fileOpenBtn

    // CUSTOM PROPERTIES
    property url btnIconSource: "../../images/svg/folder (3).svg"
//    property color btnColorDefault: "#ffffff"
//    property color btnColorMouseOver: "#D6EAFF"
//    property color btnColorClicked: "#ADD6FF"

//    property int iconWidth: 18
//    property int iconHeight: 18
//    property color activeMenuColor: "#0033A0" //#333333
//    property color activeMenuColorRight: "#f8fbff"
//    property bool isActiveMenu: false

    QtObject{
        id: internal
        property url btnIconSource: if(fileOpenBtn.hovered) return "../../images/svg/folder (5).svg"; else "../../images/svg/folder (3).svg"
        // MOUSE OVER AND CLICK CHANGE COLOR
        property var dynamicColor: if(btnLeftMenu.down){
                                       btnLeftMenu.down ? btnColorClicked : btnColorDefault
                                   } else {
                                       btnLeftMenu.hovered ? btnColorMouseOver : btnColorDefault
                                   }

    }

    implicitWidth: 200
    implicitHeight: 200

    background: Rectangle{
        id: bgBtn
        width: 600
        height: 300
        color: "#ffffff"
    }

    contentItem: Item{
        anchors.fill: parent
        id: content
        Image {
            id: iconBtn
            source: internal.btnIconSource
            sourceSize.width: iconWidth
            sourceSize.height: iconHeight
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: true
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
//            color: "#0033A0" //#333333
            anchors.verticalCenter: parent.verticalCenter
            antialiasing: true
            width: iconWidth
            height: iconHeight
        }

    }
}

