import React from 'react'
import { connect } from "react-redux"
import DatePicker from "react-datepicker"
import "react-datepicker/dist/react-datepicker.css";

import { retrieve_cars } from "../redux/async";
import Car from "../components/Car"

class Driver extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            startDate: new Date("2020-03-01"),
            endDate: new Date()
        };
    }

    componentDidMount() {
        if (this.props.token === '') {
            this.props.history.push("/")
        }

        const retrieve_cars_thunk = retrieve_cars(this.props.token);
        this.props.dispatch(retrieve_cars_thunk);
    }

    getCars() {
        const cars = [];
        Object.keys(this.props.cars).map(function(key) {
            cars.push(<Car
                key={`car-${key}`}
                car={ this.props.cars[key] }
                startDate={ this.state.startDate }
                endDate={ this.state.endDate } />)
        }.bind(this));

        return (
            <div>
                <ul>
                    { cars.length ? cars : "No cars found"}
                </ul>
            </div>
        )
    }

    render() {
        return (
            <div>
                <p>Cars</p>
                { this.getCars() }
            </div>
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
