$("#zip_code").blur(function() {
    cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

function cepSearch(cep){
    $.getJSON("http://viacep.com.br/ws/"+cep+"/json", function(data){
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
    });
}