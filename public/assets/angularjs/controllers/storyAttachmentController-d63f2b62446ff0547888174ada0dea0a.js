App.controller('StoryAttachmentController', ['StoryAttachment', 'StoryAttachments', '$scope', '_', function(StoryAttachment, StoryAttachments, $scope, _) {
  var storyGuid;

  $scope.getAttachments = function(_storyGuid) {
    storyGuid = _storyGuid;
    $scope.attachments = StoryAttachments.query({guid: storyGuid});
  };

  $scope.removeAttachment = function(attachment) {
    if (confirm("Are you sure?")) {
      $scope.attachments = _.filter($scope.attachments, function(_attachment) {
        return _attachment.id !== attachment.id
      });
      StoryAttachment.remove({id: attachment.id});
    };
  };

  $scope.refreshAttachments = function() {
    var newAttachments = StoryAttachments.query({guid: storyGuid}, function() {
      var currentAttachments = $scope.attachments;
      _.each(newAttachments, function(newAttachment) {
        if(_.where(currentAttachments, {id: newAttachment.id}).length == 0) {
          $scope.attachments.push(newAttachment);
        };
      });
    });
  }
}]);
