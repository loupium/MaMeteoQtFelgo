import QtQuick 2.3
import Felgo 3.0

Component {
    id: weatherPage
    Page {
        title: "Météo/" + mainPage.city

        AppListView {
            anchors.fill: parent
            model: dataModel
            delegate: WeatherDelegate {
            }
        }
    }
}
