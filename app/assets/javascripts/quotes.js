$(document).on('turbolinks:load', function () {
    $('body').on('click', 'a.quote', function(e){
        e.preventDefault()
        var target = $(e.target);
        
        if (!target.next().hasClass('post'))
        {
            var type = '';
            var id = target.attr('id');
            
            if (target.hasClass('root-quote'))       type = 'root-post';
            else if (target.hasClass('child-quote')) type = 'child-post';
            
            insert_post(type, id, target);
        }
        else
        {
            target.next().remove();
        }
    });

    $('body').on('click', 'div.reply a', function(e){
        e.preventDefault()
        var clicked = $(e.target).parent().parent();
        var type = '';
        var id = clicked.attr('id');
        
        if (clicked.hasClass('root-reply'))       type = 'root-post';
        else if (clicked.hasClass('child-reply')) type = 'child-post';

        var find = clicked.parent().parent().find('#' + type.split('-', 1) + '-' + id)

        if (find.length === 0)
        {   
            insert_post(type, id, clicked.parent().prev());
            clicked.addClass('opened');
            $(e.target).html('close');
        }
        else
        {
            find[0].remove();
            clicked.removeClass('opened');
            if (clicked.hasClass('root-reply')) $(e.target).html('reply_all');
            else if (clicked.hasClass('child-reply')) $(e.target).html('reply');
        }
    });
});

function insert_post(type, id, target)
{
    $.ajax({
        type: "GET",
        url: "/api/" + type + "/" + id,
        dataType: "json",
        success: function (data) {
            target.after(data.html);
            target.next().addClass('embedded');
            // console.log(data);
        }
    });
}
