$(function () {
  $('#fileupload').fileupload({
    dataType: 'json',
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('.progress .meter').css(
        'width',
          progress + '%'
      );
    },
    add: function (e, data) {
      $('#fileupload .story-image').remove();
      $.each(data.files, function (index, file) {
        var reader = new FileReader();
        reader.onload = function(e) {
          $('#fileupload').parent().after('<img src="'+ e.target.result +'" class="story-image"></img>');
        }
        reader.readAsDataURL(file);
      });
        data.submit();
    }
  });
});
