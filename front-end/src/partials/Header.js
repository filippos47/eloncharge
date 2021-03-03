import React from 'react'
import { connect } from "react-redux"
import { Navbar, NavItem, NavLink, Nav } from 'reactstrap'

import { del_user } from "../redux/actions"

class Header extends React.Component {
    handleLogout(e) {
        this.props.del_user()
    }

    getNavBar() {
        if (this.props.token === '') {
            return (<div></div>);
        }
        return (
            <Navbar color="light">
                <Nav className="ml-auto" navbar>
                    <NavItem>
                        <NavLink href="/driver">Driver</NavLink>
                    </NavItem>
                    <NavItem>
                        <NavLink href="/operator">Operator</NavLink>
                    </NavItem>
                    <NavItem onClick={ this.handleLogout.bind(this) }>
                        <NavLink href="/">Logout</NavLink>
                    </NavItem>
                </Nav>
            </Navbar>
        )
    }

    render() {
        return this.getNavBar();
    }
}

const mapStateToProps = state => {
    return {
        token: state.user.token,
        username: state.user.username
    };
};

export default connect(mapStateToProps, { del_user } )(Header);
