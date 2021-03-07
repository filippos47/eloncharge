import React from "react"
import { connect } from "react-redux"

import Point from "./Point"

class Station extends React.Component {
    constructor(props) {
        super(props)
        this.state = {isOpen: false};
    }

    getPoints() {
        const points = [];

        console.log(this.props.startDate)
        Object.keys(this.props.station.points).map(function(key) {
            points.push(<Point
                key={`point-${key}`}
                cnt={key}
                station={ this.props.station }
                startDate={ this.props.startDate }
                endDate={ this.props.endDate }
                point={ this.props.station.points[key] } />)
        }.bind(this));

        return (
            <div>
                { points ? points : "No points found"}
            </div>
        )
    }

    handleOpen(e) {
        this.setState({isOpen: !this.state.isOpen});
    }

    render() {
        return (
            <div>
                { this.getPoints() }
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

export default connect(mapStateToProps)(Station);
