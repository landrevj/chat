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
                    target.after(data.html);
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

