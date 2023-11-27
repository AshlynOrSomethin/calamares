import QtQuick 2.15
import QtQuick.Particles 2.15

Item {
    id: root

    property var particleSystem
    property var maxSceneSize

    Item {
        id: emmitterContainer

        anchors.top: parent.top
        anchors.topMargin: -300
        width: maxSceneSize.width

        Emitter {
            id: closeEmitter

            group: "close"
            anchors.fill: parent
            system: particleSystem
            emitRate: 40
            lifeSpan: (maxSceneSize.height + (-emmitterContainer.anchors.topMargin)) / (velocity.magnitude - velocity.magnitudeVariation) * 1000
            size: 25
            sizeVariation: 8

            velocity: AngleDirection {
                angle: 90
                angleVariation: 0
                magnitude: 90
                magnitudeVariation: 0
            }

        }

        Emitter {
            id: farEmitter

            group: "far"
            anchors.fill: parent
            system: particleSystem
            emitRate: 40
            lifeSpan: (maxSceneSize.height + (-emmitterContainer.anchors.topMargin)) / (velocity.magnitude - velocity.magnitudeVariation) * 1000
            size: 5
            sizeVariation: 1

            velocity: AngleDirection {
                angle: 90
                angleVariation: 0
                magnitude: 60
                magnitudeVariation: 0
            }

        }

        Emitter {
            id: moonEmitter

            group: "moon"
            anchors.fill: parent
            anchors.topMargin: -100
            system: particleSystem
            emitRate: 0.1
            lifeSpan: (maxSceneSize.height + (-emmitterContainer.anchors.topMargin)) / (velocity.magnitude - velocity.magnitudeVariation) * 1000
            size: 200
            sizeVariation: 100

            velocity: AngleDirection {
                angle: 90
                angleVariation: 0
                magnitude: 240
                magnitudeVariation: 50
            }

        }

    }

    ImageParticle {
        groups: ["far"]
        entryEffect: ImageParticle.None
        system: particleSystem
        source: "star_far.svg"
    }

    ImageParticle {
        groups: ["close"]
        entryEffect: ImageParticle.None
        system: particleSystem
        source: "star_close.svg"
    }

    ImageParticle {
        groups: ["moon"]
        entryEffect: ImageParticle.None
        system: particleSystem
        source: "moon.svg"
    }

    particleSystem: ParticleSystem {
        id: particleSystem
    }

}
