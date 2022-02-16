const http = require('http');
const os = require('os');
const _ = require('lodash');

const requestListener = (req, res) => {
    const welcome = 'Hello from Node.js!';
    const { MESSAGE, VERSION } = process.env;
    const hostname = os.hostname()

    const data = {
        Welcome: welcome,
        Message: MESSAGE,
        Version: VERSION,
        Hostname: hostname
    };

    res.write(JSON.stringify(data));
    res.end();
}

const server = http.createServer();
server.on('request', requestListener);
const port = 8080;

server.listen(port, () => {
  console.log(_.capitalize('server listening on port'), port);
});
