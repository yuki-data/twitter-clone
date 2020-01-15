var $;
$(document).on("turbolinks:load", function() {
  $("#prompt-first-post a, #new-post").on("click", function() {
    $("#prompt-first-post").remove();
  });
});
