App.controller('StoryAttachmentController', ['StoryAttachment', 'StoryAttachments', '$scope', '_', function(StoryAttachment, StoryAttachments, $scope, _) {
  var storyId;

  var setAttachments = function() {
    $scope.attachments = StoryAttachments.query({story_id: storyId});
  };

  $scope.getAttachments = function(story_id) {
    storyId = story_id;
    setAttachments();
  };

  $scope.removeAttachment = function(attachment) {
    if (confirm("Are you sure?")) {
      StoryAttachment.remove({id: attachment.id});
      setAttachments();
    };
  };
}]);
