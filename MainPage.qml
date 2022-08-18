import QtQuick 2.0
import Felgo 3.0

Page {
    id: mainPage
    title: "Rechercher une ville"
    property alias city: textEdit.text

    Column {
        spacing: 10
        anchors {
            fill: parent
            margins: 20
        }
        AppTextField {
            id: textEdit
            anchors {
                left: parent.left
                right: parent.right
            }
            leftPadding: 16
            placeholderText: "Ville"
            font.pixelSize: 20
            color: "black"
            background: Rectangle {
                color: "transparent"
                border {
                    color: parent.focus ? "#aaaaaa" : "#d2d2d2"
                    width: 2
                }
            }
            onAccepted: myButtom.clicked()
        }
        AppButton {
            id: myButtom
            property string serverUrl: "https://api.openweathermap.org/data/2.5/forecast?cnt=10&units=metric&appid=78a770a0710b912a512870edeb762004&q="
            text: "Rechercher"
            width: parent.width
            horizontalMargin: 0
            textSize: 20
            backgroundColor: "#B64039"
            backgroundColorPressed : "#d00000"

            AppActivityIndicator {
                x: 16
                anchors.verticalCenter: parent.verticalCenter
                animating: HttpNetworkActivityIndicator.enabled
                hidesWhenStopped  : true
                color : "white"
            }
            onClicked: {
                var request = HttpRequest
                .get(serverUrl + mainPage.city)
                .timeout(5000)
                .then(function(res) {
                        if(res.status === 200) {
                        let len = res.body.list.length;
                        for (var i = 0; i < len; i++){
                            const date = new Date(res.body.list[i].dt *1000);
                            date.toLocaleDateString("fr-FR");
                            let days = ['Lun','Mar','Mer','Jeu','Ven','Sam','Dim'];
                            let src = res.body.list[i].weather
                            let type = res.body.list[i].weather[0].main.toLowerCase()
                            let t = ['clouds','rain'];
                            let iconW = t.indexOf(type)
                            if(iconW < 0) iconW = 2
                            dataModel.append({temp: Math.round(res.body.list[i].main.temp)
                                               , day: days[date.getDay()] + "."
                                               , date: date.getDate() + "/" + date.getMonth()
                                               , iconWeather: iconW})
                        }
                        mainPage.navigationStack.push(weatherPage)
                        }
                })
                .catch(function(err) {
                    console.log(err.message)
                    console.log(err.response)
                });
            }
        }
    }
}
