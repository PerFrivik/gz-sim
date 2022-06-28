/*
 * Copyright (C) 2022 Open Source Robotics Foundation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
*/

import QtQuick 2.9
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import QtQuick.Window 2.2

Rectangle {
  id: quickStart
  width: 720
  height: 720

  function changeDefault(checked){
    console.log("default changed to ", checked);
    QuickStartHandler.SetShowDefaultQuickStartOpts(checked);
  }

  function loadWorld(fileURL){
    openWorld.enabled = true;
    // Remove "file://" from the QML url.
    var url = fileURL.toString().split("file://")[1]
    QuickStartHandler.SetStartingWorld(url)
  }

  function loadFuelWorld(fileName, uploader){
    // Construct fuel URL
    var fuel_url = "https://app.gazebosim.org/"
    fuel_url += uploader + "/fuel/worlds/" + fileName
    QuickStartHandler.SetStartingWorld(fuel_url)
    quickStart.Window.window.close()
  }

  function getWorlds(){
    return "file://"+QuickStartHandler.WorldsPath()
  }

  RowLayout {
    id: layout
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.verticalCenter: parent.verticalTop
    spacing: 6

    ColumnLayout {
      id: localColumn
      Layout.minimumHeight: 100
      Layout.fillWidth: true
      spacing: 0
      Rectangle {
        color: 'grey'
          Layout.fillWidth: true
          Layout.minimumWidth: 100
          Layout.preferredWidth: 720
          Layout.minimumHeight: 150
          Image{
            source: "images/gazebo_horz_pos_topbar.svg"
            fillMode: Image.PreserveAspectFit
            x: (parent.width - width)  / 2 - width / 3
            y: (parent.height - height) / 2
          }
          Text{
            text: QuickStartHandler.GazeboVersion()
          }
      }

      Rectangle {
        color: 'transparent'
        Layout.fillWidth: true
        Layout.minimumWidth: 100
        Layout.preferredWidth: 700
        Layout.minimumHeight: 400
        RowLayout{
          ColumnLayout {
            Rectangle {
              Layout.topMargin: 10
              Layout.bottomMargin: 10
              color: 'transparent'
              Layout.preferredWidth: 500
              Layout.preferredHeight: 50
              Label {
                id: labelFuel
                text: qsTr("Choose a world to open")
                anchors.centerIn: parent
                color: "#443224"
                font.pixelSize: 16
              }
            }
            Rectangle {
              Layout.preferredWidth: 500
              Layout.preferredHeight: 350

              color: 'transparent'
              FolderListModel {
                id: folderModel
                showDirs: false
                nameFilters: ["*.png"]
                folder: getWorlds()+ "/thumbnails/"
              }

              Component {
                id: fileDelegate

                FuelThumbnail {
                  id: filePath
                  text: fileName.split('.')[1]
                  uploader: fileName.split('.')[0]
                  width: gridView.cellWidth - 5
                  height: gridView.cellHeight - 5
                  smooth: true
                  source: fileURL
                }
              }
              GridView {
                  id: gridView
                  width: parent.width
                  height: parent.height

                  anchors {
                      fill: parent
                      leftMargin: 5
                      topMargin: 5
                  }

                  cellWidth: width / 2
                  cellHeight: height / 2

                  model: folderModel
                  delegate: fileDelegate
                }
              }
            }

              ColumnLayout {
                Rectangle {
                  color: "transparent";
                  width: 200; height: 50
                  Layout.topMargin: 10

                  Label {
                    id: label
                    text: qsTr("Installed worlds")
                    anchors.centerIn: parent
                    color: "#443224"
                    font.pixelSize: 16
                  }
                }

                Rectangle {
                  color: "transparent";
                  width: 200; height: 180
                    
                  FolderListModel {
                      id: sdfsModel
                      showDirs: false
                      showFiles: true
                      folder: getWorlds()
                      nameFilters: [ "*.sdf" ]
                  }
                  ComboBox {
                    id: comboBox
                    currentIndex : -1
                    model: sdfsModel
                    textRole: 'fileName'
                    width: parent.width
                    onCurrentIndexChanged: quickStart.loadWorld(model.get(currentIndex, 'fileURL'))
                  }
                  MouseArea {
                    onClicked: comboBox.popup.close()
                  }
                }
                Rectangle { color: "transparent"; width: 200; height: 200 }
              }
          }
      }
      Rectangle {
        color: 'transparent'
        Layout.fillWidth: true
        Layout.minimumWidth: 100
        Layout.preferredWidth: 700
        Layout.minimumHeight: 100
      }

        Rectangle {
          color: 'transparent'
          Layout.fillWidth: true
          Layout.preferredWidth: 720
          Layout.minimumHeight: 50
          RowLayout {
            id: skip
            anchors.verticalCenter: parent.verticalTop
            spacing: parent.width/10
            Button {
              id: closeButton
              visible: true
              text: "Open Empty World"
              Layout.minimumWidth: parent.width/5
              Layout.leftMargin: parent.width/10

              onClicked: {
                quickStart.loadWorld("")
                quickStart.Window.window.close()
              }

              Material.background: Material.primary
              ToolTip.visible: hovered
              ToolTip.delay: tooltipDelay
              ToolTip.timeout: tooltipTimeout
              ToolTip.text: qsTr("Skip")
            }
            CheckBox {
              id: showByDefault
              text: "Don't show again"
              Layout.fillWidth: true
              onClicked: {
                quickStart.changeDefault(showByDefault.checked)
              }
            }
            Button {
              id: openWorld
              visible: true
              text: "Open World"
              enabled: false
              Layout.minimumWidth: closeButton.width
              Layout.rightMargin: parent.width/10

              onClicked: {
                quickStart.Window.window.close()
              }

              Material.background: Material.primary
              ToolTip.visible: hovered
              ToolTip.delay: tooltipDelay
              ToolTip.timeout: tooltipTimeout
              ToolTip.text: qsTr("Open World")
            }
          }
        }
    }
  }
}
