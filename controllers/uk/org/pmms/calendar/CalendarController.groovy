package uk.org.pmms.calendar

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

import grails.converters.JSON

@Transactional(readOnly = true)
class CalendarController {
	//def scaffold = true
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
		respond Calendar.list(params)
    }
	def search() {
		def c = Calendar.createCriteria()
		def results = c.list(params) {
			ilike("name", "%"+params.q+"%")
		}
		render results as JSON
	}
	

    def create() {
        respond new Calendar(params)
    }

    @Transactional
    def save(Calendar calendar) {
		
		
        if (calendar == null) {
            notFound()
	
            return
        }
		
        if (calendar.hasErrors()) {
            respond calendar.errors, view:'create'
            return
        }

        calendar.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'calendar.label', default: 'Calendar'), calendar.id])
                redirect(controller: "calendar", action: "index")
            }
            '*' { respond calendar, [status: CREATED] }
			json {
				render calendar.id
			}
        }
    }

    def edit(Calendar calendar) {
        respond calendar
    }
	def show(Calendar calendar) {
		request.withFormat {
			json{ render (id: calendar.id, name: calendar.name, color: calendar.color, textColor: calendar.textColor, eventCount: calendar.events.size()) as JSON}
			'*' { respond calendar }
		}
		
	}

    @Transactional
    def update(Calendar calendar) {
        if (calendar == null) {
            notFound()
            return
        }

        if (calendar.hasErrors()) {
            respond calendar.errors, view:'edit'
            return
        }

        calendar.save flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'Calendar.label', default: 'Calendar'), calendar.id])
                redirect calendar
            }
            '*'{ respond calendar, [status: OK] }
        }
    }

    @Transactional
    def delete(Calendar calendar) {

        if (calendar == null) {
            notFound()
            return
        }

        calendar.delete flush:true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'Calendar.label', default: 'Calendar'), calendar.id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'calendar.label', default: 'Calendar'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
	
	def ical={
		render createIcal(Long.parseLong(params.id))
	}

	private String createIcal(long id){
		def df=new java.text.SimpleDateFormat("yyyyMMdd'T'HHmmss")
		Calendar c=Calendar.get(id)
		def ical='''BEGIN:VCALENDAR
X-WR-CALNAME:'''+c.name+'''
X-WR-CALDESC:GRAILS Plugin Calendar
PRODID:-//Francois-Xavier Thoorens/NONSGML Bennu 0.1//EN
VERSION:2.0
'''
        c.events.each{
            ical+="BEGIN:VEVENT\n"
            ical+="UID:"+c.name+it.id+"@grails\n"
            ical+="DTSTAMP:"+df.format(new Date())+"Z\n"
            ical+="SUMMARY:"+it.summary+"\n"
            ical+="DTSTART:"+df.format(it.startDate)+"\n"
            ical+="DTEND:"+df.format(it.endDate)+"\n"
            ical+="DESCRIPTION:"+it.description+"\n"
            ical+="LOCATION:"+it.location+"\n"
            ical+="END:VEVENT\n"
        }
        ical+="END:VCALENDAR\n"
        return ical
    }
}
