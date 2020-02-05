var $;
var App = App || {};
App.Previewer = (function() {
  class ImagePreviewer {
    /**
     *
     * @param {string} removeButton - セレクタ。画像のプレビューを削除するボタン
     * @param {string} uploadButton - セレクタ。画像のアップロードボタン。
     * @param {string} fileInput - uploadのためのinput要素のセレクタ。このuploadButtonでeventが起きたら発火する
     * @param {string} uploadEvent - 通常changeイベントにする
     * @param {string} removeEvent - 通常clickイベントにする
     * @param {string} preview - 削除するプレビューのセレクタ。
     * @param {string} previewParent - セレクタ。previewParent要素の子要素にpreviewTemplateBuilderのテンプレートを追加する
     * @param {function} previewTemplateBuilder - 埋め込むhtmlテンプレートを作る関数
     * @param {function} initialCondition - この関数をページ読み込みごとに実行してtrueなら、削除ボタンをshowしてアップロードボタンをhideする
     */
    constructor(
      removeButton,
      uploadButton,
      fileInput,
      uploadEvent,
      removeEvent,
      preview,
      previewParent,
      previewTemplateBuilder,
      initialCondition
    ) {
      this.removeButton = removeButton;
      this.uploadButton = uploadButton;
      this.fileInput = fileInput;
      this.uploadEvent = uploadEvent;
      this.removeEvent = removeEvent;
      this.preview = preview;
      this.previewParent = previewParent;
      this.previewTemplateBuilder = previewTemplateBuilder;
      this.initialCondition = initialCondition;
    }

    /**
     * ページ読み込み時の、画像アップロードボタンや削除ボタンを表示・非表示を設定する
     * 例えば、読み込み時にアップロードボタンは、編集ページなら非表示で、新規投稿ページなら表示する。
     * 必要に応じてオーバーライドする。
     */
    initialize() {
      if (this.initialCondition && this.initialCondition()) {
        this.constructor._showRemoveButton(
          this.removeButton,
          this.uploadButton
        );
      } else {
        this.constructor._showUploadButton(
          this.removeButton,
          this.uploadButton
        );
      }
    }

    /**
     * プレビュー表示後の処理。
     * 削除ボタンを非表示にする。
     * 必要に応じてオーバーライドする。
     */
    _afterPreview() {
      return () => {
        this.constructor._showRemoveButton(
          this.removeButton,
          this.uploadButton
        );
      };
    }

    /**
     * プレビュー削除後の処理。
     * 削除ボタンを非表示にする。
     * 必要に応じてオーバーライドする。
     */
    _afterRemove() {
      return () => {
        this.constructor._showUploadButton(
          this.removeButton,
          this.uploadButton
        );
      };
    }

    /**
     * 画像のアップロードイベントでプレビューを表示するというイベントをアップロードボタンにつける
     */
    attachPreviewer() {
      this.constructor._attachPreviewer(
        this.uploadEvent,
        this.fileInput,
        this.previewParent,
        this.previewTemplateBuilder,
        this._afterPreview()
      );
    }

    /**
     * 画像のプレビューを削除するイベントを削除ボタンに付ける
     */
    attachPreviewRemover() {
      this.constructor._attachPreviewRemover(
        this.removeEvent,
        this.removeButton,
        this.fileInput,
        this.preview,
        this._afterRemove()
      );
    }

    /**
     * @param {string} removeButton - セレクタ。画像のプレビューを削除するボタン
     * @param {string} uploadButton - セレクタ。画像のアップロードボタン。
     */
    static _showRemoveButton(removeButton, uploadButton) {
      $(removeButton).show();
      $(uploadButton).hide();
    }

    /**
     * @param {string} removeButton - セレクタ。画像のプレビューを削除するボタン
     * @param {string} uploadButton - セレクタ。画像のアップロードボタン。
     */
    static _showUploadButton(removeButton, uploadButton) {
      $(removeButton).hide();
      $(uploadButton).show();
    }

    /**
     * 画像のアップロードイベントでプレビューを表示するというイベントをアップロードボタンにつける
     * @param {string} event - 通常changeイベントにする
     * @param {string} fileInput - uploadのためのinput要素のセレクタ。このuploadButtonでeventが起きたら発火する
     * @param {string} previewParent - セレクタ。previewParent要素の子要素にpreviewTemplateBuilderのテンプレートを追加する
     * @param {function} previewTemplateBuilder - 埋め込むhtmlテンプレートを作る関数
     * @param {function} afterPreview - 画像プレビュー表示後の処理
     */
    static _attachPreviewer(
      event,
      fileInput,
      previewParent,
      previewTemplateBuilder,
      afterPreview
    ) {
      $("body").on(event, fileInput, function() {
        var file = this.files[0];
        var fileReader = new FileReader();

        fileReader.onload = function(e) {
          var html = previewTemplateBuilder(e.target.result, file.name);
          $(previewParent).prepend(html);
        };
        fileReader.readAsDataURL(file);
        afterPreview && afterPreview();
      });
    }

    /**
     * 画像のプレビューを削除するイベントを削除ボタンに付ける
     * @param {string} event - 通常clickイベントにする
     * @param {string} removeButton - 削除ボタンのセレクタ。このボタンのクリックでプレビューを削除する
     * @param {string} fileInput - uploadのためのinput要素のセレクタ。削除イベントでこのinputのvalを空にする
     * @param {string} preview - 削除するプレビューのセレクタ。
     * @param {function} afterRemove - 画像プレビュー削除後の処理
     */
    static _attachPreviewRemover(
      event,
      removeButton,
      fileInput,
      preview,
      afterRemove
    ) {
      $("body").on(event, removeButton, function() {
        $(fileInput).val("");
        $(preview).remove();
        afterRemove && afterRemove();
      });
    }
  }

  class BasePreviewer extends ImagePreviewer {
    /**
     * @param {string} removeCheckbox - carrierwaveでの画像削除チェックボックスのセレクタ
     * @param  {...any} args
     */
    constructor(removeCheckbox, ...args) {
      super(...args);
      this.removeCheckbox = removeCheckbox;
    }

    /**
     * プレビューを出したら、削除ボタンを表示して削除チェックボックスをオフにする
     */
    _afterPreview() {
      return () => {
        this.constructor._showRemoveButton(
          this.removeButton,
          this.uploadButton
        );
        this.constructor._checkOffFileRemove(this.removeCheckbox);
      };
    }

    /**
     * プレビューを削除したらアップロードボタンを表示してオンにする
     */
    _afterRemove() {
      return () => {
        this.constructor._showUploadButton(
          this.removeButton,
          this.uploadButton
        );
        this.constructor._checkOnFileRemove(this.removeCheckbox);
      };
    }

    static _checkOnFileRemove(removeCheckbox) {
      $(removeCheckbox).prop("checked", true);
    }

    static _checkOffFileRemove(removeCheckbox) {
      $(removeCheckbox).prop("checked", false);
    }
  }

  return {
    BasePreviewer: BasePreviewer
  };
})();
