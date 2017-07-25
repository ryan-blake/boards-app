# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $(document).on "upload:start", "form", (e) ->
    $(this).find("input[type=submit]").attr "disabled", true
    $("#progress-bar").slideDown('fast')

  $(document).on "upload:progress", "form", (e) ->
    detail          = e.originalEvent.detail
    percentComplete = Math.round(detail.loaded / detail.total * 100)
    $('.progress-bar').width("90%");
    $("#progress-bar-text").text("#{percentComplete}% Complete")

  $(document).on "upload:success", "form", (e) ->
        $(this).find("input[type=submit]").removeAttr "disabled"  unless $(this).find("input.uploading").length
        $("#progress-bar").slideUp('fast')


 jQuery ->
  $("#category-select").hide();

  $("#type-select").change ->
    $("#category-select").show(0);

jQuery ->
  subcat = $('#category-select').html()
  $('#category-select').click ->
    type = jQuery('#type-select').children('option').filter(':selected').text()
    options = $(subcat).filter("optgroup[label='#{type}']").html()
    if options
      $('#category-select').html("<option value=''></option>" + options)
      $('#category-select option:first').attr("selected", "selected");
      $('#category-select').html(options)
    else
      $('#category-select').empty()
$ ->
  $(document).on 'change', '#type-select', (evt) ->
        $('#resultsCount').innerHTML = '#type-select'
        $.ajax '/boards/search_type',
          type: 'GET'
          dataType: 'script'
          data: {
            type_id: $("#type-select option:selected").val()
          }

      error: (jqXHR, textStatus, errorThrown) ->
        console.log("AJAX Error: #{textStatus}")
      success: (data, textStatus, jqXHR) ->
        console.log("Dynamic country select OK!")

 jQuery ->
  $("#category-select-user").hide();

  $("#type-select-user").change ->
    $("#category-select-user").show(0);

jQuery ->
  subcat = $('#category-select-user').html()
  $('#category-select-user').click ->
    type = jQuery('#type-select-user').children('option').filter(':selected').text()
    options = $(subcat).filter("optgroup[label='#{type}']").html()
    if options
      $('#category-select-user').html("<option value=''></option>" + options)
      $('#category-select-user option:first').attr("selected", "selected");
      $('#category-select-user').html(options)
    else
      $('#category-select-user').empty()
