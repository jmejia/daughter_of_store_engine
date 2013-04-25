alert "hey yo"
<%- flash.each do |name, msg| %>
notice = $('<div class="flash_<%= name %>"></div>')
notice.html('<%= escape_javascript(flash.discard(name.to_sym)) %>')

$('.flash_messages').after(notice[0])
console.log notice[0]
<%- end %>
