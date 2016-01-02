$(document).on('page:load', function() {

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
});