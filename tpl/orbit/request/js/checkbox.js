$('input[type="checkbox"].select-itens, input[type="radio"].select-itens').iCheck({
    checkboxClass: 'icheckbox_select-itens',
    radioClass: 'iradio_select-itens'
});

$('.select-itens').on('ifChecked', function(event){
    var span = $(this).parent().parent().find('span');
    $(span).removeClass('item-removed');
    var url = $(this).attr('data-url');
    var value = $(this).attr('data-value');
    value += '_1';
    $.ajax({
        url: url,
        data: {item_id : value}
    });
});

$('.select-itens').on('ifUnchecked', function(event){
    var span = $(this).parent().parent().find('span');
    $(span).addClass('item-removed');
    var url = $(this).attr('data-url');
    var value = $(this).attr('data-value');
    value += '_0';
    $.ajax({
        url: url,
        data: {item_id : value}
    });
});