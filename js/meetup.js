/*jshint browser: true */
// Loads information about upcoming JoziLUG meetups via signed Meetup
// API request loaded using JSONP method.  See:
// http://en.wikipedia.org/wiki/JSONP

var fetchevents = function (data) {
  'use strict';

  var events = data.results.filter(function (event) {
    return (event.id !== '168152892');
  }),
      last = function (limit, events) {
        return events.splice(0, limit);
      },
      link = function (event) {
        return '<a href=\'' + event.event_url + '\'>' + event.name + '</a>';
      },
      write_to = function (target, content) {
        target.innerHTML = content;
      },
      upcoming_events = events.filter(function (event) {
        return (event.status === 'upcoming');
      }),
      past_events = events.filter(function (event) {
        return (event.status === 'past');
      });

  // push recent events
  if (upcoming_events.length > 0) {
    write_to(document.getElementById('nextup'), 'Next up: ' + link(upcoming_events.reverse()[0]));
  } else {
    write_to(document.getElementById('nextup'), 'No upcoming events. :(');
  }

  write_to(document.getElementById('recentmeetups'), last(10,past_events).map(function (event) {
    return '<li>' + link(event) + '</li>';
  }).join(''));
};
