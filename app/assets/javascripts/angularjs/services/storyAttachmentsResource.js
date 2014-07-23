App.factory('StoryAttachments', ['$resource', function($resource) {
  'use strict';

  return $resource('/stories/:story_id/story_attachments');
}]);
