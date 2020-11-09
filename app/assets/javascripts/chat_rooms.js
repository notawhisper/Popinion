const getBrowsingUser = (cookie) => {
    let cookies = cookie;
    let cookiesArray = cookies.split('; ');
    let value = null;
    for (let c of cookiesArray) {
        let cookieArray = c.split('=');
        if( cookieArray[0] === "browsing_id"){
            value = cookieArray[1];
        }
    }
    let browsing_user = Number(value);
    return browsing_user;
};

const toDoubleDigits = (num) => {
    num += "";
    if (num.length === 1) {
        num = "0" + num;
    }
    return num;
};

const getCreatedAt = (date) => {
    let targetDate = new Date(date);
    let yyyy = targetDate.getFullYear();
    let mm = toDoubleDigits(targetDate.getMonth() + 1);
    let dd = toDoubleDigits(targetDate.getDate());
    let hh = toDoubleDigits(targetDate.getHours());
    let mi = toDoubleDigits(targetDate.getMinutes());
    let dayOfWeek = targetDate.getDay();
    let dayOfWeekStr = [ "日", "月", "火", "水", "木", "金", "土" ][dayOfWeek];
    let createdAt = `${yyyy}年` +
        `${mm}月` +
        `${dd}日` +
        `(${dayOfWeekStr}) ` +
        `${hh}時`+
        `${mi}分`;
    return createdAt;
};

const html =  {
    distinguished: (data) => {
     let target = '<div class="card">' +
         '<div class="card-header py-1">' +
         '<div class="row">' +
         '<div class="col-4">' +
         `Code: ${data['code_number']}` +
         '</div>' +
         '<div class="col-8 text-right small">' +
         `${getCreatedAt(data['date'])}` +
         '</div>' +
         '</div>' +
         '</div>' +
         '<div class="card-body py-2 text-monospace">' +
         `${data['message']}` +
         '</div>' +
         '</div>';
     return target;
    },
    undistinguished: (data) => {
     let target = '<div class="card">' +
         '<div class="card-header py-1">' +
         '<div class="row">' +
         '<div class="col-12 text-left small">' +
         `${getCreatedAt(data['date'])}` +
         '</div>' +
         '</div>' +
         '</div>' +
         '<div class="card-body py-2 text-monospace">' +
         `${data['message']}` +
         '</div>' +
         '</div>';
     return target;
    }
};

const insertPost = (html) => {
    let targetParent = document.querySelector('#fullIndex');
    targetParent.insertAdjacentHTML('beforeend', html);
};

