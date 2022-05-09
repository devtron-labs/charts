# Devtron helm chart to deploy discord alert manager

> Helm chart to deploy webhook integration for sending alert manager alerts on discord. Give this a webhook (with the DISCORD_WEBHOOK environment variable) and point it as a webhook on alertmanager, and it will post your alerts into a discord channel for you as they trigger

## Note : Right now we don't have direct support in prometheus to send alerts on discord.

## prerequisite
**Must have prometheus stack deployed on cluster**

## Usage

**Provide the service url of discord alert manager in prometheus alertmanger configuration file like below**

```
receivers
- name: discord
  webhook_configs:
    - send_resolved: True
      url: 'service_url_discord_alertmanger'
```
