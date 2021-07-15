import QtQuick 2.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.15

TextField {
    id: textField

    // Custom Properties
    property color colorDefault: "#FFFFFF"
    property color colorOnFocus: "#FFFFFF"
    property color colorMouseOver: "#EAF4FF"

    QtObject{
        id: internal

        property var dynamicColor: if(textField.focus){
                                        textField.hovered ? colorOnFocus : colorDefault
                                   }else{
                                       textField.hovered ? colorMouseOver : colorDefault
                                   }
    }

    implicitWidth: 300
    implicitHeight: 40
    placeholderText: qsTr("Search by id...")
    color: "#666666"
    font.pointSize: 11
    background: Rectangle {
        opacity: 1
        color: internal.dynamicColor
        radius: 4
        border.color: "#660033a0"
        border.width: 1
    }

    selectByMouse: true
    selectedTextColor: "#ffffff"
    selectionColor: "#0033A0"
    placeholderTextColor: "#808080"
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:40;width:640}
}
##^##*/
