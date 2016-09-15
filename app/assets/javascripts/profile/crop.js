$(document).ready(function() {

    var $image = $(".image-crop > img")
    $($image).cropper({
        //aspectRatio: 1,
        preview: ".img-preview",
        autoCropArea: 1
    });

    var $inputImage = $("#inputImage");
    if (window.FileReader) {
        $inputImage.change(function () {
            var fileReader = new FileReader(),
                files = this.files,
                file;

            if (!files.length) {
                return;
            }

            file = files[0];

            if (/^image\/\w+$/.test(file.type)) {
                fileReader.readAsDataURL(file);
                fileReader.onload = function () {
                    $inputImage.val("");
                    $image.cropper("reset", true).cropper("replace", this.result);
                };
            } else {
                showMessage("Please choose an image file.");
            }
        });
    } else {
        $inputImage.addClass("hide");
    }

    $("#download").click(function () {
        window.open($image.cropper("getDataURL"));
    });

    $("#zoomIn").click(function () {
        $image.cropper("zoom", 0.1);
    });

    $("#zoomOut").click(function () {
        $image.cropper("zoom", -0.1);
    });

    $("#rotateLeft").click(function () {
        $image.cropper("rotate", 45);
    });

    $("#rotateRight").click(function () {
        $image.cropper("rotate", -45);
    });

    $("#setDrag").click(function () {
        $image.cropper("setDragMode", "crop");
    });

    $("#edit_player_1").submit(function(event){

        //var formData = new FormData($('#edit_player_1').first());
        //
        //formData.append('player[avatar]',$(".image-crop > img").cropper('getDataURL'))

        //alert('form data added');
        event.preventDefault();

        var formData = new FormData($(this)[0]);

        formData.append('player[avatar]',$image.cropper('getDataURL'));

        $.ajax({
            url: '/profile',
            type: 'PUT',
            data: formData,
            processData: false,
            contentType: false,
            success: function (data) {
                window.location.reload(true);
            }
        });
        //$.ajax({
        //    url: '/profile',
        //    type: 'PUT',
        //    data: formData,
        //    success: function (data) {
        //        alert(data)
        //    }
        //});
    });
});