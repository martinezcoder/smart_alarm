$(document).on('page:change', function() {

  if($('[name^="endpoint[interval]"]:checked').length != 0) {
    $("#interval-container").removeClass("hidden");
    $('#downtime-alert').prop('checked', true);
  }

  $("#downtime-alert").click(function() {
    $('#endpoint_interval_15').prop('checked', true);
    $("#interval-container").removeClass("hidden");
  });

  $("#event-base-alert").click(function() {
    $("#interval-container").addClass("hidden");
    $('[name^="endpoint[interval]"]:checked').prop('checked', false);
  });

  $('form').bind('ajax:error', function(event, data, status, xhr) {
    $('#error-message').html('');
    data.responseJSON.errors.forEach(function(elem) {
      $('#error-message').append('<div>' + elem + '</div>');
      $('.alert-danger').removeClass('hidden');
    })
  })

  $('#add-recipient-btn').click(function(e) {
    e.preventDefault();
    newContactsCount = $(".recipient-select").length;

    copySelect('contact_id', newContactsCount, 9);
    copySelect('kind', newContactsCount, 3);
  })

  $("[name='status']").bootstrapSwitch({
    size: 'mini',
    onSwitchChange: function(event, state) {
      $('.zombie-status').hide();
      var new_status = state ? 1 : 0;
      $.ajax({
        type:'PUT',
        dataType: "json",
        contentType: 'application/json',
        url: "/endpoints/" + event.target.dataset.id,
        data: JSON.stringify({ "endpoint": { "status": new_status } })
      });
    }
  });

  $(".show-endpoint-key").click(function (e) {
    e.preventDefault();
    var endpointKey = $(this).data('key');
    console.log(endpointKey);
    $("#key-container").html(endpointKey);
    $('#showKey').modal('show');
  });
});

function copySelect(attribute, id, columnSize) {
  selectHtml = '<div class="col-md-' + columnSize + '""><select class="form-control recipient-select" ' +
        'name="endpoint[contacts_endpoints_attributes][' + id + '][' + attribute + ']" ' +
        'id="endpoint_contacts_endpoints_attributes_' + id + '_' + attribute + '">' +
        '</select></div>';
  $("#recipients-form .row").append(selectHtml);

  selectOptions = $('#endpoint_contacts_endpoints_attributes_0_' + attribute + '').children().clone();
  $('#endpoint_contacts_endpoints_attributes_' + id + '_' + attribute + '').append(selectOptions);
}
