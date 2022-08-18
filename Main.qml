import Felgo 3.0
import QtQuick 2.7
import QtQml.Models 2.11
import QtQuick.Controls 1.4

App {
    onInitTheme: {
        Theme.navigationBar.backgroundColor = "#B64039"
        Theme.navigationTabBar.backgroundColor = "#B64039"
        Theme.navigationTabBar.titleColor = "white"
        Theme.navigationTabBar.titleDisabledColor = "white"
        Theme.navigationTabBar.titleOffColor = "#cccccc"
        Theme.colors.textColor = "white"
        ThemeColors.textColors = "white"
    }
    Component.onCompleted: {
        HttpNetworkActivityIndicator.activationDelay = 0
    }

    Navigation {
        navigationMode: navigationModeTabsAndDrawer

        NavigationItem {
            title: "Home"
            icon: IconType.home

            NavigationStack {
                ListModel { id: dataModel }
                MainPage {
                    id: mainPage
                }
                WeatherPage {
                    id: weatherPage
                }

                transitionDelegate: StackViewDelegate {
                    function getTransition(properties) {
                        return (properties.enterItem.Stack.index === 0) ? horizontalTransition : 0
                    }
                    property Component horizontalTransition: StackViewTransition {
                        PropertyAnimation {
                            target: exitItem
                            property: "x"
                            from: 0
                            to: target.width
                            duration: 300
                        }
                    }
                }
            }
        }
        NavigationItem {
            icon: IconType.user

            NavigationStack {
                Page {
                    title: "A propos"
                }
            }
        }
    }
}
