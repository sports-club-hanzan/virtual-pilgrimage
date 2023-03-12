import * as admin from "firebase-admin";
import { GeoPoint } from "@google-cloud/firestore";
import * as fs from "fs";
import * as readline from "readline";

interface TempleData {
  address: string;
  distance: number;
  geoPoint: GeoPoint;
  id: number;
  images: string[];
  stampImage: string;
  name: string;
  prefecture: string;
  encodedPoints: string;
  knowledge: string;
}

async function main(keyPath: string, dataPath: string, env: string): Promise<void> {
  const serviceAccount = require(keyPath);
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
  });

  const db = admin.firestore();

  const templeData: TempleData[] = [];

  const rl = readline.createInterface({
    input: fs.createReadStream(dataPath),
    crlfDelay: Infinity
  });

  rl.on("line", (line: string) => {
    const data = line.split(",");
    const temple: TempleData = {
      address: data[1],
      distance: parseInt(data[5]),
      geoPoint: new GeoPoint(
        parseFloat(data[3]),
        parseFloat(data[4])
      ),
      id: parseInt(data[0]),
      images: [makeImagePath(parseInt(data[0]), env)],
      stampImage: makeStampImagePath(parseInt(data[0]), env),
      name: data[2],
      prefecture: data[1].slice(0, 3),
      encodedPoints: data[8],
      knowledge: data[9],
    };
    templeData.push(temple);
  });

  rl.on("close", async () => {
    console.log("Finished reading data from CSV");

    for (const temple of templeData) {
      const docRef = db.collection("temples").doc(`${temple.id}`);
      await docRef.set(temple);
      console.log(`Added temple ${temple.id} to Firestore`);
    }
  });
}

function makeImagePath(id: number, env: string): string {
  return `https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-${env}.appspot.com/o/temples%2F${id}%2F1.jpg?alt=media`;
}

function makeStampImagePath(id: number, env: string): string {
  return `https://firebasestorage.googleapis.com/v0/b/virtual-pilgrimage-${env}.appspot.com/o/temples%2F${id}%2Fstamp.jpg?alt=media`;
}

const keyPath = process.argv[2];
const dataPath = process.argv[3];
const env = process.argv[4] || "dev";
main(keyPath, dataPath, env);
