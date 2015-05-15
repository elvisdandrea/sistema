$("#zip_code").blur(function() {
    var cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

var novo_fone = $('#new_client_phone');

novo_fone.blur(function(){
    var phoneNumber = $('#new_client_phone').val();
    if(phoneNumber != '') {
        $.ajax({
            type: "POST",
            url: "checkPhoneExists",
            data: {phone_number: phoneNumber},
            success: function (data) {
                eval(data);
            }
        });
    }
});

$('[name="cpf_cnpj"]').blur(function() {
    var entityType = $('[name="client_type"]:checked').val();
    var cpfCnpj = $(this).val();

    if(entityType != 'J')
        var url = "validateCpf";
    else
        var url = "validateCnpj";

    if(cpfCnpj != '') {
        $.ajax({
            type: "POST",
            url: url,
            data: {cpf_cnpj: cpfCnpj},
            success: function (data) {
                eval(data);
            }
        });
    }
});

$('[name="email"]').blur(function() {
    var email = $(this).val();
    if(email != '') {
        $.ajax({
            type: "POST",
            url: "validateEmail",
            data: {email: email},
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

/*Validações de telefone*/
function mascara(o,f){
    v_obj=o
    v_fun=f
    setTimeout("execmascara()",1)
}
function execmascara(){
    v_obj.value=v_fun(v_obj.value)
}
function mtel(v){
    v=v.replace(/\D/g,"");
    v=v.replace(/^(\d{2})(\d)/g,"($1) $2");
    v=v.replace(/(\d)(\d{4})$/,"$1-$2");
    return v;
}
function id( el ){
    return document.getElementById( el );
}


$('#label_phone').click(function(){
    alert("aqui voce funciona!");
});

novo_fone.onkeyup(function(){
    alert('oi');
});

window.onload = function(){

    novo_fone.click = function(){
        mascara(this, mtel);

    }
}