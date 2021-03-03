import { combineReducers } from "redux"
import user from "./user";
import driver from "./driver";
import operator from "./operator";

export default combineReducers({ user, driver, operator });
