/**
 * Created by Luiz on 17/05/2015.
 */

$('#fb-search-modal').modal('show');

function populateData(uid){
    $.ajax({
        type: "GET",
        url: "fbGetUserData",
        dataType : 'JSON',
        data: {user: uid},
        success: function (data) {
            console.log(data);
            $('#fb-search-modal').modal('hide');
            $('input[name="client_name"]').val(data.name);
            $('#client-img').attr('src', 'data:image/jpeg;base64,'+data.image);
        }
    });
}