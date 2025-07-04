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
                        //path: "M 14.28571,0 C 6.37556,0 0,6.375557 0,14.285714 V 185.71428 C 0,193.62444 6.37556,200 14.28571,200 H 57.14286 V 57.142856 h 71.42857 V 0 Z m 128.57144,0 v 200 h 42.85714 C 193.62445,200 200,193.62444 200,185.71428 V 14.285714 C 200,6.375557 193.62445,0 185.71429,0 Z M 71.42857,71.42857 V 200 h 57.14286 V 71.42857 Z m 0,0"
                        // twin towers path: "M 14.28571,0 C 6.37556,0 0,6.375557 0,14.285714 V 185.71428 C 0,193.62444 6.37556,200 14.28571,200 H 57.14286 V 57.142856  V 0 Z m 128.57144,0 v 200 h 42.85714 C 193.62445,200 200,193.62444 200,185.71428 V 14.285714 C 200,6.375557 193.62445,0 185.71429,0 Z M 71.42857,71.42857 h 57.14286 V 71.42857 Z m 0,0"
                        //path: "M502.209,57.021L454.968,9.779c-13.023-13.022-34.216-13.023-47.24,0.001l-30.367,30.367 c-32.091-21.308-76.273-18.21-105.113,10.631l-47.24,47.241c-10.469,10.469-15.321,24.456-14.57,38.191l-41.722,41.722 c-13.735-0.75-27.721,4.1-38.19,14.569c-5.666,5.666-110.549,110.55-115.874,115.874c-19.537,19.536-19.537,51.324,0,70.861 l118.101,118.1c19.537,19.537,51.324,19.536,70.86,0c5.328-5.328,110.207-110.205,115.875-115.873 c10.468-10.469,15.32-24.455,14.569-38.19l41.722-41.722c14.237,0.778,28.054-4.435,38.19-14.57l47.24-47.24 c28.857-28.857,31.929-73.038,10.631-105.112l30.365-30.365C515.262,91.21,515.266,70.076,502.209,57.021z M179.995,473.716 c-6.529,6.528-17.092,6.528-23.62,0L38.273,355.615c-6.526-6.526-6.528-17.093,0-23.621l45.014-45.014l141.721,141.722 L179.995,473.716z M295.869,357.841l-47.241,47.241L106.907,263.36l47.24-47.24c6.513-6.513,17.11-6.512,23.621-0.001 L295.869,334.22C302.381,340.733,302.381,351.33,295.869,357.841z M319.489,310.6L201.388,192.499l23.62-23.62l118.101,118.1 L319.489,310.6z M437.591,216.12l-47.24,47.24c-6.512,6.512-17.107,6.513-23.62,0L248.628,145.259 c-6.513-6.513-6.513-17.108,0-23.621l47.241-47.24c19.585-19.585,51.276-19.584,70.86,0l70.861,70.861 C457.172,164.841,457.174,196.534,437.591,216.12z M449.4,109.83c-5.006-5.006-42.233-42.234-47.24-47.241L431.348,33.4 l47.24,47.241L449.4,109.83z"
                        //path: "M8,0L8,20L5.429,20C4.638,20 4,19.362 4,18.571L4,1.429C4,0.638 4.638,0 5.429,0L8,0ZM12,10L12,0L14.571,0C15.362,0 16,0.638 16,1.429L16,8.571C16,9.362 15.362,10 14.571,10L12,10ZM8,7C8,7 9.126,6.408 9.584,6.322C9.564,6.238 9.553,6.146 9.554,6.051L9.554,6.03C9.564,5.624 9.776,5.312 10.026,5.333C10.276,5.354 10.471,5.701 10.461,6.107C10.459,6.184 10.45,6.257 10.435,6.325C10.888,6.414 11.375,6.639 12,7C11.877,6.773 11.767,6.568 11.661,6.373C11.496,6.245 11.323,6.078 10.971,5.897C11.213,5.96 11.386,6.033 11.522,6.114C10.453,4.124 10.366,3.86 10,3C9.822,3.436 9.714,3.722 9.516,4.146C9.637,4.274 9.787,4.424 10.029,4.594C9.768,4.487 9.591,4.379 9.458,4.267C9.231,4.74 8,7 8,7Z"
                        path: "M8,10l6.571,0c0.791,0 1.429,-0.638 1.429,-1.429l-0,-7.142c-0,-0.791 -0.638,-1.429 -1.429,-1.429l-9.142,0c-0.791,0 -1.429,0.638 -1.429,1.429l-0,17.142c-0,0.791 0.638,1.429 1.429,1.429l2.571,-0l0,-13c0.807,-1.449 1.204,-2.203 1.458,-2.733c0.133,0.112 0.31,0.22 0.571,0.327c-0.242,-0.17 -0.392,-0.32 -0.513,-0.448c0.198,-0.424 0.306,-0.71 0.484,-1.146c0.366,0.86 0.453,1.124 1.522,3.114c-0.136,-0.081 -0.309,-0.154 -0.551,-0.217c0.352,0.181 0.525,0.348 0.69,0.476c0.106,0.195 0.216,0.4 0.339,0.627c-0.625,-0.361 -1.112,-0.586 -1.565,-0.675c0.015,-0.068 0.024,-0.141 0.026,-0.218c0.01,-0.406 -0.185,-0.753 -0.435,-0.774c-0.25,-0.021 -0.462,0.291 -0.472,0.697l-0,0.021c-0.001,0.095 0.01,0.187 0.03,0.271c-0.458,0.086 -0.95,0.312 -1.584,0.678"
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
