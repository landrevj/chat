$(document).on('turbolinks:load', () => {
    $input = $("[data-behavior='autocomplete']");

    var options = {
        getValue: function(element){
            if ('subject' in element)
            {
                return "##" + element.id + " " + element.subject + " " + element.body.substring(0, 10);
            }
            else
            {
                return "##" + element.id + " " + element.body;
            }
        },
        url: function(phrase) {
            return '/search.json?q=' + phrase
        },
        categories: [
            {
                listLocation: 'root_posts',
                header: '<strong>Threads</strong>',
            },
            {
                listLocation: 'child_posts',
                header: '<strong>Posts</strong>',
            }
        ],
        list: {
            onChooseEvent: function() {
                var url = $input.getSelectedItemData().url;
                $input.val('')
                Turbolinks.visit(url);
            }
        }
    }

    $input.easyAutocomplete(options);
});
