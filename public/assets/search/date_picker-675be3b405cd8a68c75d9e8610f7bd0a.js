$(document).ready(function() {
    
    $('.date-picker').each(function () {
        var $datepicker = $(this),
            cur_date = ($datepicker.data('date') ? moment($datepicker.data('date'), "YYYY-MM-DDTHH:mm:ss") : moment());

        function updateDisplay(cur_date, date_picker) {   
            date_picker.find('input').val(cur_date.format("YYYY-MM-DDTHH:mm:ss"));
           
            $datepicker.find('.date-container > .date > .text').text(cur_date.format('Do'));
            $datepicker.find('.date-container > .month > .text').text(cur_date.format('MMMM'));
            $datepicker.find('.date-container > .year > .text').text(cur_date.format('YYYY'));
            $datepicker.data('date', cur_date.format('YYYY-MM-DDTHH:mm:ss'));
        }
        
        updateDisplay(moment(), $datepicker);
        
        $datepicker.on('click', '[data-toggle="datepicker"]', function(event) {
            event.preventDefault();
            console.log($(event.target));
            
            var cur_date = moment($(this).closest('.date-picker').data('date'), "YYYY-MM-DDTHH:mm:ss"),
                type = ($(this).data('type') ? $(this).data('type') : "date"),
                method = ($(this).data('method') ? $(this).data('method') : "add"),
                amt = ($(this).data('amt') ? $(this).data('amt') : 1);
                
            if (method == "add") {
                cur_date = cur_date.add(1,type);
            }else if (method == "subtract") {
                cur_date = cur_date.subtract(1,type);
            }
            
            updateDisplay(cur_date, $(event.target).parent().parent());
        });
        
    });
    
});
