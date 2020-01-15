var $;
$(document).on("turbolinks:load", function() {
  $("#bootstrap-navbar").on("mouseleave", function() {
    $("#navbarNav").removeClass("show");
  });
});
