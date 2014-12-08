<%@ page import="uk.org.pmms.calendar.Calendar" %>



<div class="fieldcontain ${hasErrors(bean: calendarInstance, field: 'name', 'error')} required">
	<label for="name">
		<g:message code="calendar.name.label" default="Name" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="name" required="" value="${calendarInstance?.name}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: calendarInstance, field: 'color', 'error')} required">
	<label for="color">
		<g:message code="calendar.color.label" default="Color" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="color" required="" value="${calendarInstance?.color}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: calendarInstance, field: 'textColor', 'error')} required">
	<label for="textColor">
		<g:message code="calendar.textColor.label" default="Text Color" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="textColor" required="" value="${calendarInstance?.textColor}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: calendarInstance, field: 'events', 'error')} ">
	<label for="events">
		<g:message code="calendar.events.label" default="Events" />
		
	</label>
	
<ul class="one-to-many">
<g:each in="${calendarInstance?.events?}" var="e">
    <li><g:link controller="event" action="show" id="${e.id}">${e?.encodeAsHTML()}</g:link></li>
</g:each>
<li class="add">
<g:link controller="event" action="create" params="['calendar.id': calendarInstance?.id]">${message(code: 'default.add.label', args: [message(code: 'event.label', default: 'Event')])}</g:link>
</li>
</ul>


</div>

