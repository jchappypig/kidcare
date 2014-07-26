App.factory('StoryAttachments', ['$resource', function($resource) {
  'use strict';

  return $resource('/story_attachments/:guid');
}]);
