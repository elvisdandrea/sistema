$("#zip_code").blur(function() {
    cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

$('#new_addr').click(function(){
    $('#addr_list').hide();
    $('#new_addr_form').show();
});

$('#cancel_addr').click(function(){
    $('#addr_list').show();
    $('#new_addr_form').hide();
});

function cepSearch(cep){
    $.ajax({
        type: "GET",
        url: "http://viacep.com.br/ws/"+cep+"/json",
        dataType: "json",
        success: function(data){
            if(data.erro == true){
                alert('Cep não encontrado');
            }
            else{
                $('#zip_code').val(data.cep);
                $('#street_addr').val(data.logradouro);
                $('#street_addr_label').val(data.logradouro);
                $('#hood').val(data.bairro);
                $('#hood_label').val(data.bairro);
                $('#city').val(data.localidade);
                $('#city_label').val(data.localidade);
            }
        },
        error: function(){
            alert('Cep não encontrado');
        }
    });
}