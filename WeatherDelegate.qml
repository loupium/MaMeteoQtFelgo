import QtQuick 2.3
import Felgo 3.0

Rectangle {
    id: myDelegate
    width: parent.width
    height: _grid.height + 20
    color: "#394163"
    border.color: "#202340"

    Grid {
        id: _grid
        x: 20; y: 10
        height: childrenRect.height
        layoutDirection: Qt.RightToLeft
        columns: 2
        spacing: 20
        horizontalItemAlignment : Grid.AlignHCenter
        verticalItemAlignment : Grid.AlignVCenter
        Row {
            id: _date
            height: childrenRect.height
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
        Icon {
            id: _icon
            icon:  [IconType.cloud , IconType.clouddownload , IconType.suno][iconWeather]
            ;
            size : 50
            color: "white"
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
        when: myDelegate.ListView.isCurrentItem
        PropertyChanges {
            target: _grid
            columns: 1
            spacing: 10
        }
        PropertyChanges {
            target: _icon
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
