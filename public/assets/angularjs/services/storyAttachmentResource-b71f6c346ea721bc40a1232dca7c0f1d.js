App.factory('StoryAttachment', ['$resource', function($resource) {
  'use strict';

  return $resource('/story_attachments/:id');
}]);
