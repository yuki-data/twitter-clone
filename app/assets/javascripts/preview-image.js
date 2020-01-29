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

  function checkOnFileRemove() {
    $("#post_remove_image").prop("checked", true);
  }

  function checkOffFileRemove() {
    $("#post_remove_image").prop("checked", false);
  }

  class PostPreviewer extends App.Previewer.ImagePreviewer {
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

    _afterPreview() {
      return () => {
        this.constructor._showRemoveButton(
          this.removeButton,
          this.uploadButton
        );
        checkOffFileRemove();
      };
    }

    _afterRemove() {
      return () => {
        this.constructor._showUploadButton(
          this.removeButton,
          this.uploadButton
        );
        checkOnFileRemove();
      };
    }
  }

  var imagePreviewer = new PostPreviewer(
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
