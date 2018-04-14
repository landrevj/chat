var ready = function(){
    // clicking post numbers appends a quote to the post-form
    $('.post-detail#id').click(function(e){
        var txt = '@' + $(e.target).text() + '\n';
        $('.post-form #body textarea').append(txt);
    });
    
    // clicking post-images creates a fullscreen popup
    $('.post-image img').click(function(e){
        e.preventDefault();
        var src = $(e.target).parent().attr('href');
        $('.wild-ui').append('<div class="img-expand"><img src=' + src + '></div>').click(function (e) {
            $('.wild-ui').find('.img-expand:last').remove();
        });
    });

};

$(document).on('turbolinks:load', ready);
