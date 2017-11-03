// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require jquery
//= require bootstrap-sprockets
//= require plotly
//= require jquery-tablesorter
//= require spin
//= require jquery.spin
//= require_tree .

$(document).on('turbolinks:load', function() {
	var updateHeadBlock = setInterval(function() {
		$.ajax({
			method: 'GET',
			url: '/head_block'
		}).done(function(data){
			$('#currentBlock').text(data.head_block_num);
		});
	}, 3000);

	$('#blockNumLink').click(function(e){
		e.preventDefault();
	});

  particleground(document.getElementById('particles'), {
    dotColor: '#5cbdaa',
    lineColor: '#5cbdaa'
  });
  var intro = document.getElementById('intro');
  intro.style.marginTop = - intro.offsetHeight / 2 + 'px';
});
