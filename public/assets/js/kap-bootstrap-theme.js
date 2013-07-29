//tooltip data-api
$(document).ready(function() {
    $('form input').tooltip();
    $('form select').tooltip();
});

//@todo xxx experiments
//disqus
$(document).ready(function() {
    $("#disqus-modal").draggable({
        handle: ".modal-header"
    }); 
    $("#disqus-modal .modal-header button.close").click(function(e) {
        $("#disqus-modal").hide();
    });
});

//UI control: switch
$(document).ready(function() {
    $('input[data-kap-control=switch]').each(function(i, element) {
        var $element = $(element);
        var name = $element.attr('name');
        var $fieldset = $element.closest('form,fieldset');
        
        function showGroup(val) {
            var hideSelector = 'fieldset[data-kap-group="' + name + '"]';
            var showSelector = 'fieldset[data-kap-group="' + name + '"][data-kap-value="' + val + '"]';
            $fieldset.find(hideSelector).hide();
            $fieldset.find(showSelector).show();
        }
        
        $element.on('change', function(e) {
            showGroup($(e.target).val());
        });
        
        if($element.attr('checked')) {
            showGroup($element.val());
        }
    });
});

//UI input contact selector
$(document).ready(function() {
    $('input[data-kap-input=contact-selector]').each(function(i, element) {
        var $element = $(element);
        $element.focus(function(e) {
            $('#myModal').modal({
                'show': true,
                'remote': '/KapitchiShowcaseApplication/public/contact/contact/index'
            });
        });
    });
});
