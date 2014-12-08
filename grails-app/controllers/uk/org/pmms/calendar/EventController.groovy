package uk.org.pmms.calendar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional
import grails.converters.JSON
import java.text.DateFormat
import java.text.SimpleDateFormat
import org.joda.time.Duration
import org.joda.time.DateTime

@Transactional(readOnly = false)
class EventController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
	DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm", Locale.ENGLISH);
	DateFormat dfShort = new SimpleDateFormat("yyyy-MM-dd", Locale.ENGLISH);
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond Event.list(params), model:[eventInstanceCount: Event.count()]
    }

    def show(Event eventInstance) {
		request.withFormat{
			'*'{
				def model = [eventInstance: eventInstance, occurrenceStart: params.long('occurrenceStart'), occurrenceEnd: params.long('occurrenceEnd')]
				render (template: "showPopup", model: model)
			}
		}
        respond eventInstance
    }

    def create() {
		if(params.startDate){
			params.startDate = new Date(Long.parseLong(params.startDate))
			params.endDate = new Date(Long.parseLong(params.endDate))
		}
        respond new Event(params)
    }
	def listEvents = {
		def cal = Calendar.get(params.id.toInteger())
		//def events = Event.findAllByCalendar(cal)
		def c = Event.createCriteria()
		def events = c.list(){
			eq ('calendar', cal)
			ge ('startDate',dfShort.parse(params.start))
			le ('endDate', dfShort.parse(params.end))
		}
		render events as JSON
	}
	
    @Transactional
    def save() {
		if(!params){
			notFound()
			return
		}
		
		if (params.startDate){
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
			params.startDate = df.parse(params.startDate)
			params.endDate = df.parse(params.endDate)
		}
		Event eventInstance = new Event(params)
		if (eventInstance.hasErrors()) {
			respond eventInstance.errors, view:'create'
			render eventInstance.errors as JSON
		   return
		}else{
			eventInstance.save(flush:true, failOnError: true)
			redirect(controller:"calendar", action:"index")
		}
    }

    def edit(Event eventInstance) {
        respond eventInstance
    }

    @Transactional
    def update(Event eventInstance) {
        if (eventInstance == null) {
            notFound()
            return
        }
		/*if (params.startDate){
			
			eventInstance.startDate = df.parse(params.startDate)
			eventInstance.endDate = df.parse(params.endDate)
			//eventInstance.startDate = params.startDate
			//eventInstance.endDate = params.endDate
		}*/
		
        if (eventInstance.hasErrors()) {
			
            respond eventInstance.errors, view:'edit'
			//render eventInstance.errors as JSON
            return
        }

        eventInstance.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Event.label', default: 'Event'), eventInstance.id])
                redirect eventInstance
            }
            '*'{ respond eventInstance, [status: OK] }
        }
    }

    @Transactional
    def delete(Event eventInstance) {

        if (eventInstance == null) {
            notFound()
            return
        }

        eventInstance.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Event.label', default: 'Event'), eventInstance.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'event.label', default: 'Event'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	def resize() {
		
		def e = Event.get(params.id)
		if (e!=null){
			Duration delta = new Duration(params.data.toLong())
			DateTime endDate = new DateTime(e.endDate)
			endDate = endDate.plus(delta)
			e.endDate = endDate.toDate()
			e.save(flush:true, failOnError: true)
			render "ok"
		}else{
			render "Error"
		}
	}
	def drop() {
		
		def e = Event.get(params.id)
		if (e!=null){
			Duration delta = new Duration(params.data.toLong())
			DateTime startDate = new DateTime(e.startDate)
			DateTime endDate = new DateTime(e.endDate)
			startDate = startDate.plus(delta)
			endDate = endDate.plus(delta)
			e.startDate = startDate.toDate()
			e.endDate = endDate.toDate()
			e.save(flush:true, failOnError: true)
			render "ok"
		}else{
			render "Error"
		}
	}
	def count(params){
		def calendar = Calendar.get(params.id)
		if (calendar){
			render calendar.events.size()
		}
		else{
			render '0'
		}
	}
}