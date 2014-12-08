<%@ page import="uk.org.pmms.calendar.Event" %>



<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'summary', 'error')} required">
	<label for="summary">
		<g:message code="event.summary.label" default="Summary" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="summary" required="" value="${eventInstance?.summary}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'startDate', 'error')} required">
	<label for="startDate">
		<g:message code="event.startDate.label" default="Start Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="startDate" precision="minute"  value="${eventInstance?.startDate}"  />
	<!-- <input type="datetime-local" name="startDate" id="startDate" value="<g:formatDate format="yyyy-MM-dd'T'HH:mm" date="${eventInstance.startDate }"/>">-->

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'endDate', 'error')} required">
	<label for="endDate">
		<g:message code="event.endDate.label" default="End Date" />
		<span class="required-indicator">*</span>
	</label>
	<g:datePicker name="endDate" precision="minute" value="${eventInstance?.endDate}"  />
	<!-- <input type="datetime-local" name="endDate" id="endDate" value="<g:formatDate format="yyyy-MM-dd'T'HH:mm" date="${eventInstance.endDate }"/>">-->

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'allDay', 'error')} ">
	<label for="allDay">
		<g:message code="event.allDay.label" default="All Day" />
		
	</label>
	<g:checkBox name="allDay" value="${eventInstance?.allDay}" />

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'location', 'error')} required">
	<label for="location">
		<g:message code="event.location.label" default="Location" />
		<span class="required-indicator">*</span>
	</label>
	<g:textField name="location" required="" value="${eventInstance?.location}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'description', 'error')} required">
	<label for="description">
		<g:message code="event.description.label" default="Description" />
		<span class="required-indicator">*</span>
	</label>
	<g:textArea name="description" cols="40" rows="5" maxlength="9092" required="" value="${eventInstance?.description}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'calendar', 'error')} required">
	<label for="calendar">
		<g:message code="event.calendar.label" default="Calendar" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="calendar" name="calendar.id" from="${uk.org.pmms.calendar.Calendar.list()}" optionKey="id" required="" value="${eventInstance?.calendar?.id}" class="many-to-one"/>

</div>
<div class="fieldcontain ${hasErrors(bean: eventInstance, field: 'eventType', 'error')} required">
	<label for="eventType">
		<g:message code="event.eventType.label" default="Event Type" />
		<span class="required-indicator">*</span>
	</label>
	<g:select id="eventType" name="eventType" from="${uk.org.pmms.calendar.Event.constraints.eventType.inList}" required="" value="${eventInstance?.eventType}" class="one-to-one"/>

</div>

