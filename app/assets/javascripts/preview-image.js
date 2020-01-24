var $;
$(document).on("turbolinks:load", function() {
  function buildPreviewItem(src, alt) {
    var template = `
      <div class="post-form__preview-image">
        <img alt="${alt}" src="${src}">
      </div>
    `;
    return template;
  }

  function showRemoveButton() {
    $("#upload-icon").hide();
    $("#remove-preview-button").show();
  }

  function showUploadIcon() {
    $("#upload-icon").show();
    $("#remove-preview-button").hide();
  }

  $("#modal-post").on("show.bs.modal", function() {
    if ($(".post-form__preview-image").length != 0) {
      showRemoveButton();
    } else {
      showUploadIcon();
    }
  });

  $("body").on("click", "#remove-preview-button", function() {
    $("#post_image").val("");
    $(".post-form__preview-image").remove();
    showUploadIcon();
  });

  $("body").on("change", "#post_image", function() {
    var file = this.files[0];
    var fileReader = new FileReader();

    fileReader.onload = function(e) {
      var html = buildPreviewItem(e.target.result, file.name);
      $(".post-form-preview").prepend(html);
    };
    fileReader.readAsDataURL(file);
    showRemoveButton();
  });
});
