import React from "react"
import { connect } from "react-redux"

import { retrieve_points_charges } from "../redux/async"
import { Button, Container, Row, Col, Table } from 'reactstrap'

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

    handleOpen(e) {
        this.setState({isOpen: !this.state.isOpen});
    }

    render() {
        return (
            <Container>
                <Row>
                    <Col>
                    <Button className="above-table btn-info" onClick={ this.handleOpen.bind(this) }>
                        Point No.{ this.props.cnt }
                    </Button>
                    </Col>
                </Row>
                { this.state.isOpen ? this.pointCharges() : "" }
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

export default connect(mapStateToProps)(Point);
