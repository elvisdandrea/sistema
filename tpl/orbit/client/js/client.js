$("#zip_code").blur(function() {
    var cep = $('#zip_code').val();
    if(cep != '') {
        cepSearch(cep);
    }
});

$('#new_client_phone').blur(function(){
    var phoneNumber = $(this).val();
    var url = $(this).attr('data-url');
    if(phoneNumber != '') {
        $.ajax({
            type: "POST",
            url: url,
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
    var url = $(this).attr('data-url');

    if(entityType != 'J')
        url += "validateCpf";
    else
        url += "validateCnpj";

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

$("input[type='checkbox'], input[type='radio']").iCheck({
    checkboxClass: 'icheckbox_minimal',
    radioClass: 'iradio_minimal'
});

$('[name="client_type"]').on('ifChecked', function(event){
    var data = $(this).val();
    if(data == 'F'){
        removeLegalEntityInputs();
    }else{
        addLegalEntityInputs();
    }
});

$('[name="main_addr"]').on('ifChecked', function(event){
    url = $(this).attr('data-url');
    $.ajax({
        type: "GET",
        url: url,
        success: function (data) {
            eval(data);
        }
    });
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
                $('#hood').val(data.bairro);
                $('#city').val(data.localidade);
            }
        },
        error: function(){
            alert('Cep não encontrado');
        }
    });
}

window.fbAsyncInit = function() {
    FB.init({
        //appId      : '480497202107723',
        appId      : '1443197789328925',
        xfbml      : true,
        version    : 'v2.3'
    });
};

(function(d, s, id){
    var js, fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) {return;}
    js = d.createElement(s); js.id = id;
    js.src = "//connect.facebook.net/en_US/sdk.js";
    fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));

function openFBSearch() {
    FB.getLoginStatus(function (response) {
        if (response.status === 'connected') {
            $.ajax({
                type: "POST",
                url: "fbSearch",
                data: {access_token: response.authResponse.accessToken},
                success: function (data) {
                    eval(data);
                }
            });
        }
        else {
            FB.login();
        }
    });
}

Main.imageAction('read64', 'client-img');