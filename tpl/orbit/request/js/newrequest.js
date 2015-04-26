$('#datetimepicker').datetimepicker({
    locale: 'pt-br',
    showTodayButton: false,
    //format: 'DD/MM/YYYY HH:mm',
    defaultDate: $('#delivery-date').val().replace(' ','T'),
    format: 'LLLL',
    date: new Date()
}).on('dp.change', function(e){
    $('#delivery-date').val(e.date._d.toLocaleString());
});

var date = new Date();
$('#delivery-date').val(date.toLocaleString());