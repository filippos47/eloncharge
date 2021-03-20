# Elon-Charge

Elon-Charge is a platform that aims to connect electric vehicle drivers and
electric station operators. Both parties can get personalised analytics and
statistics regarding past EV charges, navigating through a stripped-down,
to-the-point UI. Specialized administrative operations can also be performed
through a no-nonsense CLI interface.

## Setting up

Please follow the instructions on the [deployment](deployment) directory.

## Structure

* [Back End](back-end): The implementation of the REST API written in
  Python/Django.
* [Front End](front-end): The front end of the application written in React.
* [CLI Client](cli-client): A CLI tool written in Python (using `argparse` module)
  that interfaces with the REST API.

## Documentation

The [documentation](documentation) directory contains the documentation for
Elon-Charge. Specifically, it contains [UML diagrams](documentation/static_v2)
in `.pdf` format and the {Software,Stakeholders} Requirements Specifications.

## Authors

Alphabetically,

* Dionysios Ntelis
* Filippos Malandrakis
* Vitalios Salis
