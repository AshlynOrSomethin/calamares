import io.calamares.ui 1.0
import io.calamares.core 1.0

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Shapes 1.15

Rectangle {
    id: sideBar;

    SystemPalette {
        id: systemPalette
    }

    color: systemPalette.window;

    antialiasing: true

    Rectangle {
        anchors.fill: parent
        anchors.rightMargin: 35/2
        color: Branding.styleString(Branding.SidebarBackground)
    }

    ListView {
        id: list
        anchors.leftMargin: 12
        anchors.fill: parent
        model: ViewManager
        interactive: false
        spacing: 0
        delegate: RowLayout {
            visible: index!=0
            height: index==0?0:50
            width: parent.width

            Text {
                Layout.fillWidth: true
                fontSizeMode: Text.Fit
                color: Branding.styleString(Branding.SidebarText)
                text: display;
                font.pointSize : 12
                minimumPointSize: 5
                Layout.alignment: Qt.AlignLeft|Qt.AlignVCenter
                clip: true
            }
            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 35

                Rectangle {
                    anchors.centerIn: parent
                    id: image
                    height: parent.width*0.65
                    width: height
                    radius: height/2
                    color: {
                        if (index>ViewManager.currentStepIndex) {
                            return systemPalette.mid;
                        }
                        return systemPalette.highlight
                    }
                    z: 10
                }
                Rectangle {
                    color: {
                        if (index>ViewManager.currentStepIndex && index!=1) {
                            return systemPalette.mid;
                        }
                        return systemPalette.highlight;

                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: image.verticalCenter
                    height: parent.height/2
                    width: 5
                    z: 0
                }
                Rectangle {
                    color: {
                        if (index<ViewManager.currentStepIndex || ViewManager.currentStepIndex==list.count-1) {
                            return systemPalette.highlight;
                        }
                        return systemPalette.mid;
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: image.verticalCenter
                    height: parent.height/2
                    width: 5
                    //visible: (index !== (list.count - 1))
                    z: 0
                }
                Shape {
                    visible: index == ViewManager.currentStepIndex
                    id: shape
                    anchors.fill: parent
                    smooth: true
                    layer.enabled: true
                    layer.samples: 8

                    ShapePath {
                        fillColor: "transparent"
                        strokeColor: systemPalette.highlight
                        strokeWidth: 3
                        capStyle: ShapePath.FlatCap

                        PathAngleArc {
                            centerX: shape.width/2; centerY: shape.height/2
                            radiusX: 15; radiusY: 15
                            startAngle: 0
                            sweepAngle: 360
                        }
                    }
                }
            }
        }
        header: RowLayout {
            height: 55
            anchors.right: parent.right
            anchors.left: parent.left
            Item {
                Layout.fillWidth: true
            }
            Shape {
                id: parchedShape
                Layout.preferredHeight: 27
                Layout.preferredWidth: 27

                ShapePath {
                    scale: Qt.size((parchedShape.width-1)/200, (parchedShape.height-1)/200)

                    fillColor: systemPalette.highlight
                    strokeWidth: -1
                    PathSvg {
                    #    path: "M 14.28571,0 C 6.37556,0 0,6.375557 0,14.285714 V 185.71428 C 0,193.62444 6.37556,200 14.28571,200 H 57.14286 V 57.142856 h 71.42857 V 0 Z m 128.57144,0 v 200 h 42.85714 C 193.62445,200 200,193.62444 200,185.71428 V 14.285714 C 200,6.375557 193.62445,0 185.71429,0 Z M 71.42857,71.42857 V 200 h 57.14286 V 71.42857 Z m 0,0"
                        path: "M322.086,796.56c-2.5-1.7-4.1-3.4-4.1-4.7v-24.7c0.3-1,2.1-3.6,4.4-5c0.1-0.1,0.2-0.1,0.3-0.2c7.6-5.4,12.3-14,12.3-22.3 c0-6.5-1.6-11.9-4.9-16.3c3.1-4.5,4.9-10.1,4.9-16c0.1-6.6-1.5-12-4.8-16.5c3.2-4.7,4.9-10.6,4.9-17.3c0-7.3-2.7-13.6-7.9-18.5 v-3.9c0-17.9-12.6-33.4-33.1-41.5c-1.6-14.1-9.4-26.1-20.3-32.3c0.2-1.7,0.3-3.8-0.5-6.1c-0.6-17.4-11.8-30.9-25.9-30.9h-31.5 c-14.5,0-25.9,14.2-25.9,32.4v4.4c-11,6.1-19.3,18.1-21.7,32.5c-19.7,8.2-32.1,24.1-32.1,41.5v3.5c-5,4.3-7.9,11.1-7.9,18.9 c0,6.7,1.7,12.6,4.9,17.3c-3.3,4.4-4.9,9.9-4.9,16.3c0,5.9,1.7,11.4,4.8,16c-4,5.1-5.8,11.3-4.8,17.1c0.2,9.3,4.9,17.3,12.8,21.9 c2.3,1.5,4,4,4.3,5v22.2c0,2.1-3.9,5.6-6.3,7.8c-0.5,0.4-0.9,0.8-1.4,1.3c-5.7,4-9.4,11.1-9.4,18.3v163 c0,13.3,10.2,23.7,23.3,23.7h160.2c13,0,23.3-10.4,23.3-23.7v-163C335.086,808.26,330.086,800.56,322.086,796.56z M215.986,555.46h31.5c6,0,10.9,7.8,10.9,17.4h-1.7h-49.9h-1.7C205.086,563.26,209.986,555.46,215.986,555.46z M320.086,979.76 c0,4.2-2.9,8.7-8.3,8.7h-160.2c-5.4,0-8.3-4.5-8.3-8.7v-163c0-2.4,1.3-5,3.1-6.1c0.4-0.3,0.8-0.6,1.2-0.9c0.5-0.5,1.1-1,1.6-1.5 c4.5-4.1,11.2-10.2,11.2-18.9v-22.4c0-7.1-5.9-14.1-11.4-17.5c-0.1-0.1-0.2-0.1-0.3-0.2c-3.6-2-5.4-5.3-5.4-9.7 c0-0.5-0.1-1-0.2-1.5c-0.5-2.6,1.5-6.1,4.9-8.5c2-1.4,3.2-3.7,3.2-6.1c0-2.4-1.2-4.7-3.2-6.1c-3-2.1-4.7-5.9-4.7-10.1 c0-5.6,1.9-8,4.7-10.1c2-1.4,3.2-3.7,3.2-6.1c0-2.4-1.2-4.7-3.2-6.1c-3.9-2.8-4.7-7.7-4.7-11.3c0-3.8,1.5-7.2,3.6-8.2 c2.6-1.2,4.3-3.9,4.3-6.8v-7.5c0-12.2,10.4-23.6,26.4-29c2.9-1,4.9-3.6,5.1-6.6c1.1-15.6,11.6-27.9,24-27.9h50 c12.5,0.1,22.6,12.3,22.6,27.3c0,3.3,2.1,6.2,5.2,7.2c17,5.4,27.6,16.5,27.6,28.9v7.5c0,2.4,1.2,4.7,3.2,6.1 c3.3,2.3,4.7,5,4.7,8.8c0,3.6-0.8,8.5-4.7,11.3c-2,1.4-3.2,3.7-3.2,6.1c0,2.4,1.3,4.9,3.3,6.3h0c2.8,2,4.7,4.5,4.7,10.1 c0,4.2-1.8,8-4.7,10.1c-2,1.4-3.2,3.7-3.2,6.1c0,2.4,1.2,4.7,3.2,6.1c2.8,2,4.7,4.5,4.7,10.1c0,3.4-2.4,7.4-5.9,10 c-5.4,3.5-11.2,10.4-11.2,17.4v24.9c0,4.7,2,11.6,11.4,17.5c0.3,0.2,0.5,0.3,0.8,0.4c1.2,0.5,4.9,2.7,4.9,6.9V979.76z"
                    }
                }
            }

            Label {
                text: "parched"
                font.pointSize: 16
                font.family: "Comfortaa"
                color: Branding.styleString(Branding.SidebarText)
                Layout.fillWidth: true
            }
            Item {
                Layout.fillHeight: true
                Layout.preferredWidth: 35

                Rectangle {
                    color: systemPalette.highlight
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    height: parent.height
                    width: 5
                    z: 0
                }
            }
        }
    }
    Item {
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: list.height - list.contentHeight
        width: 35
        Rectangle {
            color: {
                if (ViewManager.currentStepIndex==list.count-1) {
                    return systemPalette.highlight;
                }
                return systemPalette.mid;
            }
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            height: parent.height
            width: 5
            z: 0
        }
    }
}
