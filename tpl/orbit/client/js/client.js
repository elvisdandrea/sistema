$("#zip_code").blur(function() {
    cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

$('#new_client_phone').blur(function(){
    var phoneNumber = $('#new_client_phone').val();
    if(phoneNumber != '') {
        $.ajax({
            type: "POST",
            url: "client/checkPhoneExists",
            data: {phone_number: phoneNumber},
            success: function (data) {
                eval(data);
            }
        });
    }
});

$('[name="client_type"]').change(function(){
    var data = $(this).val();
    if(data == 'F'){
        removeLegalEntityInputs();
    }else{
        addLegalEntityInputs();
    }
});

function removeLegalEntityInputs(){
    $("#legal_entity").hide();
    $(".legal_entity_field").prop('disabled', true);
    $("#cpf_cnpj").text('CPF:');
    $('#tipo_pessoa_label').text('Cliente pessoa física');
}

function addLegalEntityInputs(){
    $("#legal_entity").show();
    $(".legal_entity_field").prop('disabled', false);
    $("#cpf_cnpj").text('CNPJ:');
    $('#tipo_pessoa_label').text('Cliente pessoa jurídica');
}

$('#new_addr').click(function(){
    $('#addr_list').hide();
    $('#new_addr_form').show();
});

$('#cancel_addr').click(function(){
    $('#addr_list').show();
    $('#new_addr_form').hide();
});

$('#new_phone').click(function(){
    $('#phone_list').hide();
    $('#new_phone_form').show();
});

$('#cancel_phone').click(function(){
    $('#phone_list').show();
    $('#new_phone_form').hide();
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