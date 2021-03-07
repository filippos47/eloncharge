import React from 'react'
import { connect } from "react-redux"
import DatePicker from "react-datepicker"
import "react-datepicker/dist/react-datepicker.css";

import { retrieve_cars } from "../redux/async";
import Car from "../components/Car"
import { Container, Row, Col, ButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';


class Driver extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            startDate: new Date("2021-01-01"),
            endDate: new Date(),
            dropdownOpen: false,
            selectedCar: ""
        };
    }

    componentDidMount() {
        if (this.props.token === '') {
            this.props.history.push("/")
        }

        const retrieve_cars_thunk = retrieve_cars(this.props.token);
        this.props.dispatch(retrieve_cars_thunk);
    }

    toggle() {
        this.setState({ dropdownOpen: !this.state.dropdownOpen });
    }

    selectCar(e) {
        this.setState({ selectedCar: e.currentTarget.textContent  })
    }

    startDateChanged(d) {
        this.setState({startDate: d});
    }

    endDateChanged(d) {
        this.setState({endDate: d});
    }

    getCars() {
        const carToShow = [], carNames = [];

        console.log(this.props.cars)

        Object.keys(this.props.cars).map(function(key) {
            carNames.push( [this.props.cars[key].name, key] )
        }.bind(this));

        Object.keys(carNames).map(function(key) {
            let carName=carNames[key][0], carKey = carNames[key][1]
            if (carName === this.state.selectedCar) {
                carToShow.push(<Car
                    key={`car-${carKey}`}
                    car={ this.props.cars[carKey] }
                    startDate={ this.state.startDate }
                    endDate={ this.state.endDate } />)
            }
        }.bind(this));

        return (
            <Container>
                <Row>
                    <Col>
                        <ButtonDropdown className="above-table" isOpen={ this.state.dropdownOpen } toggle={ this.toggle.bind(this) }>
                            <DropdownToggle caret>
                                { this.state.selectedCar.length ? this.state.selectedCar : "Select a vehicle" }
                            </DropdownToggle>
                            <DropdownMenu>
                                {carNames.map(([carName, key]) =>
                                    <DropdownItem onClick={ this.selectCar.bind(this) }>{ carName }</DropdownItem>
                                )}
                            </DropdownMenu>
                        </ButtonDropdown>
                    </Col>
                    <Col>
                        Start Date {' '}
                        <DatePicker selected={this.state.startDate} onChange={this.startDateChanged.bind(this)} />
                    </Col>
                    <Col>
                        End Date {' '}
                        <DatePicker selected={this.state.endDate} onChange={this.endDateChanged.bind(this)} />
                    </Col>
                </Row>
                { carToShow.length ? carToShow : ""}
            </Container>
        )
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>Welcome, <strong>{ this.props.username }</strong>! Here, you can view your charge sessions per car.</Col>
                </Row>
                { this.getCars() }
            </Container>
        )
    }
}

const mapStateToProps = state => {
    return {
        token: state.user.token,
        username: state.user.username,
        cars: state.driver.cars
    };
};

export default connect(mapStateToProps)(Driver);
