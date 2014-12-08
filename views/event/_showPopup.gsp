<%@ page import="org.joda.time.Instant" %>

<div class="eventPopup">
<h1>Event Details</h1>
	<h3>${eventInstance.summary}</h3>
	<p class="date">
	    Start: <g:formatDate date="${eventInstance.startDate}" format="E, MMM d, hh:mma"/> <br />
	    End: <g:formatDate date="${eventInstance.endDate}" format="E, MMM d, hh:mma"/>
	</p>
		<h2>Description</h2>
		${eventInstance.description }
	
		<h2>Location</h2>
		${eventInstance.location }
		<br/>
		<g:link class="btn btn-default btn-sm" action="edit" id="${eventInstance.id }"><i class="glyphicon glyphicon-pencil"></i> Edit Event</g:link>
</div>