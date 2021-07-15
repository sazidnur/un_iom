import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnTopBar

    //Cutom Property

    property url btnIconSource: "../../images/svg/minimize_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#D6EAFF"
    property color btnColorClicked: "#ADD6FF"

    QtObject{
        id: internal

        //Mouse over and click change color
        property var dynamicColor: if(btnTopBar.down){
                                       btnTopBar.down ? btnColorClicked : btnColorDefault
                                   } else{
                                       btnTopBar.hovered ? btnColorMouseOver : btnColorDefault
                                   }


    }

    implicitWidth: 35
    implicitHeight: 35

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 16
            width: 16
            fillMode: Image.PreserveAspectFit
            visible: false
            antialiasing: false
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#000000"
            antialiasing: false
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
