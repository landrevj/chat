$(document).on('turbolinks:load', () => {
    // clicking post numbers appends a quote to the post-form
    $('body').on('click', '.post-detail#id', (e) => {
        var txt = '@' + $(e.target).text() + '\n';
        $('#newChildPostModal #child-post-body').append(txt);
    });

    // clicking post-images creates a fullscreen popup
    $('body').on('click', '.post-image img', (e) => {
        e.preventDefault();
        var src = $(e.target).parent().attr('href');
        $('.wild-ui').append('<div class="img-expand"><img src=' + src + '></div>').click(function (e) {
            $('.wild-ui').find('.img-expand:last').remove();
        });
    });

    // post fetching on interval
    var query_interval_ms = 30000,
    query_timer_ms = query_interval_ms,
    updater = $('.thread-stats .updater');
    
    $('body').on('click', '.thread-stats .updater', () => {
        insert_new_posts();
        query_timer_ms = query_interval_ms;
    });
    
    if (window.post_interval) clearInterval(window.post_interval)
    if (updater.length)
    {
        window.post_interval = setInterval(() => {
            updater.text(query_timer_ms / 1000);
            if (query_timer_ms <= 0)
            {
                query_timer_ms = query_interval_ms;
                insert_new_posts();
            }
            else query_timer_ms -= 1000;
        }, 1000);
    }

});

function insert_new_posts()
{
    var old_posts = $('.child-post');
    var last_id = 0;
    if (old_posts.length) last_id = parseInt($(old_posts[old_posts.length - 1]).attr('id').substring(6), 10);
    $.ajax({
        type: 'GET',
        url: location.toString() + '.json',
        dataType: 'json',
        success: (data) => {
            update_posts(data);
            var new_posts = data.child_posts;
            if (old_posts.length < new_posts.length)
            {
                for (let i = old_posts.length; i < new_posts.length; i++) {
                    $('.container-fluid').append(new_posts[i].html)
                }
            }
        }
    });
}

function update_posts(data)
{
    $('.root-post').replaceWith(data.html);
    for (let i = 0; i < data.child_posts.length; i++) {
        $($('.child-post')[i]).replaceWith(data.child_posts[i].html)
    }
}
