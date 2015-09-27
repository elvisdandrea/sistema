$('input[format="currency"]').maskMoney();
Main.imageAction('read64', 'product-img');
$('#charac').select2({
    tags: true,
    tokenSeparators: [',']
});

var imgCount = 2;

$('#image-upload').change(function(evt){
    var url = $(this).attr('action');

    var f = evt.target.files[0];
    if (!f) return false;

    var r = new FileReader();

    r.onloadend = function(e) {
        var tempImg = new Image();
        tempImg.src = e.target.result;

        //Resize Image

        tempImg.onload = function() {

            var MAX_WIDTH = 640;
            var MAX_HEIGHT = 480;
            var tempW = tempImg.width;
            var tempH = tempImg.height;
            if (tempW > tempH) {
                if (tempW > MAX_WIDTH) {
                    tempH *= MAX_WIDTH / tempW;
                    tempW = MAX_WIDTH;
                }
                if (tempH > MAX_HEIGHT) {
                    tempW *= MAX_HEIGHT / tempH;
                    tempH = MAX_HEIGHT;
                }
            } else {
                if (tempH > MAX_HEIGHT) {
                    tempW *= MAX_HEIGHT / tempH;
                    tempH = MAX_HEIGHT;
                }
                if (tempW > MAX_WIDTH) {
                    tempH *= MAX_WIDTH / tempW;
                    tempW = MAX_WIDTH;
                }
            }
            var canvas = document.createElement('canvas');
            canvas.width = tempW;
            canvas.height = tempH;
            var ctx = canvas.getContext("2d");
            ctx.drawImage(this, 0, 0, tempW, tempH);
            var dataURL = canvas.toDataURL("image/jpeg");

            Html.Post(url, {img_data : dataURL}, function(r) {
                eval(r);
                if (changeUrl) window.history.pushState(undefined, '', changeUrl);
                return false;
            });
        }
    }
    r.readAsDataURL(f);
});

if(document.getElementById("img1") != null) {
    Main.imageAction('img1', 'product-img1');
}

$('#add-img').click(function(){
    var template = $('#product-image-template').html();

    $('#images-holder').append(template);
    $('#img-tpl').attr('id', 'product-img'+imgCount);
    $('#img-input-tpl').attr('id', 'img'+imgCount);
    Main.imageAction('img'+imgCount, 'product-img'+imgCount);
    imgCount = imgCount + 1;
});

$('#images-holder').sortable();

$('#images-holder-edit').sortable({
    stop: function( event, ui ) {
        var imageOrder = $('#images-holder-edit').sortable('toArray');
        var url = $('#images-holder-edit').attr('data-url');

        Html.Post(url, {images_order : imageOrder}, function(r) {
            eval(r);
            if (changeUrl) window.history.pushState(undefined, '', changeUrl);
            return false;
        });
    }
});
