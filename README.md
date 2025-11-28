

<div align="center">
  
For a more advanced and modern setup consider **[lklacar/q3js](https://github.com/lklacar/q3js)** - it's a modern and feature-rich implementation.

**For simplicity:** This project provides a **single-container solution** that's perfect for smaller setups.

---
  
# QuakeJS Rootless Project

## Play multiplayer Quake III Arena in your browser with Podman / Docker

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-awakenedpower%2Fquakejs--rootless-blue?style=for-the-badge&logo=docker)](https://hub.docker.com/r/awakenedpower/quakejs-rootless)

A fully self-contained, Dockerized QuakeJS server running on Debian 13 and Node.js 22.x LTS

## Demo

Try it live: **[gibs.oldschoolfrag.com](https://gibs.oldschoolfrag.com/)**

</div>

## About

This project provides a completely local QuakeJS server that runs entirely in Docker. No external dependencies, no content servers, no proxies - just pure Quake III Arena gaming in your browser.

**Key improvements in this fork:**
- Updated to **Debian 13 Slim** base image
- Upgraded to **Node.js 22.x LTS** for better performance and security
- Forked Quake3JS Core to remove CRITICAL and HIGH NPM package vulnerabilities ([quakejs](https://github.com/JackBrenn/quakejs))
- Nginx-light web server
- Runs as non-root user (quakejs)
- Fully self-contained with all game assets bundled, no external content servers required

## Quick Start

### Using Podman (Recommended)

```bash
podman run -d \
  --name quakejs \
  -e HTTP_PORT=8080 \
  -p 8080:8080 \
  -p 27960:27960 \
  docker.io/awakenedpower/quakejs-rootless:latest
```

### Using Docker Run

```bash
docker run -d \
  --name quakejs \
  -e HTTP_PORT=8080 \
  -p 8080:8080 \
  -p 27960:27960 \
  docker.io/awakenedpower/quakejs-rootless:latest
```

Then open your browser and navigate to `http://localhost:8080` to start playing!

### Using Docker Compose

Create a `docker-compose.yml` file:

```yaml
version: '3.8'
services:
  quakejs:
    container_name: quakejs
    image: awakenedpower/quakejs-rootless:latest
    environment:
      - HTTP_PORT=8080
    ports:
      - '8080:8080'
      - '27960:27960'
    restart: unless-stopped
```

Then run:

```bash
docker-compose up -d
```

## Building from Source

### Building with Podman (Recommended)

1. **Clone the repository:**
```bash
git clone https://github.com/JackBrenn/quakejs-rootless.git
cd quakejs-rootless
```

2. **Build the image:**
```bash
podman build -t quakejs-rootless:latest .
```

3. **Run the container:**
```bash
podman run -d \
  --name quakejs \
  -e HTTP_PORT=8080 \
  -p 8080:8080 \
  -p 27960:27960 \
  quakejs-rootless:latest
```

### Building with Docker

1. **Clone the repository:**
```bash
git clone https://github.com/JackBrenn/quakejs-rootless.git
cd quakejs-rootless
```
2. **Build the image:**
```bash
docker build -t quakejs-rootless:latest .
```

3. **Run the container:**
```bash
docker run -d \
  --name quakejs \
  -e HTTP_PORT=8080 \
  -p 8080:8080 \
  -p 27960:27960 \
  quakejs-rootless:latest
```

## Configuration

### Environment Variables

- `HTTP_PORT` - The HTTP port to serve the web interface (default: 8080)

### Server Configuration

The server configuration can be customized by modifying `server.cfg`.

### Ports

- **8080** (or your custom HTTP_PORT) - Web interface (Nginx)
- **27960** - Game server (WebSocket)

## What's Different?

This fork builds upon the excellent work of [@treyyoder/quakejs-docker](https://github.com/treyyoder/quakejs-docker) with the following updates:

| Component | Original | This Fork |
|-----------|----------|-----------|
| Base OS | Ubuntu 20.04 | **Debian 13 Slim** |
| Node.js | 14.x | **22.x LTS** |
| Web Server | Apache 2 | **Nginx Light** |
| Container User | root | **non-root (quakejs)** |
| Maintenance | Updated 2020 | **Updated 2025** |

## 🙏 Credits & Acknowledgments

This wouldn't be possible without these projects:

- **[@treyyoder](https://github.com/treyyoder)** - Original [quakejs-docker](https://github.com/treyyoder/quakejs-docker) implementation that made fully local QuakeJS servers possible
- **[@nerosketch](https://github.com/nerosketch)** - [QuakeJS fork](https://github.com/nerosketch/quakejs.git) with local server capabilities
- **[@inolen](https://github.com/inolen)** - Original [QuakeJS](https://github.com/inolen/quakejs) project

## License

MIT

---

<div align="center">

*For best security: Rootless container + Podman + Nginx + firewall + regular updates*

</div>
