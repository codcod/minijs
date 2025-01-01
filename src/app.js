import express from "express";
import os from "os";

const app = express();
const hostname = "0.0.0.0";
const port = 3000;

// This middleware will parse the incoming request body
// and populates req.body with the parsed object.
app.use(express.json());

app.get("/", (req, res) => {
    res.json({
        date: (new Date()).toString(),
        error: false,
        hostname_os: os.hostname(),
        hostname_req: req.hostname,
        ip: req.ip,
        remote_address_conn: req.connection.remoteAddress,
        remote_address_socket: req.socket.remoteAddress,
        username: req.body.username || "none",
        x_forwarded_for: req.headers['x-forwarded-for'] || "none",
        process_env: process.env
    });
});

app.listen(port, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});
