# Deploy OpenClaw on Render

> [!IMPORTANT]
> **View full deployment instructions in the [Render docs](https://render.com/docs/deploy-openclaw).**

## What is this?

**OpenClaw Render Blueprint**: This template defines a `render.yaml` file you can use to deploy [OpenClaw](https://github.com/openclaw/openclaw) on Render. It uses the official project's [container image](https://github.com/openclaw/openclaw/pkgs/container/openclaw).

**OpenClaw Version**: By default, this template uses the `latest` tag. Override this by setting the `OPENCLAW_VERSION` environment variable to a specific version tag.

## Setup

1. **Fork the repo**: Fork the [render openclaw example repo](https://github.com/render-examples/openclaw-render) by [clicking here](https://github.com/new?template_name=openclaw-render&template_owner=render-examples).
2. **Connect Blueprint**: Connect your Blueprint by [clicking here](https://dashboard.render.com/select-repo?type=blueprint) and selecting your repo. Specify the following configurations:
   - **Blueprint Name**: `openclaw`
   - **Branch**: `main`
   - **Blueprint Path**: `render.yaml`
   - **API Key**: Specify at least one API key provider. For OpenRouter, you can get yours [here](https://openrouter.ai/workspaces/default/keys).
3. **Deploy to Render**: Follow the deployment instructions in the [Render docs](https://render.com/docs/deploy-openclaw).

## Authentication

1. On your first visit, the landing page prompts for your `OPENCLAW_GATEWAY_TOKEN`
2. Valid token sets a signed, HTTP-only cookie (30-day expiry)
3. Sessions persist across service restarts

**Security:**

- Gateway binds to loopback only (never directly exposed)
- Constant-time token comparison
- Rate limiting (5 attempts/minute per IP)
- Secure cookies (HTTPS only, `SameSite=Lax`)

## Customization

Override the OpenClaw version with a build argument:

```bash
docker build --build-arg OPENCLAW_VERSION=2026.2.3 -t openclaw-render .
```
