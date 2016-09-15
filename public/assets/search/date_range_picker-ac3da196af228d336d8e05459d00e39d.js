$(document).ready(function() {
	$('#datapicker .input-daterange').datepicker({
	    format: "dd.mm.yyyy",
	    weekStart: 1,
	    startDate: "01.04.2016",
	    endDate: "+",
	    todayBtn: "linked",
	    language: "ru",
	    orientation: "bottom right",
	    daysOfWeekHighlighted: "0,6"
	});
});
