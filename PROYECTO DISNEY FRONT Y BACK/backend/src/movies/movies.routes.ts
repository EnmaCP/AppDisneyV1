import { Router } from "express";
import type { Db } from "../db.js";

export function createMovieRouter(db: Db) {
    const r = Router();

    // GET /api/movies?category=slug
    r.get("/", (req, res) => {
        const categorySlug = req.query.category as string;
        let sql = "SELECT Titulo as movie, posterURL as imagen_url, AnyoEstreno as year FROM MOVIES";
        let params: any[] = [];

        if (categorySlug) {
            sql = `
                SELECT m.Titulo as movie, m.posterURL as imagen_url, m.AnyoEstreno as year 
                FROM MOVIES m 
                JOIN CATEGORIAS c ON m.idCategoria = c.idCategoria 
                WHERE c.slug = ?
            `;
            params.push(categorySlug);
        }

        db.all(sql, params, (err, rows) => {
            if (err) {
                console.error("[db_error]", err);
                res.status(500).json({ ok: false, error: "database_error", details: err.message });
                return;
            }
            res.json({ ok: true, movies: rows });
        });
    });

    return r;
}
/*
// pseudocódigo interno de sqlite3
function all(sql, params, callback) {
ejecutarSQL(sql, params, (error, result) => {
callback(error, result);
});
}

*/