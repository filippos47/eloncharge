import axios from 'axios'
import qs from 'qs'

const instance = axios.create({
    baseURL: process.env.REACT_APP_API_URL,
    headers: {
        common: {
            'Content-Type': 'application/json'
        }
    }
});

const paramsSerializer = (params) => qs.stringify(params, {indices: false});

function getHeaders(token) {
    return {'X-AUTH-OBSERVATORY': token}
}

function Api(args={}) {
    const { token } = args
    const config = token ? {headers: getHeaders(token)} : {}

    return {
        get: (url, params) => instance.get(url, {params, paramsSerializer, ...config }),
        post: (url, data) => instance.post(url, qs.stringify(data, { indices: false }), config),
    };
}

export default Api
