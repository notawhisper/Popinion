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
            var chat = document.getElementById('fullIndex');
            var newMessage = document.createElement('p');
            newMessage.innerText = data['message'];
            // newMessage.innerText = data['message'];
            chat.appendChild(newMessage);
            // Called when there's incoming data on the websocket for this channel
        }

        // speak: function(message) {
        //     return this.perform('speak', { message: message });
        // }
    });
});

