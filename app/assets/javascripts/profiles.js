/**
 * Created by Andrey on 05.05.14.
 */

$(document).on('ready', function(){
    $('.profiles .edit_user').on('ajax:success', function(obj,data,status){

    })
        .on('ajax:error', function(obj,data,status){
            if ($('div.input-group').parents('.has-error').length) {
                console.log($(this));
            }
            $.each(data.responseJSON,function(k,v){
                var el = $('input#user_'+k);
                var group = el.parent();
                var labelname =  group.find('label').text();
                group.wrap('<div class="form-group has-error has-feedback"></div>')
                group.find('label').addClass('control-label').html(labelname+' <span class="glyphicon glyphicon-warning-sign form-control-feedback"></span>')
            })
        })
})