//This file was created as an attempt to broadcast
//The file is not used in the project, but I would like to keep it in the repo
//for documentation purposes

const WebSocket = require('ws');
const uuid = require('uuid');
const {addUser, removeUser, getUser, getAllUser} = require('./utitility.js')

const wss = new WebSocket.Server({ port: 8080 });

var connected_users = {};


wss.on('connection', function connection(ws, request) {

  ws.client_id = uuid.v4();
  //addUser({id:ws.client_id, username:ws.username})//adds user to list of connected users
  ws.send(ws.client_id)
  //console.log(request)

  ws.on('message', function incoming(message) {
  	if (!message.textmsg){
  		message = JSON.parse(message)
  		var existingUsers = addUser({id:message.clientid, username:message.username})
  		// console.log(`New user added ${new_user}`)
  		wss.broadcast(existingUsers, message);
	}
	else{
			wss.clients.forEach((client)=>{
				console.log(message.textmsg)
				client.send(message.textmsg)
			})
	}


  	//user = getUser(ws.client_id)
    console.log('Received from: %s', message)
  })

  wss.broadcast = function broadcast(existingUsers,message){
  	console.log(`New user added ${message}`)
  	wss.clients.forEach(function each(client){
  		// this if for existing users.
  		// send the new user - username
  		if (client.client_id != message.clientid )
  		{	
  			client.send(message.username)
  			console.log(client.client_id)
  		}
  		// this is for the new user. send all the existing usernames.
  		else if (existingUsers && existingUsers.length > 0){
  			existingUsers.forEach((usr)=>{
  			client.send(usr)
  			})
  		}
  	})
  }

  ws.on('close', function(){
  	//deleted = removeUser(ws.client_id)
    console.log('client droped:', ws.client_id)
  });

});