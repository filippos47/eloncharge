import React from 'react'
import ReactDOM from 'react-dom'
import { BrowserRouter } from 'react-router-dom'
import 'bootstrap/scss/bootstrap.scss';
import 'leaflet/dist/leaflet.css'
import './styles/index.scss'
import App from './App'

ReactDOM.render((
    <BrowserRouter>
        <App />
    </BrowserRouter>
), document.getElementById('root'));
