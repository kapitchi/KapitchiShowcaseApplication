//tooltip data-api
$(document).ready(function() {
    $('form input').tooltip();
    $('form select').tooltip();
});

$(document).ready(function() {
    
});

//@todo xxx experiments
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

$(document).ready(function() {
    $(document).on('click', '#myModal .modal-body a', function(e) {
        $('#myModal').removeData("modal");
        $('#myModal').modal({remote: $(this).attr("href")});
        return false;
    });
});

