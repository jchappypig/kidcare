var app = angular.module('KidcareApp', ['ngResource']);

app.factory('StoryAttachment', ['$resource', function($resource) {
  $resource("/story_attachments/:id");
}]);

app.factory('_', ['_', function($window) {
  'use strict';
  return $window._;
}]);

app.controller('StoryAttachmentController', ['StoryAttachment', '$scope', '_', function(StoryAttachment, $scope, _) {

  $scope.createAttachments = function(_attachments) {
    $scope.attachments = JSON.parse(_attachments);
  };

  $scope.removeAttachment = function(attachment) {
    StoryAttachment.remove({id: attachment.id});
    $scope.attachments = _.without($scope.attachments, attachment);
  };
}]);
