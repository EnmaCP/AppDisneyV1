import sqlite3 from 'sqlite3';
const db = new sqlite3.Database('data/disney.sqlite');

console.log("Inspecting database...");

db.all("SELECT name FROM sqlite_master WHERE type='table'", [], (err, tables) => {
    if (err) {
        console.error("Error reading tables:", err);
        return;
    }
    console.log("Tables found:", tables);

    tables.forEach(t => {
        db.all(`PRAGMA table_info(${t.name})`, [], (err, cols) => {
            if (err) console.error(`Error reading columns for ${t.name}:`, err);
            else console.log(`Columns for table '${t.name}':`, cols.map(c => c.name));
        });
    });
});
