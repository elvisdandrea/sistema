$('#datetimepicker').datetimepicker({
    locale: 'pt-br',
    showTodayButton: false,
    //format: 'DD/MM/YYYY HH:mm'
    format: 'LLLL'
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