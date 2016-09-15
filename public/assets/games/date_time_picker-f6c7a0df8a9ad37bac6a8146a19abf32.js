$(document).ready(function(){
	$('#timepicker').timepicker();
	$('#timepicker').timepicker('option','timeFormat', 'H:i');

	$('.datetime-input').on('change',function(){
		currentDate = moment($('#datepicker').val(),'MM/DD/YYYY').format('YYYY-MM-DD');
		currentTime = $('#timepicker').val();

		dateAndTime = currentDate + 'T' + currentTime;
		$('#game_date_time').val(dateAndTime);
	})
});
