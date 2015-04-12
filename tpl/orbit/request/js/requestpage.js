$(function() {
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
});


$(function() {
    $(".datemask").inputmask("dd/mm/yyyy", {"placeholder": "dd/mm/aaaa"});
});

var colorChooser = $("#item-chooser-btn");
$("#item-chooser > li > a").click(function(e) {
    e.preventDefault();
    //Save color
    currColor = $(this).css("color");
    //Add color effect to button
    colorChooser
        .css({"background-color": currColor, "border-color": currColor, "color": "#FFF"})
        .html('<i class="fa fa-check"></i> '+ $(this).text() + ' <span class="caret"></span>');
});

$('div.ranges ul li').click(function(){
    submitDateSearch();
});

$('div.ranges').find('button.applyBtn').click(function(){
    submitDateSearch();
});

function submitDateSearch() {
    var dateFrom = $('[name="daterangepicker_start"]').val();
    var dateTo = $('[name="daterangepicker_end"]').val();

    var url = '/sistema/request?date+from=' + dateFrom + '&date_to=' + dateTo;
    Html.Get(url, function(r){
        eval(r);
        $('#loading').hide();
        return false;
    });

};
