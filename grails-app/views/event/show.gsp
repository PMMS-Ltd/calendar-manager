
<%@ page import="uk.org.pmms.calendar.Event" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'event.label', default: 'Event')}" />
		<title><g:message code="default.show.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#show-event" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="show-event" class="content scaffold-show" role="main">
			<h1><g:message code="default.show.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<ol class="property-list event">
			
				<g:if test="${eventInstance?.summary}">
				<li class="fieldcontain">
					<span id="summary-label" class="property-label"><g:message code="event.summary.label" default="Summary" /></span>
					
						<span class="property-value" aria-labelledby="summary-label"><g:fieldValue bean="${eventInstance}" field="summary"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.startDate}">
				<li class="fieldcontain">
					<span id="startDate-label" class="property-label"><g:message code="event.startDate.label" default="Start Date" /></span>
					
						<span class="property-value" aria-labelledby="startDate-label"><g:formatDate date="${eventInstance?.startDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.endDate}">
				<li class="fieldcontain">
					<span id="endDate-label" class="property-label"><g:message code="event.endDate.label" default="End Date" /></span>
					
						<span class="property-value" aria-labelledby="endDate-label"><g:formatDate date="${eventInstance?.endDate}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.allDay}">
				<li class="fieldcontain">
					<span id="allDay-label" class="property-label"><g:message code="event.allDay.label" default="All Day" /></span>
					
						<span class="property-value" aria-labelledby="allDay-label"><g:formatBoolean boolean="${eventInstance?.allDay}" /></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.location}">
				<li class="fieldcontain">
					<span id="location-label" class="property-label"><g:message code="event.location.label" default="Location" /></span>
					
						<span class="property-value" aria-labelledby="location-label"><g:fieldValue bean="${eventInstance}" field="location"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.description}">
				<li class="fieldcontain">
					<span id="description-label" class="property-label"><g:message code="event.description.label" default="Description" /></span>
					
						<span class="property-value" aria-labelledby="description-label"><g:fieldValue bean="${eventInstance}" field="description"/></span>
					
				</li>
				</g:if>
			
				<g:if test="${eventInstance?.calendar}">
				<li class="fieldcontain">
					<span id="calendar-label" class="property-label"><g:message code="event.calendar.label" default="Calendar" /></span>
					
						<span class="property-value" aria-labelledby="calendar-label"><g:link controller="calendar" action="show" id="${eventInstance?.calendar?.id}">${eventInstance?.calendar?.encodeAsHTML()}</g:link></span>
					
				</li>
				</g:if>
			
			</ol>
			<g:form url="[resource:eventInstance, action:'delete']" method="DELETE">
				<fieldset class="buttons">
					<g:link class="edit" action="edit" resource="${eventInstance}"><g:message code="default.button.edit.label" default="Edit" /></g:link>
					<g:actionSubmit class="delete" action="delete" value="${message(code: 'default.button.delete.label', default: 'Delete')}" onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>
