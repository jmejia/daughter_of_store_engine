<%- flash.each do |name, msg| %>
Invoices.notice = $('<div class="<%= name %> alert-success"><%= escape_javascript(flash.discard(name.to_sym)) %></div>')

$('.flash_messages').append(Invoices.notice[0])
$(Invoices.notice[0]).delay(2000).fadeOut ()->
  $(Invoices.notice).remove()
<%- end %>
$('.outstanding-balance').html('<%= amount_in_dollars(@outstanding_balance)%>')
