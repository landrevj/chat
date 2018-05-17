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
        refresh_thread();
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
                refresh_thread();
            }
            else query_timer_ms -= 1000;
        }, 1000);
    }

});

function refresh_thread()
{
    var old_posts = $('.child-post:not(.embedded)');
    var last_id = 0;
    if (old_posts.length) last_id = parseInt($(old_posts[old_posts.length - 1]).attr('id').substring(6), 10);
    $.ajax({
        type: 'GET',
        url: location.toString() + '.json',
        dataType: 'json',
        success: (data) => {
            
            var posts = $('.child-post:not(.embedded)'),
                new_ids = data.child_posts.map(post => post.data.id);
            for (let i = 0; i < posts.length; i++) {
                var e = $(posts[i]);
                if (!new_ids.includes(parseInt(e.attr('id').split('-')[1], 10))) e.remove();
            }

            var old_length = $('.child-post:not(.embedded)').length,
                new_posts = data.child_posts;
            for (let i = old_length; i < new_posts.length; i++) {
                var e = new_posts[i].html;
                $('.container-fluid').append(e);
            }

            update_posts(data);
        }
    });
}

function update_posts(data)
{
    var or = $('.root-post:not(.embedded)');
    or.replaceWith(data.root_post.html);
    var nr = $('.root-post:not(.embedded)');
    persist_actions(or, nr);

    var old_children = $('.child-post:not(.embedded)'); 
    for (let i = 0; i < old_children.length; i++) {
        var oc = $(old_children[i]);
        oc.replaceWith(data.child_posts[i].html);
        var nc = $('#' + oc.attr('id') + ':not(.embedded)');
        persist_actions(oc, nc);
    }

    $('.thread-stats .post-count').text(data.root_post.stats.posts);
    $('.thread-stats .file-count').text(data.root_post.stats.files);
    $('.thread-stats .user-count').text(data.root_post.stats.users);
}

function persist_actions(old_post, new_post)
{
    var quotes = old_post.find('*:not(.embedded) .quote');
    for (let i = 0; i < quotes.length; i++) {
        var e = $(quotes[i]),
            f = $(new_post.find('.quote')[i]),
            g = e.next();
        if (g.hasClass('post')) {
            f.after(g);
        }
    }
    new_post.find('> .card-body').after(old_post.find('> .embedded'));
    var has_replies = new_post.find('> .row > .replies-container > .replies').length;
    if (has_replies) {
        var old_replies = old_post.find('> .row > .replies-container .reply.opened');
        for (let i = 0; i < old_replies.length; i++) {
            var e = $(old_replies[i]);
            var p = new_post.find('#' + e.attr('id') + '.' + e.attr('class').split(' ')[0]);
            p.addClass('opened');
            p.find('i').text('close');
        }
    }
}
