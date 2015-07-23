# hapi-fhir Vagrant Wrapper

A fork of the [upstream](https://github.com/jamesagnew/hapi-fhir/tree/master/vagrant)
Vagrant and Chef script to run the HAPI FHIR server.

Just run `vagrant up`: this will setup a new VM with Tomcat and MySQL, download (`master`
branch of the `jamesagnew/hapi-fhir` repo) FHIR and build and install it.

The Tomcat Application Manager can then be accessed at
[`localhost:8080/manager/html](http://localhost:8080/manager/html), a HAPI client to access
a public demo FHIR server at
[`localhost:8080/hapi-fhir-jpaserver/](http://localhost:8080/hapi-fhir-jpaserver/), and a
HAPI server at [`localhost:8080/hapi-fhir-jpaserver-example/](http://localhost:8080/hapi-fhir-jpaserver-example/).

The MySQL root password is `MySQLpassword` and the following credentials can be used for
Tomcat/FHIR authentication:

    user: fhir
    password: FHIRDefaultPassword

To configure or modify HAPI, update the source in the `src/` directory and then rebuild by
running the following commands in the Vagrant VM (`vagrant ssh` gives you a shell):

    /usr/local/maven-*/bin/mvn clean install
    /usr/local/maven-*/bin/mvn package
    cp **/target/*.war /var/lib/tomcat7/webapps

All third-party Chef recipes used are git submodules so can be updated accordingly, apart from
`nmap` which has no git repository and `mysql` and `tomcat` which use the forked versions from HAPI
upstream (forked because of various bugs in Chef recipe upstream).
