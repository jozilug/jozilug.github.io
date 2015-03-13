/*jslint indent: 2 */
// Loads information about upcoming JoziLUG meetups via signed Meetup
// API request loaded using JSONP method.  See:
// http://en.wikipedia.org/wiki/JSONP

"use strict";

var fetchevents = function (data) {
  var events = data.results.filter(function (event) {
    return (event.id !== '168152892');
  });
  var last = function (limit,events) {
    return events.splice(0, limit);
  };
  var link = function (event) {
    return "<a href=\"" + event.event_url + "\">" + event.name + "</a>";
  };
  var write_to = function (target, content) {
    target.empty().append(content);
  };

  // definitions
  var upcoming_events = events.filter(function (event) {
    return (event.status === 'upcoming');
  });
  var past_events = events.filter(function (event) {
    return (event.status === 'past');
  });

  // push recent events
  if (upcoming_events.length > 0) {
    write_to($("p.nextup"), "Next up: " + link(upcoming_events.reverse()[0]));
  } else {
    write_to($("p.nextup"), "No upcoming events. :(");
  }
  write_to($("ul.recentmeetups"), last(10,past_events).map(function (event) {
    return "<li>" + link(event) + "</li>";
  }));
};
