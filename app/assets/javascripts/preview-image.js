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

  function checkOnFileRemove(removeCheckbox) {
    $(removeCheckbox).prop("checked", true);
  }

  function checkOffFileRemove(removeCheckbox) {
    $(removeCheckbox).prop("checked", false);
  }

  class Previewer extends App.Previewer.ImagePreviewer {
    constructor(removeCheckbox, ...args) {
      super(...args);
      this.removeCheckbox = removeCheckbox;
    }

    _afterPreview() {
      return () => {
        this.constructor._showRemoveButton(
          this.removeButton,
          this.uploadButton
        );
        checkOffFileRemove(this.removeCheckbox);
      };
    }

    _afterRemove() {
      return () => {
        this.constructor._showUploadButton(
          this.removeButton,
          this.uploadButton
        );
        checkOnFileRemove(this.removeCheckbox);
      };
    }
  }

  class PostPreviewer extends Previewer {
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
