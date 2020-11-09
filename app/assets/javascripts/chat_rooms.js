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
    let dayOfWeekStr = [ "日", "月", "火", "水", "木", "金", "土" ][dayOfWeek] ;
    let createdAt = `${yyyy}年` +
        `${mm}月` +
        `${dd}日` +
        `(${dayOfWeekStr}) ` +
        `${hh}時`+
        `${mi}分`;
    return createdAt;
}


const setDefaultPost = (data) => {
    let html = '<div class="card">' +
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
    let targetParent = document.querySelector('#fullIndex');
    targetParent.insertAdjacentHTML('beforeend', html);
};
