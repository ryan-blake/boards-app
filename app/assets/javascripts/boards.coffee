# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
 jQuery ->
  $("#category-select").hide();

  $("#type-select").change ->
    $("#category-select").show();

# jQuery ->
#   subcat = $('#category-select').html()
#   $('#category-select').click ->
#     type = jQuery('#type-select').children('option').filter(':selected').text()
#     options = $(subcat).filter("optgroup[label='#{type}']").html()
#     if options
#       $('#category-select').html(options)
#       console.log('hi');
#     else
#       $('#category-select').empty()
# $ ->
#   $(document).on 'change', '#type-select', (evt) ->
#     $.ajax 'index',
#       type: 'GET'
#       dataType: 'script'
#       data: {
#         type_id: $("#type-select option:selected").val()
#       }
#       error: (jqXHR, textStatus, errorThrown) ->
#         console.log("AJAX Error: #{textStatus}")
#       success: (data, textStatus, jqXHR) ->
#         console.log("Dynamic country select OK!")
