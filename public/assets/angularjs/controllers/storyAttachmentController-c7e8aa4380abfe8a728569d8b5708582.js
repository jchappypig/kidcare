App.controller("StoryAttachmentController",["StoryAttachment","StoryAttachments","$scope","_",function(t,e,n,r){var c;n.getAttachments=function(t){c=t,n.attachments=e.query({guid:c})},n.removeAttachment=function(e){confirm("Are you sure?")&&(n.attachments=r.filter(n.attachments,function(t){return t.id!==e.id}),t.remove({id:e.id}))},n.refreshAttachments=function(){var t=e.query({guid:c},function(){var e=n.attachments;r.each(t,function(t){0==r.where(e,{id:t.id}).length&&n.attachments.push(t)})})}}]);