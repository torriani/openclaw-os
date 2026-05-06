---
name: openclaw-os:phase-7
description: |
  Phase 7 — Mission Control + Go-Live. Health check final completo, checklist de
  conclusao, marca go_live=true, da resumo final ao aluno com proximos passos.
  Pre-req: phase 6 OK.
---

# Phase 7 — Mission Control + Go-Live

**Tempo:** 10 min
**Objetivo:** Validar todo o setup, marcar go-live, entregar resumo final.

## Pre-checks

- state.json: `phases_completed` contem [1..6]

## Fluxo

### Step 1: Apresentar

```
========================================
  PHASE 7 — MISSION CONTROL
========================================

Ultima fase. Vou rodar health check completo (~10min):
  - VPS responsivo
  - OpenClaw service active
  - Telegram bot conectado
  - Heartbeat batendo (ultimo <5min)
  - Skills carregadas
  - Watchdog ativo
  - Backup configurado

Pronto?
```

### Step 2: Rodar health check

Pra cada item, SSH no VPS e valida:

| Check | Comando | OK se |
|---|---|---|
| Service active | `systemctl is-active openclaw` | retorna `active` |
| Heartbeat | `cat ~/openclaw/heartbeat.log \| tail -1` | timestamp <5min atras |
| Telegram | `curl -s "https://api.telegram.org/bot{TOKEN}/getMe"` | `"ok":true` |
| OpenAI | `curl com key` | retorna 200 |
| Skills | `ls ~/openclaw/skills/` | >= 1 dir |
| Watchdog cron | `crontab -l \| grep watchdog` | tem linha |
| Backup cron | `crontab -l \| grep backup` | tem linha |
| UFW | `ufw status` | active |
| Fail2ban | `systemctl is-active fail2ban` | active |

### Step 3: Resumo final

```
========================================
  CLAW {claw-name} ESTA NO AR ✓
========================================

Health check: 9/9 ✓

ENDPOINT TELEGRAM: @{claw-slug}_bot
VPS:              {ip} (Hostinger Ubuntu 24.04)
SKILLS:           {lista}
HEARTBEAT:        ativo (cron 5min)
WATCHDOG:         ativo (auto-recovery)
BACKUP:           diario 03:00 UTC

CUSTOS ESTIMADOS:
  VPS Hostinger:  $5-10/mes
  ChatGPT API:    $5-15/mes (com model split)
  Total:          $10-25/mes

PROXIMOS PASSOS:
  1. Abre Telegram → fala com @{claw-slug}_bot
  2. Manda "oi" e ve a resposta
  3. /openclaw-os:add-skill   pra adicionar mais skills
  4. /openclaw-os:status      pra health check rapido
  5. /openclaw-os:daily       pra rotinas diarias

PARABENS! Seu claw tah vivo. 🎉
```

### Step 4: state.json final

```json
{
  "phases_completed": [1,2,3,4,5,6,7],
  "current_phase": null,
  "go_live": true,
  "go_live_at": "{timestamp}"
}
```

### Step 5: Telegram smoke test final

```
ULTIMO PASSO: vai no Telegram agora, manda "oi" pro @{claw-slug}_bot,
e me confirma aqui que ele respondeu.

(Se nao responder em 10s, rode /openclaw-os:status pra diagnosticar.)
```

## Veto conditions

- 9/9 nao passa → identifica qual falhou + roda subcomando especifico de fix
- Telegram smoke test final falha → NAO marca go_live

## Origem
setup-chief.md (Phase 9 — Mission Control do Creator)
