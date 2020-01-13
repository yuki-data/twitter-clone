$(function() {
  $("#search-posts").on("submit", function() {
    var input = $(this).find("input[type='text']");
    if (input.val().trim().length == 0) {
      return false;
    }
  });
});
