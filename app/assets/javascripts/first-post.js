var $;
$(document).on("turbolinks:load", function() {
  $("#prompt-first-post a").on("click", function() {
    $("#prompt-first-post").remove();
  });
});
