document.addEventListener("turbolinks:load", function() {
    App.chat_room = App.cable.subscriptions.create({
        channel: "ChatRoomChannel",
        room_id: document.querySelector('#posts').getAttribute('data-room_id')
    }, {
        connected: function () {
            // Called when the subscription is ready for use on the server
        },
        disconnected: function () {
        },

        received: function (data) {
            let browsing_user = getBrowsingUser(document.cookie);
            if (data['let_guests_view_all'] === true ||
                browsing_user === data['poster'] ||
                browsing_user === data['room_host'] ||
                data['poster'] === data['room_host']) {
                if (data['distinguish_speaker'] === true) {
                    insertPost(html.distinguished(data));
                } else if (data['distinguish_speaker'] === false) {
                    insertPost(html.undistinguished(data));
                }
            }
        }
    });
});
