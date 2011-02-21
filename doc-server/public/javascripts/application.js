function toggle_html(v) {
  var v = $('#toggle-html-output').is(':checked');
  $.cookie("textile_html_visible", v ? "true" : null, {path: '/'});
  html_visible(v, "slow");
}

function html_visible(show, speed) {
  elements = $(".example .html");
  if (show == undefined) show = $.cookie("textile_html_visible");
  if (!speed) speed = 0;
  if (show)
    elements.slideDown(speed);
  else
    elements.slideUp(speed);
}


$(document).ready(function() {
  $('#toggle-html-output').change(function() {
    toggle_html();
  }).attr('checked', $.cookie("textile_html_visible"));
  
  html_visible();
});


// FIXME: cookie stores "true" or "false" instead of true or false