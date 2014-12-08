package uk.org.pmms.calendar

import java.util.SortedSet;

class Calendar {

    String name
    String color
    String textColor
    SortedSet events

    static hasMany = [events:Event]

    static constraints = {
        name()
        color()
        textColor()
    }
	
    public String toString(){
        name
    }
}
