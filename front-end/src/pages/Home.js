import React from 'react';
import { connect } from "react-redux";

import { Form, FormGroup, Alert, Label, Input, Button } from 'reactstrap'

import { authenticate } from "../redux/async";

class Home extends React.Component {
    constructor(props) {
        super(props);
        this.state = {username: '', password: ''};
    }

    componentDidMount() {
        if (this.props.token !== '') {
            this.props.history.push('/driver');
        }
    }

    componentDidUpdate() {
        if (this.props.token !== '') {
            this.props.history.push('/driver');
        }
    }

    handleUpdate(e) {
        this.setState({[e.target.name]: e.target.value});
    }

    handleSubmit = async (e) => {
        e.preventDefault()

        const authenticateThunk = authenticate(this.state.username, this.state.password);
        this.props.dispatch(authenticateThunk);
    }

    getState() {
        let msg, color;
        if (this.props.loginStatus === 'ok') {
            msg = "You should be redirected momentarily"
            color = "success"
        }
        else if (this.props.loginStatus === 'fail') {
            msg = "Wrong username or password!"
            color = "danger"
        }
        else {
            msg = ""
        }
        return ( msg.length ? <Alert color={color}>{msg}</Alert> : "");
    }

    render() {
        console.log(process.env.REACT_APP_API_URL);
        return (
            <Form className="login-form" onSubmit={ this.handleSubmit.bind(this) }>
                <FormGroup>
                        <Label htmlFor="username">Username</Label>
                        <Input name="username" placeholder="Username" id="username" type="text" required
                            value={this.state.username} onChange={this.handleUpdate.bind(this)}></Input>
                </FormGroup>
                <FormGroup>
                        <Label htmlFor="password">Password</Label>
                    <Input name="password" placeholder="Password" id="password" type="password" required
                        value={this.state.password} onChange={this.handleUpdate.bind(this)}></Input>
                </FormGroup>
                <Button color="primary"> Login </Button>
                {this.getState()}
            </Form>
        )
    }
}

const mapStateToProps = state => {
    return {
        token: state.user.token,
        username: state.user.username,
        loginStatus: state.user.loginStatus
    };
};

export default connect(mapStateToProps)(Home);
