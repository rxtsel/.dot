import QtQuick
import QtQuick.Layouts
import qs.Commons
import qs.Services.Hardware
import qs.Widgets

// Brightness control card for all displays in the ControlCenter
NBox {
  id: root

  Layout.fillWidth: true
  clip: true

  property real localBrightness: 0
  property bool localBrightnessChanging: false

  readonly property var controllableMonitors: BrightnessService.monitors.filter(m => m.brightnessControlAvailable)
  readonly property bool brightnessControlAvailable: controllableMonitors.length > 0

  function averageBrightness(): real {
    if (controllableMonitors.length === 0)
      return 0;

    var total = 0;
    for (var i = 0; i < controllableMonitors.length; i++) {
      total += controllableMonitors[i].brightness || 0;
    }
    return total / controllableMonitors.length;
  }

  function syncFromMonitors(): void {
    if (!localBrightnessChanging) {
      localBrightness = averageBrightness();
    }
  }

  function setAllBrightness(value: real): void {
    for (var i = 0; i < controllableMonitors.length; i++) {
      controllableMonitors[i].setBrightnessDebounced(value);
    }
  }

  Component.onCompleted: syncFromMonitors()

  Connections {
    target: BrightnessService
    function onMonitorBrightnessChanged(monitor, newBrightness) {
      root.syncFromMonitors();
    }
  }

  Timer {
    id: debounceTimer
    interval: 100
    running: false
    repeat: false
    onTriggered: root.setAllBrightness(root.localBrightness)
  }

  RowLayout {
    anchors.fill: parent
    anchors.margins: Style.marginM
    spacing: Style.marginM

    ColumnLayout {
      spacing: Style.marginXXS
      Layout.fillWidth: true
      Layout.preferredWidth: 0
      opacity: root.brightnessControlAvailable ? 1.0 : 0.5
      enabled: root.brightnessControlAvailable

      RowLayout {
        Layout.fillWidth: true
        spacing: Style.marginXS

        NIconButton {
          icon: {
            if (root.localBrightness <= 0.001)
              return "sun-off";
            return root.localBrightness <= 0.5 ? "brightness-low" : "brightness-high";
          }
          baseSize: Style.baseWidgetSize * 0.5
          colorFg: Color.mOnSurface
          colorBg: "transparent"
          colorBgHover: Color.mHover
          colorFgHover: Color.mOnHover
        }

        NText {
          text: root.controllableMonitors.length > 1
            ? `${I18n.tr("common.brightness")} (${root.controllableMonitors.length} displays)`
            : I18n.tr("common.brightness")
          pointSize: Style.fontSizeXS
          color: Color.mOnSurfaceVariant
          elide: Text.ElideRight
          Layout.fillWidth: true
          Layout.preferredWidth: 0
        }

        NText {
          text: root.brightnessControlAvailable ? Math.round(root.localBrightness * 100) + "%" : "N/A"
          pointSize: Style.fontSizeXS
          color: Color.mOnSurfaceVariant
          opacity: root.brightnessControlAvailable ? 1.0 : 0.5
        }
      }

      NSlider {
        id: brightnessSlider
        Layout.fillWidth: true
        from: 0
        to: 1
        value: root.localBrightness
        stepSize: 0.01
        heightRatio: 0.5
        onMoved: {
          root.localBrightness = value;
          debounceTimer.restart();
        }
        onPressedChanged: root.localBrightnessChanging = pressed
        tooltipText: `${Math.round(root.localBrightness * 100)}%`
        tooltipDirection: "bottom"

        MouseArea {
          anchors.fill: parent
          hoverEnabled: true
          acceptedButtons: Qt.NoButton
          propagateComposedEvents: true

          onWheel: wheel => {
            if (brightnessSlider.enabled && root.brightnessControlAvailable) {
              const delta = wheel.angleDelta.y || wheel.angleDelta.x;
              const step = Settings.data.brightness.brightnessStep / 100.0;
              const increment = delta > 0 ? step : -step;
              root.localBrightness = Math.max(0, Math.min(1, root.localBrightness + increment));
              debounceTimer.restart();
            }
          }
        }
      }
    }
  }
}
