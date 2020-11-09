document.addEventListener("turbolinks:load", function() {
    App.chat_room = App.cable.subscriptions.create({
        channel: "ChatRoomChannel",
        room_id: document.querySelector('#posts').getAttribute('data-room_id')
    }, {
        // room_id: $('#posts').data('room_id'),
        connected: function () {
            // Called when the subscription is ready for use on the server
        },
        disconnected: function () {
        },

        received: function (data) {
            if (data['distinguish_speaker'] === 'true') {
                insertPost(html.distinguished(data));
            } else if (data['distinguish_speaker'] === 'false') {
                insertPost(html.undistinguished(data));
            }
        }
    });
});
