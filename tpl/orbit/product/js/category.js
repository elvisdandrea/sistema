function openEdit(id, e) {
    e.preventDefault();
    e.stopPropagation();
    $('#edit' + id + ' label').hide();
    $('#edit' + id + ' input').show();
    $('#edit' + id + ' input').focus();
    return false;
}

function updateCategory(id, value, e, url) {
    e.preventDefault();
    e.stopPropagation();
    if (e.keyCode == 27) {
        $('#edit' + id + ' label').show();
        $('#edit' + id + ' input').hide();
        return false;
    }

    if (e.keyCode != 13) return false;

    Html.Post(url, {
        id   : id,
        value: value
    }, function(a){
        eval(a);
        return false;
    });

    return false;

}