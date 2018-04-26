$(document).on('turbolinks:load', function () {
    // clicking post numbers appends a quote to the post-form
    $('body').on('click', '.post-detail#id', function (e) {
        var txt = '@' + $(e.target).text() + '\n';
        $('#newChildPostModal #child-post-body').append(txt);
    });

    // clicking post-images creates a fullscreen popup
    $('body').on('click', '.post-image img', function (e) {
        e.preventDefault();
        var src = $(e.target).parent().attr('href');
        $('.wild-ui').append('<div class="img-expand"><img src=' + src + '></div>').click(function (e) {
            $('.wild-ui').find('.img-expand:last').remove();
        });
    });
});
