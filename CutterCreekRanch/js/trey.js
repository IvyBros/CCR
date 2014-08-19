$(document).ready(function () {
    $(".work-history").click(function () {
        var sid = $(this).attr('id').substring(5);
        var up = "#up-" + sid;
        $("#" + sid).toggle("fade");
        $(this).css("display", "none");
        $(up).css("display", "block");
    });
    $(".work-historyX").click(function () {
        $(this).css("display", "none");
        var sid = $(this).attr('id').substring(3);
        var down = "#drop-" + sid;
        $("#" + sid).toggle("fade");
        $(down).css("display", "block");
    });
    $(".seals").hover(function () {
        $(this).css("opacity", "1");
    }, function () {
        $(this).css("opacity", ".8");
    });
    $(".edu").hover(function () {
        var shortID = "#" + $(this).attr('id').substring(3);
        $(shortID).css("opacity", "1");
    }, function () {
        var shortID = "#" + $(this).attr('id').substring(3);
        $(shortID).css("opacity", ".8");
    });
    $('#topNavBar li a').click(function (event) {
        event.preventDefault();
        $($(this).attr('href'))[0].scrollIntoView();
        scrollBy(0, -70);
    });    
    var request;
    $('#validateCertsForm').submit(function (event) {
        if (request) {
            request.abort();
        }
        var $form = $(this);
        var serializedData = $form.serialize();
        var $inputs = $form.find("input, button");
        $inputs.prop("disabled", true);
        //$("#modal3").modal('hide');
        request = $.ajax({
            url: "php/mail.php",
            type: 'POST',
            data: serializedData            
        });
        request.done(function (response, textStatus, jqXHR) {
            //alert("horray it worked");            
            $('#modal4').modal('show');
        });
        request.fail(function (jqXHR, textStatus, errorThrown) {
            //alert("error=" + textStatus, errorThrown);
            $('#modal5').modal('show');
        });
        request.always(function () {
            $inputs.prop("disabled", false);
            $('#modal3').modal('hide');
        });
        event.preventDefault();
        event.unbind();
    });
    $(form).submit();
});//end document
