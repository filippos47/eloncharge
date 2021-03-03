import { AUTHENTICATE, DEL_USER } from "../actionTypes";

const initialState = {
    username: localStorage.getItem('username') || '',
    token: localStorage.getItem('token') || '',
    loginStatus: ''
};


function user(state = initialState, action) {
    switch (action.type) {
        case AUTHENTICATE: {
            const { username, token } = action.payload;

            if (token != null) {
                localStorage.setItem('username', username);
                localStorage.setItem('token', token);
                return {
                    ...state,
                    username: username,
                    token: token,
                    loginStatus: 'ok'
                };
            }
            else {
                return {
                    ...state,
                    loginStatus: 'fail'
                };
            }
        }
        case DEL_USER: {
            localStorage.setItem('username', '');
            localStorage.setItem('token', '');
            return {
                ...state,
                username: '',
                token: ''
            };
        }
        default:
            return state;
    }
}

export default user
