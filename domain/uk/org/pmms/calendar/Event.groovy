package uk.org.pmms.calendar

import java.util.Date;

class Event implements Comparable{

    String summary
    Date startDate
    Date endDate
    Boolean allDay=Boolean.FALSE
    String location
    String description
	String eventType

    Calendar calendar

    static belongsTo = [calendar:Calendar]

    static constraints = {
        summary()
        startDate(attributes:[precision:"minute"])
        endDate(attributes:[precision:"minute"])
        allDay()
        location()
        description(maxSize:9092)
		eventType inList: ["Directors Meeting", "Site Visit", "AGM", "Other"]
    }

    public int compareTo(Object that){
        startDate.compareTo(that.startDate)
    }

    public String toString(){
        summary
    }
}
