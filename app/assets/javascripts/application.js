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
// require jquery
// require jquery_ujs
//= require turbolinks
//= require_tree ./lib
//= require_tree .




// Automaticaly change textarea height.
$(document).ready(function(){
  $('textarea.autosize').autosize();
});

// Preview post.
$(document).ready(function(){
  var load_preview = function(){
    var text = $('#post_body').val();
    var csrfToken = $('meta[name="csrf-token"]').attr('content');
    $.post('/posts/preview.api', {
      "text": text,
      "authenticity_token": csrfToken
      })
      .done(function(data){
        $('#post_preview').html(data);
      })
  };
  $('#post_body').on('keyup mouseup', load_preview);

  load_preview();
});

// post list
$(document).ready(function(){
  $('.post-list').on('click', function(e){
    e.preventDefault();
    $this = $(this);

    $this.siblings().removeClass('active');
    $this.addClass('active');
    var id = $this.data('postId');
    $.get('/posts/show_fragment', {
      "id": id,
      })
      .done(function(data){
        $('#list_post').html(data);
      })
  })
});

// search form
$(document).ready(function(){
  $('#app-search-form input').on('focus', function(e){
    $(this).parents('#app-search-form').animate({width: '600px'});
  }).on('blur', function(e){
    $(this).parents('#app-search-form').animate({width: '200px'});
  })
});


// disable tab key
$(document).ready(function(){
  $('.disable-tab').on('keydown', function(e) {
    var keyCode = e.keyCode || e.which;

    if (keyCode == 9) {
      e.preventDefault();
      var start = $(this).get(0).selectionStart;
      var end = $(this).get(0).selectionEnd;

      // set textarea value to: text before caret + tab + text after caret
      $(this).val($(this).val().substring(0, start)
                  + "\t"
                  + $(this).val().substring(end));

      // put caret at right position again
      $(this).get(0).selectionStart =
      $(this).get(0).selectionEnd = start + 1;
    }
  });
});
