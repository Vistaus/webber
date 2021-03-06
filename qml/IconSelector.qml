import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.2
import QtQuick.Controls.Suru 2.2
import Ubuntu.Components 1.3 as UUITK

RowLayout {
    id: iconSelector

    readonly property bool useScreenshotIcon: iconScreenshot.checked
    readonly property bool useCustomIcon: iconCustom.checked
    property string screenshotIconPath
    property url defaultIconUrl: Qt.resolvedUrl("")
    property url customIconSource

    signal customIconRequested()

    function setUrl(url) {
        iconWebView.setUrl(url);
    }

    function loadDefaults() {
        iconWebView.setUrl(Qt.resolvedUrl(""));
        iconDefault.checked = true;
    }

    spacing: units.gu(1)

    ButtonGroup {
        buttons: [
            iconDefault.radioButton,
            iconScreenshot.radioButton,
            iconCustom.radioButton
        ]
    }

    IconSelectItem {
        id: iconDefault
        /// i18n: Label below the icon selection
        text: i18n.tr("Default")
        helpText: i18n.tr("Icon specified in website meta data")
        source: defaultIconUrl
        checked: true
    }

    IconSelectItem {
        id: iconScreenshot
        /// i18n: Label below the icon selection
        text: i18n.tr("Screenshot")
        source: iconWebView.source
        loading: iconWebView.loading
    }

    IconSelectItem {
        id: iconCustom
        /// i18n: Label below the icon selection
        text: i18n.tr("Custom")
        source: iconSelector.customIconSource
        onIconClicked: {
            iconSelector.customIconRequested();
        }
    }

    IconWebView {
        id: iconWebView
        screenshotIconPath: iconSelector.screenshotIconPath
    }
}
