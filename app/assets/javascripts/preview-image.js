var $;
var App;
$(document).on("turbolinks:load", function() {
  function buildPreviewItem(src, alt) {
    var template = `
      <div class="post-form__preview-image">
        <img alt="${alt}" src="${src}">
      </div>
    `;
    return template;
  }

  function buildPreviewThumbnail(src, alt) {
    var template = `
    <img alt="${alt}" src="${src}" class="post-form__thumbnail-image--preview" id="thumbnail-preview">
    `;
    return template;
  }

  class PostPreviewer extends App.Previewer.BasePreviewer {
    initialize() {
      $("#modal-post").on("show.bs.modal", () => {
        if ($(".post-form__preview-image").length != 0) {
          this.constructor._showRemoveButton(
            "#remove-preview-button",
            "#upload-icon"
          );
        } else {
          this.constructor._showUploadButton(
            "#remove-preview-button",
            "#upload-icon"
          );
        }
      });
    }
  }

  var thumbnailPreviewer = new App.Previewer.BasePreviewer(
    "#user_profile_remove_thumbnail",
    "#thumbnail-remove-icon",
    "#thumbnail-upload-icon, .post-form__thumbnail-label",
    "#user_profile_thumbnail",
    "change",
    "click",
    "#thumbnail-preview",
    "#thumbnail-container",
    buildPreviewThumbnail,
    () => {
      return $("#thumbnail-preview").length != 0;
    }
  );

  thumbnailPreviewer.initialize();
  thumbnailPreviewer.attachPreviewer();
  thumbnailPreviewer.attachPreviewRemover();

  var imagePreviewer = new PostPreviewer(
    "#post_remove_image",
    "#remove-preview-button",
    "#upload-icon",
    "#post_image",
    "change",
    "click",
    ".post-form__preview-image",
    ".post-form-preview",
    buildPreviewItem
  );

  imagePreviewer.initialize();
  imagePreviewer.attachPreviewer();
  imagePreviewer.attachPreviewRemover();
});
