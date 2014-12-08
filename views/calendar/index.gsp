<%@ page import="uk.org.pmms.calendar.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta name="layout" content="PMMS">
<r:require module="calendar"/>
</head>
<body>
	<div class="row">
		<div class="col-xs-8">
			<div id="fullCalendar"></div>
		</div>
		<div class="col-xs-4">
			
		</div>
	</div>
	<div class="modal fade" id="myModal">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
        <h4 class="modal-title">New Event</h4>
      </div>
      <div class="modal-body">
        <g:form class="form-horizontal" role="form" name="newEventForm" url="[action:'save', controller:'event']">
         <div class="form-group">
		    <label for="end" class="col-sm-3 control-label">Summary</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="summary" name="summary">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="start" class="col-sm-3 control-label">Start</label>
		    <div class="col-sm-6">
		      <input type="datetime" class="form-control" id="start" name="startDate">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="end" class="col-sm-3 control-label">End</label>
		    <div class="col-sm-6">
		      <input type="datetime" class="form-control" id="end" name="endDate">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="end" class="col-sm-3 control-label">Location</label>
		    <div class="col-sm-6">
		      <input type="text" class="form-control" id="location" name="location">
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="end" class="col-sm-3 control-label">Description</label>
		    <div class="col-sm-6">
		     <textarea rows="5" cols="10" id="description" name="description" class="form-control"></textarea>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="eventType" class="col-sm-3 control-label">Event Type</label>
		    <div class="col-sm-6">
		     <g:select name="eventType" class="form-control" from="${uk.org.pmms.calendar.Event.constraints.eventType.inList}"/>
		    </div>
		  </div>
		  <div class="form-group">
		    <label for="calendar" class="col-sm-3 control-label">Calendar</label>
		    <div class="col-sm-6">
		     <g:select name="calendar" class="form-control" from="${calendarInstanceList}" optionKey="id" optionValue="name"/>
		    </div>
		  </div>
		</g:form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary" id="addEvent">Save changes</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->	
	<g:javascript>	
$("#fullCalendar").fullCalendar({
				firstDay: 1,
				weekends: false,
				minTime: "08:00:00",
				maxTime: "23:00:00",
				header:{
					left: 'prev, today, next',
					center: 'title',
					right: 'month, agendaWeek, agendaDay'
				},
				buttonIcons:{
					prev: 'left-single-arrow',
				    next: 'right-single-arrow'
				},
				eventSources: [
					<g:each in="${calendarInstanceList }" var="cal">
						{url: '${request.contextPath }/calendar/${cal.id }/events'},
					</g:each>
				],
				contentHeight: 775,
				editable: true,
				selectable: true,
				select: function(start, end){
					//alert ("Show New-Event-Modal from " + start + " to " + end + ".")
					$("#newEventForm input#start").val(start.toISOString())
					$("#newEventForm input#end").val(end.toISOString());
					$("#myModal").modal('show');
				},
				eventResize: function(event, delta, revertFunc) {
			      if (window.confirm("Are you sure you want to change this event?")) {
			       $.ajax ({
			        	url: contextPath+"/event/resize/"+event.id,
			        	type: "POST",
			        	
			        	data: {
			        		data: delta.asMilliseconds()
			        	}
			        });
			        }
				},
			    eventDrop: function(event, delta, revertFunc) {
					if (window.confirm("Are you sure you want to change this event?")) {
			        $.ajax ({
			        	url: contextPath+"/event/drop/"+event.id,
			        	type: "POST",
			        	
			        	data: {
			        		data: delta.asMilliseconds()
			        	}
			        });
			        }
			    },
			    eventClick: function(calEvent, jsEvent, view) {
			    	$.ajax({
			    		url: contextPath+"/event/show/"+calEvent.id,
			    		type: 'GET',
			    		success: function(data){
			    			$("#sidebar").html(data);
			    		}
			    	})
			    }
			});

	</g:javascript>
</body>

</html>