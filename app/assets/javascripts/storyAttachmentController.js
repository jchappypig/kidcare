var app = angular.module('KidcareApp', ['ngResource']);

app.factory('StoryAttachment', ['$resource', function($resource) {
  return $resource('/story_attachments/:id');
}]);

app.factory('StoryAttachments', ['$resource', function($resource) {
  return $resource('/stories/:story_id/story_attachments');
}]);

app.factory('_', ['$window', function($window) {
  'use strict';
  return $window._;
}]);

app.controller('StoryAttachmentController', ['StoryAttachment', 'StoryAttachments', '$scope', '_', function(StoryAttachment, StoryAttachments, $scope, _) {

  $scope.createAttachments = function(_attachments) {
    $scope.attachments = JSON.parse(_attachments);
  };

  $scope.getAttachments = function(story_id) {
    $scope.attachments = StoryAttachments.query({story_id: story_id});
  };

  $scope.removeAttachment = function(attachment) {
    if (confirm("Are you sure?")) {
      StoryAttachment.remove({id: attachment.id});
      $scope.attachments = _.without($scope.attachments, attachment);
    }
  };
}]);
