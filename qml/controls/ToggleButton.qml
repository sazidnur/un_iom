import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

Button{
    id: btnToggle

    //Cutom Property

    property url btnIconSource: "../../images/svg/menu_icon.svg"
    property color btnColorDefault: "#ffffff"
    property color btnColorMouseOver: "#D6EAFF"
    property color btnColorClicked: "#ADD6FF"

    QtObject{
        id: internal

        //Mouse over and click change color
        property var dynamicColor: if(btnToggle.down){
                                       btnToggle.down ? btnColorClicked : btnColorDefault
                                   } else{
                                       btnToggle.hovered ? btnColorMouseOver : btnColorDefault
                                   }


    }

    implicitWidth: 70
    implicitHeight: 60

    background: Rectangle{
        id: bgBtn
        color: internal.dynamicColor

        Image {
            id: iconBtn
            source: btnIconSource
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            height: 25
            width: 25
            fillMode: Image.PreserveAspectFit
            visible: false
        }

        ColorOverlay{
            anchors.fill: iconBtn
            source: iconBtn
            color: "#0033A0"
            antialiasing: false
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
