// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootsy
//= require bootstrap.min
//= require bootstrap-datepicker/core
//= require turbolinks
//= require gritter
//= require the_comments
//= require magnific-popup
//= require_tree .
//= require bootstrap-modal
//= require bootstrap-modalmanager


$(document).on('page:load', function(e) {
    $('a').on('click', function(){
        if($(this).className != 'nl'){
            $('body').toggleClass('loading');
        }
    });
});