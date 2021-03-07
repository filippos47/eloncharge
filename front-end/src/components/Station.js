import React from "react"
import { connect } from "react-redux"

import Point from "./Point"
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet'

// cheat for react-leaflet's Marker to worl
// https://github.com/PaulLeCam/react-leaflet/issues/453
import L from 'leaflet'
import icon from 'leaflet/dist/images/marker-icon.png'
import iconShadow from 'leaflet/dist/images/marker-shadow.png'
let DefaultIcon = L.icon({
    iconUrl: icon,
    shadowUrl: iconShadow
})
L.Marker.prototype.options.icon = DefaultIcon;

class Station extends React.Component {
    constructor(props) {
        super(props)
        this.state = {isOpen: false};
    }

    getPoints() {
        const points = [];

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
        const station = this.props.station
        const position = [station.latitude, station.longtitude]
        const stationFullname = station.address + " " + station.number + ", " + station.city
        return (
            <div>
                { this.getPoints() }
                <MapContainer style={{ height:"30vh" }} center={position} zoom={13} scrollWheelZoom={true}>
                    <TileLayer
                        attribution='&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
                        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
                    />
                    <Marker position={position}>
                        <Popup>
                            { stationFullname }
                        </Popup>
                    </Marker>
                </MapContainer>
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
