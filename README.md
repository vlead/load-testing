Virtual Labs Load Testing
=========================

Load test vlabs web servers.


Introduction
------------

This tool is designed to load/stress test the web server(s) running the virtual
labs. This includes testing the main landing page which is the entry page for the
portal as well as the pages for specific labs. The endpoints that should be load
tested can be provided in a configuration file.

This tool should generate aggregated reports which can help us find, generally,
what is the load capacity of our portal, and capacity of each our labs.
Following which, the web server or other systems can be configured to optimize
the portal or a specific lab.


Methodology
-----------

* We use the cannonical load testing tool from Apache called (ab)[]. This tool
  can generate multiple concurrent requests, and measure connect, waiting and
response times for each request, and can give aggregated or granular report of
its measurements.

* Two high-level parameters for the test -
  1) No of requests / No of concurrent requests
  2) Physical location

* No of requests/concurrent requests - We tweak the number of requests sent as
  well the number of concurrent requests, and aggregate them.
  The tool is capable of taking three discrete values for each of -
  i) number of requests
  ii) number of concurrent requests.
  These can set via a configuration file.

  Also, gradually increasing the number of requests or concurrent requests can
  give us an idea about the threshold capacity of the web server(s), i.e
  after the point the performance starts decreasing significantly.

* Physical location can give us more insight into network latency issues. We
  have three levels of physical location -
  - Inside the same subnet as the web server(s) located.
  - Inside the same network as the web server(s) located.
  - Outside the network of where the web server(s) located.

  That means we have to run the tests from three different locations and
  compare their reports manually.

* For each endpoint, we run the test according to the above parameters. So, for
  each URL we will have 9 outputs that the ab tool will generate. We parse
  through those 9 outputs and select the important parameters for our testing
  purposes and aggregate them into one single report.

  The important parameters for our testing purposes are -
  i) Time taken for tests
  ii) Completed Requests
  iii) Failed Requests
  iv) Requests per second (mean)
  v) Time per request (mean, across all concurrent requests)
  vi) Connect time (min, mean, sd, median, max)
  vii) Waiting time (min, mean, sd, median, max)

