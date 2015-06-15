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

$('[name="zip_code"]').mask('99999-999');

$('[name="zip_code"]').blur(function() {
    var cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

function cepSearch(cep){
    $.ajax({
        type: "GET",
        url: "http://viacep.com.br/ws/"+cep+"/json",
        dataType: "json",
        success: function(data){
            if(data.erro == true){
                alert('Cep não encontrado');
                $('[name="zip_code"]').focus();
            }
            else{
                $('#zipcode').val(data.cep);
                $('#street_addr').val(data.logradouro);
                $('#hood').val(data.bairro);
                $('#city').val(data.localidade);
            }
        },
        error: function(){
            alert('Cep não encontrado');
        }
    });
}

//$('#phone_type').select2();
//$('#address_type').select2();