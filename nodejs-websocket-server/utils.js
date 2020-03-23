//Utils file for adding users, removing users and getting specific users with specific id

const connected_users = []


const addUser = ({id,username})=>{

    username = username.trim().toLowerCase()
    if(!username){
        return {
            error: "Username & Room is required"
        }
    }

    const existingUser = connected_users.find((user)=>{
        return user.username 
    })

    if (existingUser){
        return {
            error:"Username already taken!"
        }
    }

    const new_user = {id,username,room}
    connected_users.push(new_user)
    return { new_user }
}

const removeUser = (id)=>{
    const index = connected_users.findIndex((user)=>{
        return user.id === id
    })

    if(index!=-1){
        return connected_users.splice(index, 1)[0]
    }
}

const getUser = (id) => {
    const fetched_user = connected_users.find((user)=> user.id === id)
    if(!fetched_user){
        return undefined
    }
    else{
        return fetched_user
    }
}




module.exports = {
    addUser,
    removeUser,
    getUser
}
