import QtQuick 2.12
import QtQuick.Window 2.12
import QtWebSockets 1.1
import QtQuick.Controls 2.14// for scrollview
import QtQuick.Layouts 1.14

Window {
    id: chatview
    visible: true
    width: 640
    height: 480
    property alias username: element.text
    property string msg: ""
    property string owner: ""
    property var message_list: []


    WebSocket{
        id:socket
        active: true
        url: "ws://localhost:8080"
        onTextMessageReceived: function(message){
            //console.log("Client Recieved:", message)
            message = JSON.parse(message)
            chatview.msg = message.text //capture incoming message from server
            chatview.owner = message.username //capture the sender of incoming message
            if (chatview.owner != chatview.username)
            {
                chatview.owner = message.username
            } else{
                chatview.owner = "(me)"
            }

            console.log(`${chatview.owner} says:${chatview.msg}`)//debugging message
            model.append({"username":chatview.owner,"txtmessage":chatview.msg})//append new element to list model
        }

    }

    Rectangle {
        id: rectangle
        width: Math.round(parent.width / 3)
        height: parent.height
        color: "#031942"
    }

    Text {
        id: element
        x: 412
        y: 9
        width: 31
        height: 24
        text: qsTr("Chat")
        font.pixelSize: 14
    }

    Rectangle {
        id: rectangle1
        x: 220
        y: 33
        width: 414
        height: 374
        color: "#f5f5f5"
        radius: 5
        border.width: 1
        border.color: "black"
        /////////////////////////////////////
        Component{ // creating view for messages
            id:delegate
            Item{
              id:item
              width:parent.width
              height:20

              Column{//lay down new messages
                anchors.fill:parent
                spacing:1

                    Row{ //lay down message components --> username and message

                      Label{
                         text: username+" : "
                         font.bold:true
                         font.pixelSize: 16
                      }

                      Label{
                         text: txtmessage
                         font.pixelSize: 16
                       }
                    }
                 }
            }
        }

        ListModel{
           id:model

           ListElement{ // initial dummy element
               username:"Admin"
               txtmessage:"Welcome to the Chat!"
           }
        }

        ScrollView {// to be able to scroll through messages
             id: chatTranscriptScroll
             anchors.fill: parent
             padding:5

             ListView{
                 width:parent.width
                 model:model // new data entry point
                 delegate:delegate
                 clip:true
             }
         }

    }

    Rectangle {
        id: rectangle2
        x: 219
        y: 413
        width: 299
        height: 61
        color: "#f4f4f4"
        radius: 5
        border.width: 1
        border.color: "black"

        TextInput {
            id: textmessage
            anchors.fill: parent
            text: qsTr("")
            font.pixelSize: 16
            clip:true
            padding:3

        }
    }

    Rectangle {
        id: send
        x: 529
        y: 413
        width: 105
        height: 67
        color: "#0a1539"
        radius: 5

        Text {
         id: element1
         anchors.centerIn: parent
         color: "#f7f7f7"
         text: qsTr("Send")
         font.pixelSize: 16

            }

        MouseArea {
            id: mouseArea
            anchors.fill : parent
            onClicked: {
                socket.sendTextMessage( JSON.stringify({username:chatview.username, text:textmessage.text}))
                textmessage.text = qsTr("")

            }
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
