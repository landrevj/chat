$(document).on('turbolinks:load', function () {
    $('body').on('click', 'a.quote', function(e){
        e.preventDefault()
        var target = $(e.target);
        
        if (!target.next().hasClass('post'))
        {
            var url = '/';
            var type = '';
            var id = target.attr('id');
            
            if (target.hasClass('root-quote'))       type = 'root-post';
            else if (target.hasClass('child-quote')) type = 'child-post';
            
            $.ajax({
                type: "GET",
                url: "/api/" + type + "/" + id,
                dataType: "json",
                success: function (data) {
                    target.after(build_post(type, data));
                    // console.log(data);
                },
                error: function (type, data) {
                    console.log(data);
                }
            });
        }
        else
        {
            target.next().remove();
        }
    });
});

function build_post(type, data)
{
    // help
    var post = '',
        sticky = '',
        id = '',
        subject = '',
        edited = '',
        picture_url = '',
        picture_thumb_url = '',
        replies = '';

    if ('root_post' in data){
        post = data.root_post;
        id += '#' + post.id;
        if (post.subject != '') subject = "<div class=\"post-detail\" id=\"subject\" title=\"subject\"><strong>" + post.subject + "</strong></div>";
    }
    else if ('child_post' in data){
        post = data.child_post;
        id += post.id;
    } 

    if (post.properties.sticky) sticky = 'sticky';

    if (post.created_at != post.updated_at)
    {
        edited = "<div class=\"post-detail\" id=\"timestamp-edited\" title=\"" + post.updated_at + "\"><strong>" + data.updated_ago + " ago</strong></div>";
    }

    if (post.picture.url)
    {
        picture_url = post.picture.url;
        picture_thumb_url = post.picture.thumb.url;
    }

    if ('replies_html' in data) replies = data.replies_html;
    
    var result = "\
    <div class=\""+ type +" post " + sticky + " embedded\" id=\"" + type.split('-', 1) + "-" + post.id + "\">\
        <a class=\"anchor\" name=\"" + id + "\"></a>\
        <div class=\"contents\">\
            <div class=\"post-left-col\">\
                <div class=\"post-details\">\
                    <div class=\"post-detail\" id=\"user-name\" title=\"username\"><strong>" + data.user_name + "</strong> </div>\
                    " + subject + "\
                    <div class=\"post-detail\" id=\"id\" title=\"id\"><a><strong>#" + id + "</strong></a></div>\
                    <div class=\"post-detail\" id=\"timestamp-created\" title=\"" + post.created_at + "\"><strong>" + data.created_ago + " ago </strong></div>\
                    " + edited + "\
                </div>\
                <div class=\"body\"><p>" + data.markdown_body + "</p></div>\
            </div>\
            \
            <div class=\"post-right-col\">\
                <div class=\"post-image\">\
                    <a href=\"" + picture_url + "\">\
                        <img src=\"" + picture_thumb_url + "\">\
                    </a>\
                </div>\
            </div>\
        </div>\
        " + replies + "\
    </div>\
    ";
    return result;
}
