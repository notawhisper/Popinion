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
            let cookies = document.cookie;
            let cookiesArray = cookies.split('; ');
            let value = null;
            for (let c of cookiesArray) {
                let cookieArray = c.split('=');
                if( cookieArray[0] === "browsing_id"){
                    value = cookieArray[1];
                }
            }
            let browsing_user = Number(value);
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
