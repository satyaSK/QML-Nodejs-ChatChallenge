const WebSocket = require('ws');
const uuid = require('uuid');
const {addUser, removeUser, getUser, getAllUser} = require('./utils.js')

const wss = new WebSocket.Server({ port: 8080 });


wss.on('connection', function connection(ws, request) {

  ws.client_id = uuid.v4();
  //new_user = addUser(ws.client_id)//adds user to list of connected users
  //console.log(new_user)
  //ws.send(ws.client_id)
  //console.log(request)

  ws.on('message', function incoming(message) {
 		//user = getUser(ws.client_id)
    console.log('(SERVER Says) Received: %s', message)//send message to all users
    wss.clients.forEach((client) => {
	        client.send(message)
	        console.log(`***Sent to: ${client}`)	
	})

  })


  ws.on('close', function(){
  	//deleted = removeUser(ws.client_id)
    console.log('client droped:', ws.client_id)
  });

});