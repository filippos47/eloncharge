import React from 'react'
import { connect } from "react-redux"

import { retrieve_stations } from "../redux/async";
import Station from "../components/Station";
import { Container, Row, Col, ButtonDropdown, DropdownToggle, DropdownMenu, DropdownItem } from 'reactstrap';

class Operator extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            startDate: new Date("2021-01-01"),
            endDate: new Date(),
            dropdownOpen: false,
            selectedStation: ""
        };
    }

    componentDidMount() {
        if (this.props.token === '') {
            this.props.history.push("/")
        }

        const retrieve_stations_thunk = retrieve_stations(this.props.token);
        this.props.dispatch(retrieve_stations_thunk);
    }

    toggle() {
        this.setState({ dropdownOpen: !this.state.dropdownOpen });
    }

    selectStation(e) {
        console.log(this.state.selectedStation)
        this.setState({ selectedStation: e.currentTarget.textContent  })
    }

    getStations() {
        const stationToShow = [], stationNames = [];

        Object.keys(this.props.stations).map(function(key) {
            let station = this.props.stations[key]
            let stationFullname = station.address + " " + station.number +
                ", " + station.city
            stationNames.push( [stationFullname, key] )
        }.bind(this));

        Object.keys(stationNames).map(function(key) {
            let stationName=stationNames[key][0], stationKey = stationNames[key][1]
            if (stationName === this.state.selectedStation) {
                stationToShow.push(<Station
                    key={`car-${stationKey}`}
                    station={ this.props.stations[stationKey] }
                    startDate={ this.state.startDate }
                    endDate={ this.state.endDate } />)
            }
        }.bind(this));

        return (
            <Container>
                <Row>
                    <Col>
                        <ButtonDropdown isOpen={ this.state.dropdownOpen } toggle={ this.toggle.bind(this) }>
                            <DropdownToggle caret>
                                { this.state.selectedStation.length ? this.state.selectedStation : "Select a station" }
                            </DropdownToggle>
                            <DropdownMenu>
                                {stationNames.map(([stationName, key]) =>
                                    <DropdownItem onClick={ this.selectStation.bind(this) }>{ stationName }</DropdownItem>
                                )}
                            </DropdownMenu>
                        </ButtonDropdown>
                    </Col>
                </Row>
                { stationToShow.length ? stationToShow : ""}
            </Container>
        )
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>Welcome, <strong>{ this.props.username }</strong>! Here, you can view your     charge sessions for every point per station.</Col>
                </Row>
                { this.getStations() }
            </Container>
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
