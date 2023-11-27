import QtQuick 2.15

Rectangle {
    id: root

    color: "#103e49"
    state: "onGround"
    onHeightChanged: {
        sizeChangeTimeout.restart();
    }
    states: [
        State {
            name: "onGround"

            PropertyChanges {
                target: rocket
                lift: 180
            }

            PropertyChanges {
                target: background
                anchors.topMargin: -root.height
                anchors.bottomMargin: 20
                opacity: 1
            }

            PropertyChanges {
                target: starfield.particleSystem
                paused: true
            }

            PropertyChanges {
                target: cometShowupTimeout
                running: false
            }

        },
        State {
            extend: "onGround"
            name: "nearGround"

            PropertyChanges {
                target: rocket
                lift: root.height / 2 + 150
            }

            PropertyChanges {
                target: smoke
                anchors.bottomMargin: -smoke.height / 2 + 100
            }

            PropertyChanges {
                target: background
                anchors.bottomMargin: -(root.height * 0.2)
                anchors.topMargin: -root.height + root.height * 0.2
            }

        },
        State {
            extend: "nearGround"
            name: "inAtmosphere"

            PropertyChanges {
                target: rocket
                showSmoke: false
            }

            PropertyChanges {
                target: rocket
                lift: root.height / 2 + 100
            }

            PropertyChanges {
                target: starfield.particleSystem
                paused: false
            }

            PropertyChanges {
                target: background
                anchors.bottomMargin: -root.height * 0.9
                anchors.topMargin: 0
            }

        },
        State {
            extend: "inAtmosphere"
            name: "inSpace"

            PropertyChanges {
                target: background
                anchors.bottomMargin: -(root.height * 2)
                anchors.topMargin: root.height
            }

            PropertyChanges {
                target: cometShowupTimeout
                running: true
            }

        }
    ]
    transitions: [
        Transition {
            id: transition1

            from: "onGround"
            to: "nearGround"

            SequentialAnimation {
                NumberAnimation {
                    target: rocket
                    property: "lift"
                    duration: 10000
                    easing.type: Easing.InQuad
                }

                ScriptAction {
                    script: root.state = "inAtmosphere"
                }

            }

            NumberAnimation {
                target: smoke
                property: "bottomMargin"
                duration: 10000
                easing.type: Easing.InQuad
            }

            NumberAnimation {
                target: background
                properties: "anchors.topMargin,anchors.bottomMargin"
                duration: 10000
                easing.type: Easing.InQuad
            }

        },
        Transition {
            id: transition2

            from: "nearGround"
            to: "inAtmosphere"

            NumberAnimation {
                target: rocket
                property: "lift"
                duration: 5000
                easing.type: Easing.OutQuad
            }

            SequentialAnimation {
                NumberAnimation {
                    target: background
                    properties: "anchors.topMargin,anchors.bottomMargin"
                    duration: 5000
                }

                ScriptAction {
                    script: root.state = "inSpace"
                }

            }

        },
        Transition {
            id: transition3

            from: "inAtmosphere"
            to: "inSpace"

            NumberAnimation {
                target: rocket
                property: "lift"
                duration: 3000
                easing.type: Easing.OutQuad
            }

            NumberAnimation {
                target: background
                properties: "anchors.bottomMargin"
                duration: 15000
                from: -root.height
            }

            NumberAnimation {
                target: background
                properties: "anchors.topMargin"
                duration: 15000
                from: 0
            }

        }
    ]

    QtObject {
        id: maxSceneSize

        property int width: 7680
        property int height: 4320
    }

    SystemPalette {
        id: systemPalette
    }

    Image {
        id: comet

        source: "comet.svg"
        opacity: 0

        sourceSize {
            width: 50
            height: 50
        }

        Timer {
            id: cometShowupTimeout

            running: true
            interval: 6000
            repeat: true
            onTriggered: {
                comet.x = Math.floor(Math.random() * root.width);
                comet.y = Math.floor(Math.random() * root.height);
                cometShowupAnimation.start();
            }
        }

        ParallelAnimation {
            id: cometShowupAnimation

            loops: 1

            SequentialAnimation {
                NumberAnimation {
                    target: comet
                    easing.type: Easing.InQuad
                    property: "opacity"
                    duration: 200
                    from: 0
                    to: 1
                }

                NumberAnimation {
                    target: comet
                    easing.type: Easing.OutQuad
                    property: "opacity"
                    duration: 200
                    from: 1
                    to: 0
                }

            }

            NumberAnimation {
                target: comet
                properties: "x"
                duration: 700
                easing.type: Easing.OutQuad
                to: comet.x - 60
            }

            NumberAnimation {
                target: comet
                properties: "y"
                duration: 700
                easing.type: Easing.OutQuad
                to: comet.y + 70
            }

        }

    }

    Starfield {
        id: starfield

        maxSceneSize: maxSceneSize
        anchors.fill: parent
    }

    Image {
        id: background

        anchors.fill: parent
        mipmap: true
        cache: false
        source: visible ? systemPalette.window.hslLightness > 0.5 ? "background.svg" : "background_dark.svg" : ""

        sourceSize {
            height: root.height
            width: root.width
        }

    }

    Item {
        id: smoke

        height: smokeAsset.paintedHeight

        anchors {
            bottom: parent.bottom
            right: parent.right
            left: parent.left
        }

        Rectangle {
            height: 57
            color: "#eff0f1"

            anchors {
                bottom: parent.bottom
                right: parent.right
                left: parent.left
            }

        }

        Image {
            id: smokeAsset

            source: "smoke.svg"
            sourceSize.width: width
            sourceSize.height: height

            anchors {
                bottom: parent.bottom
                horizontalCenter: parent.horizontalCenter
            }

        }

    }

    Rocket {
        id: rocket

        property int lift: 0

        width: 100
        showSmoke: true

        anchors {
            bottom: parent.bottom
            bottomMargin: -(height - lift)
            horizontalCenter: parent.horizontalCenter
            horizontalCenterOffset: -235
        }

    }

    // Animation objects don't bind properties - so we have to reset the animation when a window size changes. In our case it's only about height.
    // Timeout is needed to ensure that properties already have needed values set.
    Timer {
        id: sizeChangeTimeout

        interval: 1
        onTriggered: {
            switch (state) {
            case "nearGround":
                if (!transition1.running)
                    return ;

                state = "onGround";
                state = "nearGround";
                break;
            case "inAtmosphere":
                if (!transition2.running)
                    return ;

                state = "nearGround";
                state = "inAtmosphere";
                break;
            case "inSpace":
                if (!transition3.running)
                    return ;

                state = "inAtmosphere";
                state = "inSpace";
            }
        }
    }

}
