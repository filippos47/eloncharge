import { AUTHENTICATE, DEL_USER } from "./actionTypes";

export const authenticate = (username, password) => ({
    type: AUTHENTICATE,
    payload: { username, password }
});

export const del_user = () => ({
    type: DEL_USER,
    payload: {}
});
