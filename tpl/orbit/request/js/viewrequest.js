$('input#delivery-date').datetimepicker({
    locale: 'pt-br',
    showTodayButton: false,
    //format: 'DD/MM/YYYY HH:mm',
//    defaultDate: $('#delivery-date').val().replace(' ','T'),
    format: 'LLLL',
    date: $('#delivery-date').val().replace(' ','T')
}).on('dp.change', function(e){
    Html.Post(
        $('#delivery-date').attr('data-setvalue'),
        {newdate: e.date._d.toLocaleString()},
        function(a){
            //eval(a);
            return false;
        }
    );
});

$(function() {
    $('input[type="checkbox"].select-itens, input[type="radio"].select-itens').iCheck({
        checkboxClass: 'icheckbox_select-itens',
        radioClass: 'iradio_select-itens'
    });
});