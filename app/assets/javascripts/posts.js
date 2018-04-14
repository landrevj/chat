$(document).ready(function(){
    // clicking post numbers appends a quote to the post-form
    $('.post-detail#id').click(function(e){
        var txt = '@' + $(e.target).text() + '\n';
        $('.post-form #body textarea').append(txt);
    });
});
