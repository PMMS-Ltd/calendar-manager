modules = {
    application {
      
		resource url:'https://code.jquery.com/jquery-2.1.1.min.js'
		resource url:'https://code.jquery.com/ui/1.10.4/jquery-ui.min.js'
		resource url:'http://cdnjs.cloudflare.com/ajax/libs/moment.js/2.8.3/moment.min.js'
		resource url:'http://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.1.1/fullcalendar.min.js'
		resource url:'http://cdnjs.cloudflare.com/ajax/libs/fullcalendar/2.1.1/fullcalendar.css'
    }
	calendar {
		dependsOn 'application'
		resource url: 'js/calendar.js'
	}
}