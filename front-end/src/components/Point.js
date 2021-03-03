import React from "react"
import { connect } from "react-redux"

import { retrieve_points_charges } from "../redux/async";

class Point extends React.Component {
    constructor(props) {
        super(props)
        this.state = {isOpen: false};
    }

    componentDidMount() {
        const retrieve_points_charges_thunk = retrieve_points_charges(this.props.token,
            this.props.station, this.props.point, this.props.startDate, this.props.endDate);
        this.props.dispatch(retrieve_points_charges_thunk);
    }

    pointCharges() {
        const charges = [];
        // To view available items uncomment below
        // console.log(this.props.point.charges)
        Object.keys(this.props.point.charges).map(function(key) {
            let ch = this.props.point.charges[key];
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
                <p onClick={ this.handleOpen.bind(this) }>Point { this.props.cnt }</p>
                { this.state.isOpen ? this.pointCharges() : "" }
            </div>
        )
    }
}


const mapStateToProps = state => {
    return {
        token: state.user.token,
        username: state.user.username,
        stations: state.operator.stations
    };
};

export default connect(mapStateToProps)(Point);
