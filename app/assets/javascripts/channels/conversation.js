App.conversation = App.cable.subscriptions.create("ConversationChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    var conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    var msgPanel = $('#convo-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
    var alertChat = $('#new-alert');

    if (data['window'] !== undefined) {
      var conversation_visible = conversation.is(':visible');

      if (conversation_visible) {
        var messages_visible = (conversation).find('.panel-body').is(':visible');

        if (!messages_visible) {
          conversation.removeClass('panel-default').addClass('panel-success');
        }
        conversation.find('.messages-list').find('ul').append(data['message']);
        conversation.removeClass('panel-default').addClass('panel-success');

      }
      else {
        conversation.removeClass('panel-default').addClass('panel-success');
        msgPanel.find('#msg-load').addClass('hidden')
        msgPanel.find('#msgUpdate').find('.message-received').remove();
        msgPanel.find('#msgUpdate').append(data['message']);
        msgPanel.find('#msgUpdate').addClass('message-preview');

        // $('#conversations-list').append(data['window']);
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']");
        alertChat.addClass('.shows');
        alert('hey, you just got a new msg');
      }
    }
    else {
      conversation.find('ul').append(data['message']);
      alertChat.addClass('.shows');

    }

    var messages_list = conversation.find('.messages-list');
    var height = messages_list[0].scrollHeight;
    messages_list.scrollTop(height);
  },
  speak: function(message) {
    return this.perform('speak', {
      message: message
    });
  }
});
$(document).on('submit', '.new_message', function(e) {
  e.preventDefault();
  var values = $(this).serializeArray();
  App.conversation.speak(values);
  $(this).trigger('reset');

});
