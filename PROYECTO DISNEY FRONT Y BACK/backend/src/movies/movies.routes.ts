import { Router } from "express";
import type { Db } from "../db.js";

export function createMovieRouter(db: Db) {
    const r = Router();

    // GET /api/movies?category=slug
    r.get("/", (req, res) => {
        const categorySlug = req.query.category as string;
        const searchTerm = req.query.search as string;

        let sql = "SELECT m.Titulo as movie, m.posterURL as imagen_url, m.AnyoEstreno as year FROM MOVIES m";
        let params: any[] = [];
        let conditions: string[] = [];

        if (categorySlug) {
            sql += " JOIN CATEGORIAS c ON m.idCategoria = c.idCategoria";
            conditions.push("c.slug = ?");
            params.push(categorySlug);
        }

        if (searchTerm) {
            conditions.push("m.Titulo LIKE ?");
            params.push(`%${searchTerm}%`);
        }

        if (conditions.length > 0) {
            sql += " WHERE " + conditions.join(" AND ");
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