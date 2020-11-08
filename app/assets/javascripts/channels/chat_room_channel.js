document.addEventListener("turbolinks:load", function() {
    App.chat_room = App.cable.subscriptions.create({
        channel: "ChatRoomChannel",
        room_id: document.getElementById('posts').getAttribute('data-room_id')
    }, {
        // room_id: $('#posts').data('room_id'),
        connected: function () {
            // Called when the subscription is ready for use on the server
        },
        disconnected: function () {
        },

        received: function (data) {
            setDefaultPost(data);
            // let chat = document.querySelector('#fullIndex');
            // let newMessage = document.createElement('p');
            // newMessage.innerText = data['message'];
            // chat.appendChild(newMessage);
        }
    });
});

