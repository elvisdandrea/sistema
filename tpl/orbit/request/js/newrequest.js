$('#datetimepicker').datetimepicker({
    locale: 'pt-br',
    showTodayButton: false,
    //format: 'DD/MM/YYYY HH:mm',
    defaultDate: $('#delivery-date').val().replace(' ','T'),
    format: 'LLLL',
    date: new Date()
});