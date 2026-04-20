# Deploy OpenClaw on Render

> [!IMPORTANT]
> **View full deployment instructions in the [Render docs](https://render.com/docs/deploy-openclaw).**

## What is this repo?

**OpenClaw Render Blueprint**: This template defines a `render.yaml` file you can use to deploy [OpenClaw](https://github.com/openclaw/openclaw) on Render. It uses the official project's [container image](https://github.com/openclaw/openclaw/pkgs/container/openclaw).

## OpenClaw Version

By default, this template uses the `latest` tag.

Override this by setting the `OPENCLAW_VERSION` environment variable to a specific version tag.

You can find all the latest Docker builds [here](https://github.com/openclaw/openclaw/pkgs/container/openclaw).

## How do I set up my RenderClaw?

### One Time Setup

1. **Fork the repo**: Fork the [render openclaw example repo](https://github.com/render-examples/openclaw-render) by [clicking here](https://github.com/new?template_name=openclaw-render&template_owner=render-examples).
2. **Connect Blueprint**: Connect your Blueprint by [clicking here](https://dashboard.render.com/select-repo?type=blueprint) and selecting your repo. Specify the following configurations:
   - **Blueprint Name**: `openclaw`
   - **Branch**: `main`
   - **Blueprint Path**: `render.yaml`
   - **API Key**: Specify at least one API key provider. For OpenRouter, you can get yours [here](https://openrouter.ai/workspaces/default/keys).

### Deploying a RenderClaw

Follow the deployment instructions in the [Render OpenClaw docs](https://render.com/docs/deploy-openclaw).

You will either:

1. Auto-deploy your RenderClaw when creating the blueprint (see above)
2. Manually-deploy your RenderClaw if a blueprint already exists

### Authenticating your RenderClaw

Find your OpenClaw deployment on render, and then:

1. Under `Environment`, find `OPENCLAW_GATEWAY_TOKEN` and copy the value
2. Find the `External URL` for your deployment and open it in your browser
3. Paste the token into the `OPENCLAW_GATEWAY_TOKEN` field on the landing page

Note the following:

- Valid token sets a signed, HTTP-only cookie (30-day expiry)
- Sessions persist across service restarts

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
