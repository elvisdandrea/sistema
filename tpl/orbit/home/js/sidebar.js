$('#daterange-btn').daterangepicker(
    {
        ranges: {
            'Hoje': [moment(), moment()],
            'Ontem': [moment().subtract('days', 1), moment().subtract('days', 1)],
            'Últimos 7 dias': [moment().subtract('days', 6), moment()],
            'Últimos 30 dias': [moment().subtract('days', 29), moment()],
            'Esse mês': [moment().startOf('month'), moment().endOf('month')],
            'Mês passado': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
        },
        startDate: moment().subtract('days', 29),
        endDate: moment()
    },
    function(start, end) {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    }
);

//iCheck for checkbox and radio inputs
$('input[type="checkbox"].minimal, input[type="radio"].minimal').iCheck({
    checkboxClass: 'icheckbox_minimal',
    radioClass: 'iradio_minimal'
});
//Red color scheme for iCheck
$('input[type="checkbox"].minimal-red, input[type="radio"].minimal-red').iCheck({
    checkboxClass: 'icheckbox_minimal-red',
    radioClass: 'iradio_minimal-red'
});
//Flat red color scheme for iCheck
$('input[type="checkbox"].flat-red, input[type="radio"].flat-red').iCheck({
    checkboxClass: 'icheckbox_flat-red',
    radioClass: 'iradio_flat-red'
});