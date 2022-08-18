import QtQuick 2.0
import Felgo 3.0

Component {
    id: weatherPage
    Page {
        title: "Météo/" + mainPage.city
        property Page target: null

        AppListView {
            anchors.fill: parent
            model: dataModel
            delegate: Rectangle {
                id: myDelegate
                width: parent.width
                height: _row.height + 20
                color: "#394163"
                border.color: "#202340"

                Item {
                    id: _row
                    x: 20;
                    height: childrenRect.height
                    Icon {
                        id: _icon
                        icon: iconWeather === 0 ? IconType.cloud : (iconWeather === 1 ? IconType.clouddownload : IconType.suno);
                        size : 50
                        anchors {
                            top: _row.top
                            topMargin: 10
                        }
                        color: "white"
                    }
                    Row {
                        id: _date
                        height: childrenRect.height
                        anchors {
                            verticalCenter: _icon.verticalCenter
                            left: _icon.right
                            leftMargin: 20
                            top: undefined
                        }
                        spacing: 10

                        AppText {
                            text: day
                            font.bold: true
                        }
                        AppText {
                            id: _d
                            text: date
                            color: "black"
                        }
                    }
                }

                AppText {
                    id: _temp
                    font.pixelSize:  22
                    font.bold: true
                    text: temp + "°C"
                    scale: 1
                    anchors {
                        verticalCenter: parent.verticalCenter
                        right: parent.right
                        rightMargin : 20
                    }
                }

                states: State {
                    when: index === myDelegate.ListView.view.currentIndex
                    AnchorChanges {
                        target: _date
                        anchors.verticalCenter: undefined
                        anchors.left: _row.left
                        anchors.top: _row.top
                    }
                    PropertyChanges {
                        target: _date
                        anchors.leftMargin: 0
                        anchors.topMargin: 10
                    }
                    AnchorChanges { target: _icon; anchors.top: _date.bottom }
                    PropertyChanges {
                        target: _icon
                        anchors.topMargin: 10
                        size: 90
                    }
                    PropertyChanges { target: myDelegate; color: "#e54b65" }
                    PropertyChanges { target: _d; color: "white" }
                    PropertyChanges { target: _temp; font.pixelSize: 35 }
                }

                Component.onCompleted: showAnim.start();
                SequentialAnimation {
                    id: showAnim
                    running: false
                    NumberAnimation {
                        target: myDelegate;
                        property: "x";
                        from: 200 + index * 100;
                        to: 0;
                        duration: 1000
                        easing.type: Easing.OutBack;
                    }
                }
            }
        }
    }
}

