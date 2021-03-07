import React from "react"
import { connect } from "react-redux"
import { Table } from "reactstrap"

import { retrieve_car_charges } from "../redux/async";

class Car extends React.Component {

    componentDidMount() {
        const retrieve_car_charges_thunk = retrieve_car_charges(this.props.token, this.props.car, this.props.startDate, this.props.endDate);
        this.props.dispatch(retrieve_car_charges_thunk);
    }
    componentDidUpdate() {
        const retrieve_car_charges_thunk = retrieve_car_charges(this.props.token, this.props.car, this.props.startDate, this.props.endDate);
        this.props.dispatch(retrieve_car_charges_thunk);
    }

    carCharges() {
        const charges = [];

        Object.keys(this.props.car.charges).map(function(key) {
            let ch = this.props.car.charges[key];
            charges.push((
                <tr className="d-flex">
                    <th className="col-4">{ch.StartedOn}</th>
                    <th className="col-4">{ch.SessionCost}</th>
                    <th className="col-4">{ch.EnergyDelivered}</th>
                </tr>
            ))
        }.bind(this));
        return (
            <div>
                { charges.length > 0 ? (
                    <Table className="table-bordered table-dark text-center table-hover">
                        <thead>
                            <tr className="d-flex bg-info">
                                <th className="col-4">Date</th>
                                <th className="col-4">Price (EUR)</th>
                                <th className="col-4">Energy Delivered (kW)</th>
                            </tr>
                        </thead>
                        <tbody>
                            {charges}
                        </tbody>
                    </Table>
                ) : "No charges found" }
            </div>
        )
    }

    render() {
        return (
            <div>
                { this.carCharges() }
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
