$(document).ready ()->
  Invoices.init()

window.Invoices =
  init: ()->
    $('.invoice .status').bind 'click', (e)=>
      @id = $(e.target).data('id')
      @checkbox_status = e.target.checked
      @post()

  year: $('.outstanding-balance').data('year')
  month: $('.outstanding-balance').data('month')

  post: ()->
    self = @
    $.ajax
      type: "PUT"
      url: "/admin/invoices/#{@id}"
      data:
        invoice:
          status: @checkbox_status
        year: @year
        month: @month
      dataType: 'script'
