import { initializeApp } from "firebase-admin/app";
import { config } from "firebase-functions";

process.env.TZ = "Asia/Tokyo";
initializeApp(config().firebase);

export * from "./handlers";
