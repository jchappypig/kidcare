$(function () {
  $('#fileupload').fileupload({
    dataType: 'json',
    progressall: function (e, data) {
      var progress = parseInt(data.loaded / data.total * 100, 10);
      $('.progress .meter').css(
        'width',
          progress + '%'
      );

      $('.meter').text(progress + '%')

      if(progress === 100) {
        window.alert('Upload completed!');
        $('.story-images').click();
      }
    }
  });
});
