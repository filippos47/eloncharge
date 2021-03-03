import Api from "../utils/Api";
import {
    AUTHENTICATE, RETRIEVE_CARS, RETRIEVE_CAR_CHARGES,
    RETRIEVE_STATIONS, RETRIEVE_POINTS_CHARGES } from "./actionTypes";

export function authenticate(username, password) {
    return async function authenticateThunk(dispatch, getState) {
        let token;
        try {
            const res = await Api().post('/evcharge/api/login', {username, password});
            token = res.data.token
        } catch (err) {
            token = null;
        }

        dispatch({ type: AUTHENTICATE, payload: { username, token }});
    }
}

export function retrieve_cars(token) {
    return async function retrieveCarsThunk(dispatch, getState) {
        let cars;
        try {
            const res = await Api({ token }).get('/evcharge/api/ev', {});
            cars = res.data;
        } catch (err) {
            cars = [];
        }

        dispatch({ type: RETRIEVE_CARS, payload: { cars }});
    }
}

function formatDate(day, end=false) {
    let d = day.getFullYear() + "-" + (day.getMonth()+1) + "-" + day.getDate();
    if (end) {
        d = d + " 23:59:59";
    }
    else {
        d = d + " 00:00:00";
    }
    return d;
}

export function retrieve_car_charges(token, car, start, end) {
    return async function retrieveCarChargesThunk(dispatch, getState) {
        let charges;
        const url = "/evcharge/api/SessionsPerEV/" + car.id + "/" + formatDate(start) + "/" + formatDate(end);

        try {
            const res = await Api({ token }).get(url, {});
            charges = res.data["VehicleChargingSessionsList"];
        } catch (err) {
            charges = {};
        }

        dispatch({ type: RETRIEVE_CAR_CHARGES, payload: { car_id: car.id, charges }});
    }
}

export function retrieve_stations(token) {
    return async function retrieveStationsThunk(dispatch, getState) {
        let stations;
        try {
            const res = await Api({ token }).get('/evcharge/api/station', {});
            stations = res.data;
        } catch (err) {
            stations = [];
        }

        console.log(stations)
        dispatch({ type: RETRIEVE_STATIONS, payload: { stations }});
    }
}

export function retrieve_points_charges(token, station, point, start, end) {
    return async function retrieveCarChargesThunk(dispatch, getState) {
        let charges;
        console.log(formatDate(start))
        console.log(formatDate(end))
        const url = "/evcharge/api/SessionsPerPoint/" + point.id + "/" + formatDate(start) + "/" + formatDate(end, true);

        try {
            const res = await Api({ token }).get(url, {});
            charges = res.data["ChargingSessionsList"];
        } catch (err) {
            charges = {};
        }

        dispatch({ type: RETRIEVE_POINTS_CHARGES, payload: { point_id: point.id, station_id: station.id, charges }});
    }
}
