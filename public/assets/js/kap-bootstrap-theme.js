//tooltip data-api
$(document).ready(function() {
    $('form input').tooltip();
    $('form select').tooltip();
});

//@todo xxx experiments
$(document).ready(function() {
    $('input[data-ui-control=switch]').each(function(i, element) {
        var $element = $(element);
        var name = $element.attr('name');
        var $fieldset = $element.closest('form');
        
        function showGroup(val) {
            var hideSelector = 'fieldset[data-ui-group="' + name + '"]';
            var showSelector = 'fieldset[data-ui-group="' + name + '"][data-ui-value="' + val + '"]';
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
