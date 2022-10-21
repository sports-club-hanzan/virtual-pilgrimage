#!/usr/bin/env node

const { parse } = require('csv-parse/sync');
const fs = require('fs');
const axios = require('axios');
const stringifySync = require("csv-stringify/sync");

const key = process.env.API_KEY

async function main() {
    var prev = ""
    var csv = []

    const records = parse(fs.readFileSync('temples/temple_info_update.csv'), { columns: true });
    for (const data of records) {
        if (prev === "") {
            prev = data['緯度(北緯)'] + "," + data['経度(東経)']
            csv.push(data)
            continue;
        }

        next = data['緯度(北緯)'] + "," + data['経度(東経)']

        await axios.get('https://maps.googleapis.com/maps/api/directions/json?=&mode=walking&avoidHighways=false&avoidFerries=false&avoidTolls=false' +
            '&key=' + key +
            '&origin=' + prev +
            '&destination=' + next
        )
            .then(response => {
                var points = response['data']['routes'][0]['overview_polyline']['points'];
                csv[csv.length - 1]["経路情報（エンコード）"] = points
                return response
            }).catch(err => {
                console.log(err);
            });

        csv.push(data)
        prev = next
    }
    const csvString = stringifySync.stringify(csv, {
        header: true
    });
    fs.writeFileSync('temples/temple_info_update.csv', csvString);
}

main()
