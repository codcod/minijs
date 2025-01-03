const os = require('os')
const express = require('express')
const bodyParser = require('body-parser')

const app = express()
const port = 3000

const db = require('./queries')

app.use(bodyParser.json())
app.use(
    bodyParser.urlencoded({
        extended: true,
    })
)

app.get('/', (request, response) => {
    response.json({
        date: (new Date()).toString(),
        error: false,
        hostname_os: os.hostname(),
        hostname_req: request.hostname,
        ip: request.ip,
        remote_address_conn: request.connection.remoteAddress,
        remote_address_socket: request.socket.remoteAddress,
        username: request.body.username || 'none',
        x_forwarded_for: request.headers['x-forwarded-for'] || 'none',
        process_env: process.env
    })
})

app.get('/users', db.getUsers)
app.get('/users/:id', db.getUserById)
app.post('/users', db.createUser)
app.put('/users/:id', db.updateUser)
app.delete('/users/:id', db.deleteUser)

app.listen(port, () => {
    console.log(`App running on port ${port}.`)
})
