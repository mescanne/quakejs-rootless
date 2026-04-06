

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
- Updated to a Docker Hardened Base Image (Debian)
- Updated NPM packages where possible
- Upgraded to Node.js 22.x LTS
- Nginx-light web server multiplexing Web and Game traffic over a single port
- Native HTTPS proxy support without altering game client files
- Runs as non-root user
- Small size ~280MB

## Quick Start

### Using Podman (Recommended)

```bash
podman run -d \
  --name quakejs \
  -p 8080:8080 \
  docker.io/awakenedpower/quakejs-rootless:latest
```

### Using Docker Run

```bash
docker run -d \
  --name quakejs \
  -p 8080:8080 \
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
    # To use the pre-built image:
    image: awakenedpower/quakejs-rootless:latest
    # Or to build directly from the repository source, uncomment the following line and comment out 'image' above:
    # build: https://github.com/JackBrenn/quakejs-rootless.git
    ports:
      - '8080:8080'
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
  -p 8080:8080 \
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
  -p 8080:8080 \
  quakejs-rootless:latest
```

## Configuration

### Server Configuration

The server configuration can be customized by modifying `server.cfg`.

#### Server Environment Variables

You can inject environment variables to easily tune the QuakeJS server performance. The most important setting is `SV_FPS`, which dictates the server's simulation tick rate. 

- `SV_FPS` - Server framerate/tick rate. Default is `20`. Setting this to `125` will drastically reduce input delay and ping times (125Hz = 125 FPS server-side logic).
- `SV_MAXRATE` - Maximum bytes per second the server will send to a single client. Default is engine-dependent, but `25000` is recommended for broadband connections.

**Example with Podman/Docker:**
```bash
podman run -d \
  --name quakejs \
  -p 8080:8080 \
  -e SV_FPS=125 \
  -e SV_MAXRATE=25000 \
  docker.io/awakenedpower/quakejs-rootless:latest
```

### Client Configuration (URL Arguments)

The web client can be dynamically configured just by appending settings to the URL. Because the default engine settings were designed for 56k dial-up modems in 1999, using these URL overrides will result in a significantly smoother and more modern experience!

- **Standard Connection** (Engine Defaults)
  `http://<your-server-ip>:8080/`
  
- **Competitive/Broadband Connection** (Highly Recommended)
  `http://<your-server-ip>:8080/?set%20rate%2025000&set%20cl_maxpackets%20125&set%20cg_predictItems%201`
  *What this does:*
  - `rate 25000` - Tells the server your internet can handle high bandwidth updates.
  - `cl_maxpackets 125` - Syncs your client's upload rate to match a 125Hz server.
  - `cg_predictItems 1` - Eliminates the visual delay when picking up weapons or health on higher ping connections.

- **High Ping / Unstable Connection**
  `http://<your-server-ip>:8080/?set%20cl_maxpackets%2060&set%20snaps%2040`
  *What this does:* Trades maximum update frequency for stability on jittery network connections.

### Ports

- **8080** - Multiplexed Web interface and Game server port. Web requests are handled by Nginx directly, while WebSocket game traffic is seamlessly forwarded internally. This makes proxying behind SSL natively supported via a single port.

## What's Different?

This fork builds upon the excellent work of [@treyyoder/quakejs-docker](https://github.com/treyyoder/quakejs-docker) with the following updates:

| Component | Original | This Fork |
|-----------|----------|-----------|
| Base OS | Ubuntu 20.04 | **Debian 13 Docker Hardened Image** |
| Node.js | 14.x | **22.x LTS** |
| Web Server | Apache 2 | **Nginx Light** |
| Container User | root | **non-root** |
| Networking | Dual Port | **Single Port Multiplexed via Nginx** |

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
