import sqlite3 from 'sqlite3';
const db = new sqlite3.Database('data/disney.sqlite');

db.all("SELECT * FROM CATEGORIAS", [], (err, rows) => {
    if (err) {
        console.error("Error:", err);
        return;
    }
    console.log("Categories:", rows);
});
