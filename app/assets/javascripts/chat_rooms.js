const setDefaultPost = (data) => {
    let html = '<div class="card">' +
        '<div class="card-header py-1">' +
        '<div class="row">' +
        '<div class="col-4">' +
        `Code: ${data['code_number']}` +
        '</div>' +
        '<div class="col-8 text-right small">' +
        `${data['date']}` +
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
