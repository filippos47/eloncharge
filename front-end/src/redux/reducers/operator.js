import { RETRIEVE_STATIONS, RETRIEVE_POINTS, RETRIEVE_POINTS_CHARGES } from "../actionTypes";

const initialState = {
    stations: {},
};

function operator(state=initialState, action) {
    switch (action.type) {
        case RETRIEVE_STATIONS: {
            const { stations } = action.payload;
            const byIds = {}

            Object.keys(stations).map(function(key) {
                if (stations[key].id) {
                    byIds[stations[key].id] = stations[key]
                }
            });

            return {
                ...state,
                stations: byIds,
            };
        }
        case RETRIEVE_POINTS_CHARGES: {
            const { station_id, point_id, charges } = action.payload;

            if (!station_id || !point_id) {
                return state;
            }

            console.log("CHARGES", charges)
            return {
                ...state,
                stations: {
                    ...state.stations,
                    [station_id]: {
                        ...state.stations[station_id],
                        points: {
                            ...state.stations[station_id].points,
                            [point_id]: {
                                ...state.stations[station_id].points[point_id],
                                charges: charges
                            }
                        }
                    }
                }
            };
        }
        default:
            return state;
    }
}

export default operator
