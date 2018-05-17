$(document).on('turbolinks:load', () => {
    $('body').on('click', 'a.quote', (e) => {
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

    $('body').on('click', 'div.reply a.live-link', (e) => {
        e.preventDefault()
        var clicked = $(e.target).parent().parent();
        var type = '';
        var id = clicked.attr('id');
        
        if (clicked.hasClass('root-reply'))       type = 'root-post';
        else if (clicked.hasClass('child-reply')) type = 'child-post';

        var find = clicked.closest('.post').find('#' + type.split('-', 1) + '-' + id)

        if (find.length === 0)
        {   
            insert_post(type, id, clicked.closest('.row').prev());
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
        success: (data) => {
            // console.log(data[type.replace('-', '_')])
            target.after(data[type.replace('-', '_')].html);
            target.next().addClass('embedded');
        }
    });
}
