
document.getElementById('read64').addEventListener('change', readImage, false);

function readImage(evt){

    var f = evt.target.files[0];
    if (!f) return false;

    var r = new FileReader();

    r.onloadend = function(e) {
        var tempImg = new Image();
        tempImg.src = e.target.result;
        $("#product-img").attr("src",tempImg.src);
    }

    r.readAsDataURL(f);

}

