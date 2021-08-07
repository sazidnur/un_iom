import QtQuick 2.0
import QtQuick.Controls 2.15
import QtCharts 2.3
import "../controls"
import "../controls/Form.ui"
import "../../js/QMLChartData.js" as ChartsData
import "../../js/QChartJsTypes.js" as ChartTypes

Item {
    width: 800
    height: 480

    property int chart_width: {
        if(parent.width<1000) return 1000;
        else return parent.width
    }

    property int chart_height: parent.height

    property int cnt: 0
    QChartJs{
        id: chart_line
        width: chart_width
        height: chart_height
        chartType: ChartTypes.QChartJSTypes.LINE
        chartData: ChartsData.ChartLineData
        animation: true
        chartAnimationEasing: Easing.InOutElastic;
        chartAnimationDuration: 2000;

        MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onPositionChanged: {
                    console.log(cnt);
                    cnt++;
                }
            }
    }


}
