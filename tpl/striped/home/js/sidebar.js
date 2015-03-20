$('div#sidebar ul > li').click(function(){
    $(this).parent('ul').find('li').removeClass('current');
    $(this).addClass('current');
});