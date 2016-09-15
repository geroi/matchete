$(document).ready(function(){
	$('#datepicker').datepicker({
		dateFormat: "dd.mm.yy"
	});
	$('#timepicker').timepicker();
	$('#timepicker').timepicker('option','timeFormat', 'H:i');

	$('.datetime-input').on('change',function(){
		currentDate = moment($('#datepicker').val(),'DD.MM.YYYY').format('YYYY-MM-DD');
		currentTime = $('#timepicker').val();

		dateAndTime = currentDate + 'T' + currentTime;
		$('#game_date_time').val(dateAndTime);
	})
});
