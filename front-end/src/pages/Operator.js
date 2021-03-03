import React from 'react'
import { connect } from "react-redux"

import { retrieve_stations } from "../redux/async";
import Station from "../components/Station";

class Operator extends React.Component {
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

        const retrieve_stations_thunk = retrieve_stations(this.props.token);
        this.props.dispatch(retrieve_stations_thunk);
    }

    getStations() {
        const sts = [];

        Object.keys(this.props.stations).map(function(key) {
            sts.push(<Station
                key={`station-${key}`}
                station={ this.props.stations[key] }
                startDate={ this.state.startDate }
                endDate={ this.state.endDate } />)
        }.bind(this));

        return (
            <div>
                <ul>
                    { sts ? sts : "No stations found"}
                </ul>
            </div>
        )
    }

    render() {
        return (
            <div>
                <p>Stations</p>
                { this.getStations() }
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

export default connect(mapStateToProps)(Operator);
