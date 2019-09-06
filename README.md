# eventify app

Event - Clojure CRUD app with REST service and Bootstrap.

## Usage

There is also event.sql file with some dummy data that needs to be imported.

To start a web server for the application, run:
```
lein ring server
```

####REST service

http://localhost:3000/api/all - This will get all events from database and display it as JSON.

http://localhost:3000/- Home page is here.

Make sure to enter correct values for prices and hosts when editing or adding event.(input should be comma separated value)

for prices value input is: 1,2,3,10

for hosts valid input is: FONIS,AIESEC,FON

Make sure that when entering host names, that host really exist in host_names table.

Example:

```JSON
[
  {
    "event_id":"cf6d07d4-20cb-415f-9f07-d67a6c050425",
    "description":"Electro dance festival in Petrovaradin fortress",
    "event_date_time":"2019-01-09T09:20:00Z",
    "event_name":"Exit festival","event_type":"THEATER",
    "profile_picture":"https://www.delfi.rs/_img/artikli/2015/05/pop_cira_i_pop_spira_vv.jpg",
    "place_names":"Petrovaradinska tvrdjava",
    "host_names":null,
    "source":"www.facebook.rs",
  },
  {
    "event_id":"a6026642-1e25-481a-aba5-1f36b1f273f5",
    "description":"Zona desc",
    "event_date_time":"2019-01-02T11:30:00Z",
    "event_name":"Zona zamfirova",
    "event_type":"THEATER",
    "profile_picture":"https://m.media-amazon.com/images/M/MV5BMGYxNjRiMTYtYWZmYi00ODg1LWI2Y2UtMzUyMmRhMTcwZjNhXkEyXkFqcGdeQXVyMzIwMTIwODc@._V1_.jpg",
    "place_names":"Tvrdjava Smederevo",
    "host_names":null,
    "source":"www.google.rs",
  }
]
```
## License

Copyright © 2019