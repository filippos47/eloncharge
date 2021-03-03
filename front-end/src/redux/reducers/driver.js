import { RETRIEVE_CARS, RETRIEVE_CAR_CHARGES } from "../actionTypes";

const initialState = {
    cars: {},
};

function driver(state=initialState, action) {
    switch (action.type) {
        case RETRIEVE_CARS: {
            const { cars } = action.payload;
            const byIds = {}

            Object.keys(cars).map(function(key) {
                if (cars[key].id) {
                    byIds[cars[key].id] = {
                        ...cars[key],
                        charges: {}
                    }
                }
            });

            return {
                ...state,
                cars: byIds,
            };
        }
        case RETRIEVE_CAR_CHARGES: {
            const { car_id, charges } = action.payload;

            if (!car_id) {
                return state;
            }

            return {
                ...state,
                cars: {
                    ...state.cars,
                    [car_id]: {
                        ...state.cars[car_id],
                        charges: charges
                    }
                }
            };
        }
        default:
            return state;
    }
}

export default driver
