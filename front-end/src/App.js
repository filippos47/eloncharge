import React from 'react'
import { Provider } from 'react-redux'

import Header from './partials/Header'
import Main from './partials/Main'
import store from './redux/store'

export default function App() {
    return (
        <Provider store={ store }>
            <Header />
            <div className="main">
                <Main />
            </div>
        </Provider>
    );
}
