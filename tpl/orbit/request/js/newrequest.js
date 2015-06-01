$('input#datetimepicker').datetimepicker({
    locale: 'pt-br',
    showTodayButton: false,
    //format: 'DD/MM/YYYY HH:mm',
    defaultDate: $('#delivery-date').val().replace(' ','T'),
    format: 'LLLL',
    date: new Date()
}).on('dp.change', function(e){
    $('#delivery-date').val(e.date._d.toLocaleString());
    return false;
});

var date = new Date();
$('#delivery-date').val(date.toLocaleString());

$(document).on('mouseup', 'a[data-focus]', function(){
    $('#' + $(this).attr('data-focus')).val('');
    $('#' + $(this).attr('data-focus')).focus();
    return false;
});

$(document).on('click', '#newclientbtn', function() {
    $('#clientresult').remove();
    return false;
});