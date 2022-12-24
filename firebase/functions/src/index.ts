import { initializeApp } from "firebase-admin/app";
import { config } from "firebase-functions";

initializeApp(config().firebase);

export * from "./handlers";
