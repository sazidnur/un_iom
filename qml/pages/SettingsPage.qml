//import QtQuick 2.0
//import QtQuick.Controls 2.15
//import QtCharts 2.3
//import "../controls"
//import "../controls/Form.ui"
//import "../../js/QMLChartData.js" as ChartsData
//import "../../js/QChartJsTypes.js" as ChartTypes

//Item {
//    width: 800
//    height: 480

//    property int chart_width: {
//        if(parent.width<1000) return 1000;
//        else return parent.width
//    }

//    property int chart_height: parent.height

//    property int cnt: 0
//    QChartJs{
//        id: chart_line
//        width: chart_width
//        height: chart_height
//        chartType: ChartTypes.QChartJSTypes.LINE
//        chartData: ChartsData.ChartLineData
//        animation: true
//        chartAnimationEasing: Easing.InOutElastic;
//        chartAnimationDuration: 2000;

//        MouseArea {
//                anchors.fill: parent
//                hoverEnabled: true
//                onPositionChanged: {
//                    console.log(cnt);
//                    cnt++;
//                }
//            }
//    }


//}
//import  QtQuick 2.3
//import  QtQuick.Window 2.2
//Window {
//    id: root;
//    visible:  true ;
//    width: 480;
//    height: 400;
//    //drag source item should not use anchors to layout! or drag will failed
//    Component {
//        id: dragColor;
//        Rectangle {
//            id: dragItem;
//            x: 0;
//            y: 0;
//            width: 60;
//            height: 60;
//            Drag.active: dragArea.drag.active;
//            Drag.supportedActions: Qt.CopyAction;
//            Drag.dragType: Drag.Automatic;
//            Drag.mimeData: { "color" : color,  "width" : width,  "height" : height};
//            MouseArea {
//                id: dragArea;
//                anchors.fill: parent;
//                drag.target: parent;
//                onReleased: {
//                    if (parent.Drag.supportedActions === Qt.CopyAction) {
//                        dragItem.x = 0;
//                        dragItem.y = 0;
//                    }
//                }
//            }
//        }
//    }
//    Row {
//        id: dragSource;
//        anchors.top: parent.top;
//        anchors.left: parent.left;
//        anchors.margins: 4;
//        anchors.right: parent.right;
//        height: 64;
//        spacing: 4;
//        z: -1;
//        Loader {
//            width: 60;
//            height: 60;
//            z: 2;
//            sourceComponent: dragColor;
//            onLoaded: item.color =  "red" ;
//        }
//        Loader {
//            width: 60;
//            height: 60;
//            z: 2;
//            sourceComponent: dragColor;
//            onLoaded: item.color =  "black" ;
//        }
//        Loader {
//            width: 60;
//            height: 60;
//            z: 2;
//            sourceComponent: dragColor;
//            onLoaded: item.color =  "blue" ;
//        }
//        Loader {
//            width: 60;
//            height: 60;
//            z: 2;
//            sourceComponent: dragColor;
//            onLoaded: item.color =  "green" ;
//        }
//    }
//    DropArea {
//        id: dropContainer;
//        anchors.top: dragSource.bottom;
//        anchors.left: parent.left;
//        anchors.right: parent.right;
//        anchors.bottom: parent.bottom;
//        z: -1;
//        onEntered: {
//            drag.accepted =  true ;
//            followArea.color = drag.getDataAsString ( "color" );
//            console.log ( "onEntered, formats-" , drag.formats,  " action- " , drag.action);
//        }
//        onPositionChanged: {
//            drag.accepted =  true ;
//            followArea.x = drag.x-4;
//            followArea.y = drag.y-4;
//        }
//        onDropped: {
//            console.log ( "onDropped-" , drop.proposedAction);
//            console.log ( " data- " , drop.getDataAsString ( "color" ));
//            console.log ( "event.x-" , drop.x,  "y-" , drop.y);
//            console.log ( "event class =" , drop);
//            if (drop.supportedActions == Qt.CopyAction) {
//                var  obj = dragColor.createObject (destArea, {
//                                                     "x" : drop.x,
//                                                     "y" : drop.y,
//                                                     "width" : parseInt (drop.getDataAsString ( "width" )),
//                                                     "height" : parseInt (drop.getDataAsString ( "height" )),
//                                                     "color" : drop.getDataAsString ( "color" ),
//                                                     "Drag.supportedActions" : Qt.MoveAction,
//                                                     "Drag.dragType" : Drag.Internal
//                                                 });
//            } else if (drop.supportedActions == Qt.MoveAction) {
//                console.log ( "move action, drop.source-" , drop.source,  "drop.source.source-" , drop.source.source);
//            }
//            drop.acceptProposedAction ();
//            drop.accepted =  true ;
//        }
//        Rectangle {
//            id: followArea;
//            z: 2;
//            width: 68;
//            height: 68;
//            border.width: 2;
//            border.color:  "yellow" ;
//            visible: parent.containsDrag;
//        }
//        Rectangle {
//            id: destArea;
//            anchors.fill: parent;
//            color:  "lightsteelblue" ;
//            border.width: 2;
//            border.color: parent.containsDrag?  "blue"  :  "gray" ;
//        }
//    }
//}

import QtQuick 2.2
//import "../shared" as Examples

Rectangle {
    id: item
    property string display
    property alias dropEnabled: acceptDropCB.checked
    color: dropArea.containsDrag ? "#CFC" : "#EEE"
    ColorAnimation on color {
        id: rejectAnimation
        from: "#FCC"
        to: "#EEE"
        duration: 1000
    }
    Text {
        anchors.fill: parent
        text: item.display
        wrapMode: Text.WordWrap
    }
    DropArea {
        id: dropArea
        anchors.fill: parent
        keys: ["text/plain"]
        onEntered: if (1) {
            drag.accepted = false
            rejectAnimation.start()
        }
        onDropped: if (drop.hasText && acceptDropCB.checked) {
            if (drop.proposedAction == Qt.MoveAction || drop.proposedAction == Qt.CopyAction) {
                item.display = drop.text
                drop.acceptProposedAction()
            }
        }
    }
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        drag.target: draggable
    }
    Item {
        id: draggable
        anchors.fill: parent
        Drag.active: mouseArea.drag.active
        Drag.hotSpot.x: 0
        Drag.hotSpot.y: 0
        Drag.mimeData: { "text/plain": item.display }
        Drag.dragType: Drag.Automatic
        Drag.onDragFinished: if (dropAction === Qt.MoveAction) item.display = ""
    }
    Examples.CheckBox {
        id: acceptDropCB
        anchors.right: parent.right
        checked: true
        text: "accept drop"
    }
}
