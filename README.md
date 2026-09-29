# X-Security website

PHP multi-page website for the X-Security service lines. The design and implementation handoff is in WEBSITE-DESIGN-BRIEF.md.

## Run with Docker

Build and start the production image:

    docker build -t x-security-site .
    docker run --rm -p 8080:8080 x-security-site

Visit http://localhost:8080. Apache serves the app on port 8080 as www-data, with a Docker health check.

For local HTTP-only development, turn off the production secure-cookie setting:

    docker run --rm -p 8080:8080 -e APP_ENV=development -e SESSION_COOKIE_SECURE=0 x-security-site

For deployment, terminate TLS at a trusted reverse proxy and keep SESSION_COOKIE_SECURE=1. Configure proxy trust and forwarded headers only in the hosting layer you control.

## Production readiness

- The image copies only the PHP entry point and public assets; PRD and planning files are excluded.
- Apache runs as the unprivileged www-data user and enables PHP production error handling, bounded request sizes, session protections, OPcache, and a health check.
- Use HTTPS, a managed reverse proxy, routine base-image rebuilds, image vulnerability scanning, and deployment monitoring.
- The contact form is a prototype and does not deliver or retain inquiries. Do not accept production inquiries until an approved, monitored CRM/email destination and privacy/retention policy are connected. The current form's success response is only for local demonstrations.
- Supply real office details, verified credentials, approved case studies and leadership information before launch. Illustrative scenarios are labeled as such.
- The current app is native PHP because no framework scaffold was present. If Laravel is required, migrate the pages and form handling into Laravel before production.

## GitHub

This workspace currently has no Git repository or configured remote. Connect it to the intended GitHub repository before pushing.
