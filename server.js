const http = require('http');
const fs = require('fs');
const path = require('path');

const PORT = 5500;

const routes = {
  '/': 'index.html',
  '/quadruped': 'quadruped.html',
  '/rouv': 'rouv.html',
  '/photogrammetry': 'photogrammetry.html',
  '/amr': 'amr.html',
};

const mime = {
  '.html': 'text/html',
  '.css': 'text/css',
  '.js': 'application/javascript',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.svg': 'image/svg+xml',
  '.pdf': 'application/pdf',
};

const server = http.createServer((req, res) => {
  const urlPath = req.url.split('?')[0];

  // Serve route HTML files
  if (routes[urlPath]) {
    const filePath = path.join(__dirname, routes[urlPath]);
    fs.readFile(filePath, (err, data) => {
      if (err) { res.writeHead(404); return res.end('Not found'); }
      res.writeHead(200, { 'Content-Type': 'text/html' });
      res.end(data);
    });
    return;
  }

  // Serve static assets
  const filePath = path.join(__dirname, decodeURIComponent(urlPath));
  const ext = path.extname(filePath);
  fs.readFile(filePath, (err, data) => {
    if (err) { res.writeHead(404); return res.end('Not found'); }
    res.writeHead(200, { 'Content-Type': mime[ext] || 'application/octet-stream' });
    res.end(data);
  });
});

server.listen(PORT, () => {
  console.log(`Server running at http://localhost:${PORT}`);
  console.log(`  /                → index.html`);
  console.log(`  /quadruped       → quadruped.html`);
  console.log(`  /rouv            → rouv.html`);
  console.log(`  /photogrammetry  → photogrammetry.html`);
  console.log(`  /amr             → amr.html`);
});
