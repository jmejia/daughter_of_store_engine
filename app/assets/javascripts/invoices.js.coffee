$(document).ready ()->
  Invoices.init()

window.Invoices =
  init: ()->
    $('.invoice .status').bind 'click', (e)=>
      @id = $(e.target).data('id')
      @checkbox_status = e.target.checked
      @post()

  post: ()->
    self = @
    $.ajax
      type: "PUT"
      url: "/admin/invoices/#{@id}"
      data: {invoice: {status: self.checkbox_status}}
      dataType: 'script'
