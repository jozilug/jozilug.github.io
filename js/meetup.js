// Loads information about upcoming JoziLUG meetups via signed Meetup
// API request loaded using JSONP method.  See:
// http://en.wikipedia.org/wiki/JSONP

// Author: Daniel Fowler

var fetchevents = function(data) {
    var limit = 10;
    var valid_events = data.results.filter(function(element){return (element.id != '168152892')}).splice(0,limit);
    var upcoming_events = data.results.filter(function(element){return (element.status == 'upcoming')});

    if (valid_events.length > 0) {
	listrecent(valid_events);
    };

    if (upcoming_events.length > 0) {
	next_event = upcoming_events.reverse()[0];
	var link = "Next up: <a href=\"" + next_event.event_url + "\">" + next_event.name + "</a>";
	$("p.nextup").empty().append(link);
    } else {
	$("p.nextup").empty().append("No upcoming events. :(");
    }
}

var listrecent = function(events) {
    $("ul.recentmeetups").empty();
    $.each(events,function(key,past_event){
	var link = "<li><a href=\"" + past_event.event_url + "\">" + past_event.name + "</a>" + "</li>";
	$("ul.recentmeetups").append(link);
    });
}
