$(document).ready(function(){console.log("date-picker"),$(".date-picker").each(function(){function t(t,e){e.find("input").val(t.format("YYYY-MM-DDTHH:mm:ss")),a.find(".date-container > .date > .text").text(t.format("Do")),a.find(".date-container > .month > .text").text(t.format("MMMM")),a.find(".date-container > .year > .text").text(t.format("YYYY")),a.data("date",t.format("YYYY-MM-DDTHH:mm:ss"))}var a=$(this);a.data("date")?moment(a.data("date"),"YYYY-MM-DDTHH:mm:ss"):moment();t(moment(),a),a.on("click",'[data-toggle="datepicker"]',function(a){a.preventDefault(),console.log($(a.target));var e=moment($(this).closest(".date-picker").data("date"),"YYYY-MM-DDTHH:mm:ss"),d=$(this).data("type")?$(this).data("type"):"date",n=$(this).data("method")?$(this).data("method"):"add";$(this).data("amt")?$(this).data("amt"):1;"add"==n?e=e.add(1,d):"subtract"==n&&(e=e.subtract(1,d)),t(e,$(a.target).parent().parent())})})});