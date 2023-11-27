import QtQuick 2.15

Item {
    property bool showSmoke: false

    Item {
        id: rocketNoSmoke

        property bool rocketFrame: false

        visible: !showSmoke
        width: 250
        height: Math.min(rocket_a.paintedHeight, rocket_b.paintedHeight)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top

        Timer {
            interval: 200
            running: !showSmoke
            repeat: true
            onTriggered: rocketNoSmoke.rocketFrame = !rocketNoSmoke.rocketFrame
        }

        Image {
            id: rocket_a

            opacity: rocketNoSmoke.rocketFrame ? 1 : 0
            width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "rocket_a.svg"
        }

        Image {
            id: rocket_b

            opacity: rocketNoSmoke.rocketFrame ? 0 : 1
            width: parent.width
            fillMode: Image.PreserveAspectFit
            source: "rocket_b.svg"
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                breakAnimation.start();
            }
        }

    }

    Image {
        id: rocketSmoke

        opacity: showSmoke ? 1 : 0
        width: 250
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        fillMode: Image.PreserveAspectFit
        cache: false
        source: showSmoke ? "rocket_smoke.svg" : ""

        Behavior on opacity {
            NumberAnimation {
            }

        }

    }

}
