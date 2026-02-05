import express from "express";
import cors from "cors";
import type { Db } from "./db.js";
import { createMovieRouter } from "./movies/movies.routes.js";

export function createApp(db: Db) {
    const app = express();

    app.use(cors());
    app.use(express.json());

    // Debug logging
    app.use((req, _res, next) => {
        console.log(`[request] ${req.method} ${req.path}`);
        next();
    });

    app.get("/", (_req, res) => {
        res.send("API is running!");
    });

    app.get("/health", (_req, res) => {
        res.json({ ok: true, world: "Disney" });
    });

    app.use("/api/movies", createMovieRouter(db));

    return app;
}