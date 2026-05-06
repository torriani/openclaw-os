---
name: openclaw-os:phase-3
description: |
  Phase 3 — Infra + Security 9-layer. Conecta SSH no VPS, instala OpenClaw,
  aplica 9 camadas de seguranca (UFW, Fail2ban, SSH key-only, dmPolicy, 1Password,
  Cloudflare proxy, audit log, systemd hardening). Pre-req: phase 2 OK.
---

# Phase 3 — Infra + Security 9-layer

**Tempo:** 20 min
**Objetivo:** VPS configurado com OpenClaw rodando + 9 camadas de seguranca aplicadas.

## Pre-checks

- state.json mostra `phases_completed` contem [1, 2]
- `~/.openclaw/{claw-slug}/.env` existe com VPS_IP, VPS_PASSWORD validados

## Conteudo de referencia

Esta fase combina o conteudo de:
- `legacy/squads/openclaw-creator/agents/infra-installer.md` (9 camadas seguranca)
- `legacy/squads/openclaw-creator/checklists/setup-checklist.md` (Phase 1+2 gates)

Le esses arquivos completos como referencia operacional. Eles tem o passo a passo.

## Fluxo resumido

1. **Apresentar:** "Vou conectar no VPS e instalar OpenClaw + hardening 9-layer (~20min)"
2. **Conectar SSH** com creds do `.env`
3. **Update Ubuntu** + dependencias (Node, Python, git, curl, ufw, fail2ban)
4. **Instalar OpenClaw** (clone repo + npm install + configure .env no VPS)
5. **9 camadas seguranca:**
   - L1: SSH key-only (gerar key, desabilitar password auth)
   - L2: UFW firewall (deny inbound, allow 22/443)
   - L3: Fail2ban (5 tentativas = ban 1h)
   - L4: dmPolicy allowlist (so chat_id do aluno responde)
   - L5: Audit log (todas as msgs em ~/openclaw/logs/)
   - L6: systemd service com User=claw (nao roda como root)
   - L7: Cloudflare proxy (se aluno tem dominio, opcional)
   - L8: 1Password CLI sync (se aluno tem, opcional)
   - L9: credential audit semanal (cron domingo)
6. **Smoke test:** `systemctl status openclaw` retorna `active (running)`
7. **Atualizar state.json:** `phases_completed: [1,2,3]`, `current_phase: 4`
8. **Fechar:** "Phase 3 OK. OpenClaw rodando, 9 camadas ativas. /openclaw-os:start → ok"

## Veto conditions

- SSH falha apos 3 tentativas → PARA
- `npm install` falha → diagnostica versao Node (precisa >= 18)
- systemctl status mostra `failed` → mostra logs antes de avancar
- Layer minima nao aplicada (UFW + Fail2ban + dmPolicy) → NAO avanca

## Origem
infra-installer.md + setup-checklist.md (Phase 1, 2 do Creator)
