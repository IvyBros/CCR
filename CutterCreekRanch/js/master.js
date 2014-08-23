/// <reference path="jquery-ui-1.10.4.js" />
/// <reference path="jquery-2.1.1.js" />
/// <reference path="modernizr-2.6.2.js" />
$(document).ready(function () {
    var existing = $('.Sold').text();
    $('.Sold').after(" SOLD");
    $('.NotForSale').parent().css('display', 'none');
    var price = parseFloat($('.Discounted').text().trim().substr(1));
    var markedDownFrom = (price * .25) + price;
    $('.Discounted').text(" $" + markedDownFrom.toFixed(2));
    $('.Discounted').after("<span class='discountPrice'> $" + price.toFixed(2) + "</span>");
});