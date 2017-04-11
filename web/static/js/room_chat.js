let RoomChat = {
  init(socket, element){
    console.log('connecting to room')
    let roomChat = document.getElementById('room_chat')
    let roomMessages = document.getElementById('room_messages')
    let messageInput = document.getElementById('message_input')
    let submitButton  = document.getElementById('submit_button')
    let roomId = roomChat.dataset.roomId;
    debugger;
    let roomChannel = socket.channel("rooms:" + roomId)
    socket.connect()
    console.log('has been connected to the room')
    //socket.connect()
  }
}

export default RoomChat
