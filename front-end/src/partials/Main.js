import React from 'react'
import { Route, Switch } from 'react-router-dom'
import { Container } from 'reactstrap'

import Home from '../pages/Home'
import Driver from '../pages/Driver'
import Operator from '../pages/Operator'

class Main extends React.Component {
    render() {
        return (
            <Container>
                <Switch>
                    <Route exact path='/' component={ Home } />
                    <Route exact path='/driver' component={ Driver } />
                    <Route exact path='/operator' component={ Operator } />
                </Switch>
            </Container>
        )
    }
}

export default Main
