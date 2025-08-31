# Lumio

Lumio is a multi-agent marketing SaaS built with Next.js (frontend), FastAPI (backend), Postgres, and Redis. The project uses Docker for containerization and Caddy as a reverse proxy. A GitHub Actions workflow deploys the application to a server via SSH.

## Features

- **Frontend**: Next.js App Router with TypeScript and support for Tailwind and shadcn/ui.
- **Backend**: FastAPI providing health checks and endpoints for interacting with OpenAI's Responses API and Agents SDK.
- **Agents**: Scaffold for three agents (Scout, Copycat, Planner) to be registered in the backend.
- **Database**: Postgres for persistent storage with migrations managed by the chosen ORM.
- **Queues/Cache**: Redis used for caching or background jobs.
- **Deployment**: Docker Compose orchestrates services including the API, web, Postgres, Redis, and Caddy. A GitHub Actions workflow builds and deploys the stack to your server.
- **Caddy**: Reverse proxy configuration in `ops/Caddyfile` handling TLS (via Cloudflare) and routing subdomains to services.

## Getting Started

### Prerequisites

- A server running Ubuntu with Docker and Docker Compose installed (see `scripts/bootstrap_server.sh`).
- DNS records pointing `app.lumio.ridleysolutions.com` and `api.lumio.ridleysolutions.com` to your server's public IP, proxied through Cloudflare.
- An OpenAI API key and other secrets required by the application.

### Configuration

1. Duplicate `.env.example` to `.env` and fill in all required variables. At minimum you will need:

   - `OPENAI_API_KEY` and optional `OPENAI_ORG_ID`
   - `POSTGRES_PASSWORD` for the Postgres service
   - `JWT_SECRET` used for signing tokens
   - `CF_API_TOKEN`, `CF_ZONE_ID`, and `CF_ACCOUNT_ID` if you automate DNS with Cloudflare

2. Edit `docker-compose.prod.yml` if you need to customize service parameters such as ports or volumes.

### Development

To run the application locally using Docker Compose:

```bash
make dev
```

This command starts Postgres, Redis, the FastAPI backend at `http://localhost:8000`, and the Next.js frontend at `http://localhost:3000`.

### Production

1. Set up your server using the bootstrap script:

```bash
bash scripts/bootstrap_server.sh
```

2. Clone the repository to your server:

```bash
git clone https://github.com/brandonridley/lumio /opt/lumio
cd /opt/lumio
cp .env.example .env
# Fill in environment variables as described above
```

3. Start the services in detached mode:

```bash
make prod
```

4. Verify:

- `https://api.lumio.ridleysolutions.com/healthz` should return `{"ok": true}`
- `https://app.lumio.ridleysolutions.com` should display the Next.js landing page.

### Deployment via GitHub Actions

A workflow file at `.github/workflows/deploy.yml` builds and deploys the application whenever you push to the `main` branch. Ensure that the repository secrets `SSH_HOST`, `SSH_USER`, and `SSH_KEY` are set in GitHub.

### Scripts

- `scripts/bootstrap_server.sh`: Installs Docker and dependencies on a Ubuntu server.

## License

This project is provided as-is without warranty. Feel free to customize and extend as needed.
