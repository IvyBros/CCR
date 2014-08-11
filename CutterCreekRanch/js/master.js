$(document).ready(function () {
    var existing = $('.Sold').text();
    $('.Sold').after(" SOLD");
    $('.NotForSale').parent().css('display', 'none');
    var price = parseFloat($('.Discounted').text().trim().substr(1));
    var markedDownFrom = (price * .25) + price;
    $('.Discounted').text(" $" + markedDownFrom.toFixed(2));
    $('.Discounted').after("<span class='discountPrice'> $" + price.toFixed(2) + "</span>");
});