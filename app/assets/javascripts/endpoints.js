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
});
