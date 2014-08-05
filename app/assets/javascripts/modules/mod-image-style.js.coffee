# Desc
#   .mod-image-style以下のimgタグにstyle用のclassをつける
# Usage:
# Example:

$ ->
  $('.mod-image-style').find('img').addClass('img-thumbnail')

  $('.mod-image-style').find('img').parent('a')
    .append("""<button type="button" class="btn btn-info btn-lg">
      <span class="glyphicon glyphicon-share"></span> Open in New Tab
      </button>""")
