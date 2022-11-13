import {config} from "firebase-functions";
import {initializeApp} from "firebase-admin/app";

initializeApp(config().firebase);

export * from "./handlers";
