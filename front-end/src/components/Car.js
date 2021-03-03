import React from "react"
import { connect } from "react-redux"

import { retrieve_car_charges } from "../redux/async";

class Car extends React.Component {
    constructor(props) {
        super(props)
        this.state = {isOpen: false};
    }

    componentDidMount() {
        const retrieve_car_charges_thunk = retrieve_car_charges(this.props.token, this.props.car, this.props.startDate, this.props.endDate);
        this.props.dispatch(retrieve_car_charges_thunk);
    }

    carCharges() {
        console.log(this.props.car.charges);
        const charges = [];
        // To view available items uncomment below
        // console.log(this.props.car.charges)
        Object.keys(this.props.car.charges).map(function(key) {
            let ch = this.props.car.charges[key];
            charges.push((
                <p key={ ch.SessionID }>
                    Date: {ch.StartedOn},
                    Price: {ch.SessionCost},
                    Energy Delivered: {ch.EnergyDelivered}
                </p>
            ))
        }.bind(this));
        return (
            <div>
                { charges.length ? charges : "No charges found" }
            </div>
        )
    }

    handleOpen(e) {
        this.setState({isOpen: !this.state.isOpen});
    }

    render() {
        return (
            <div>
                <p onClick={ this.handleOpen.bind(this) }>Car { this.props.car.name }</p>
                { this.state.isOpen ? this.carCharges() : "" }
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

export default connect(mapStateToProps)(Car);
