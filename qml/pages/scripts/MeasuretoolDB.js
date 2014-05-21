.pragma library
.import QtQuick.LocalStorage 2.0 as Sql

var db;

function openDB() {
    db = Sql.LocalStorage.openDatabaseSync("MeasuretoolDB","1.0","Measuretool Database",1e5);
    createTable();
}

function createTable() {
    db.transaction( function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS\
           Preferences (phoneheight TEXT)");
    });
    db.transaction( function(tx) {
        tx.executeSql("CREATE TABLE IF NOT EXISTS\
           Images (path TEXT,\
           distance TEXT NOT NULL,\
           height TEXT NOT NULL)");
    });
}

function setHeight(value) {
    db.transaction( function(tx) {
        tx.executeSql("INSERT INTO Preferences (phoneheight) VALUES(?)",
           [value]
        );
    });
}

function updateHeight(value) {
    db.transaction( function(tx) {
       tx.executeSql("\
          UPDATE Preferences SET phoneheight=?",[value]);
    });
}

function getHeight() {
    var value = 0;
    try {
        db.readTransaction( function(tx) {
           var rs = tx.executeSql("SELECT phoneheight FROM Preferences");
            value = rs.rows.item(0).phoneheight;
        });
    } catch(err) {
        console.log("An error occured.\n" +
                    "Error description: " + err.message + "\n");
        return undefined
    }
    return value;
}

function addImage(path, dist, height) {
    db.transaction( function(tx) {
        tx.executeSql("INSERT INTO Images (path, distance, height) VALUES(?,?,?)",
           [path,dist,height]
        );
    });
}

function removeImage(path) {
    db.transaction( function(tx) {
        tx.executeSql("DELETE FROM Images WHERE path=?",[path]);
    });
}


function getImages() {
    var data = [];
    db.readTransaction( function(tx) {
       var rs = tx.executeSql("SELECT path, distance, height FROM Images");
       var i = 0, count = rs.rows.length;
       for (; i < count; i++) {
           data[i] = rs.rows.item(i);
        }
    });
    return data;
}

