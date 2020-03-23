import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebSockets 1.1
//import "../nodejs-websocket-server/index.js" as Ws_server

//first letter needs to be capital for a qualified import
//added bin folder to the path environment variable to make things work

Window {
    id:root
    visible: true
    width: 640
    height: 480
    color: "#828282"
    title: qsTr("Chat Coding Challenge")


    Loader {
            id: windowLoader
            anchors.fill: parent
        }


    Text {
        id: element
        anchors.centerIn: parent
        width: 109
        height: 48
        text: qsTr("Enter Username")
        font.pixelSize: 16
    }


    Rectangle {
        id: rectangle
        x: 108
        y: 262
        width: 275
        height: 75
        color: "#ffffff"

        TextInput {
            id: textInput
            anchors.fill:parent
            padding: 5
            width: parent.width
            height: parent.height
            text: qsTr("")
            font.pixelSize: 16
            onAccepted: console.log(text)
        }
    }


    Rectangle {
        id: submit
        x: 420
        y: 262
        width: 129
        height: 75
        color: "#bfbfbf"

        Text {
            id: element1
            anchors.centerIn: submit
            text: qsTr("Submit")
            font.pixelSize: 16
        }

        MouseArea{
            anchors.fill: parent
            onClicked: {

               console.log(textInput.text)
               var component= Qt.createComponent("ChatView.qml")//creates new component
               var loadwin = component.createObject(root,{"username":textInput.text})//send data to component
               loadwin.show()//opens up chatview.qml

               root.visible = false
            }
        }
    }

}
