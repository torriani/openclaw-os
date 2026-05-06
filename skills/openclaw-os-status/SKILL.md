---
name: openclaw-os:status
description: |
  Health check rapido de um claw. Verifica VPS reachable, OpenClaw service active,
  Telegram bot OK, heartbeat recente, gastos no mes.
---

# OpenClaw OS — Status

## Fluxo

### Step 1: Escolher claw

Lista claws em `~/.openclaw/*/state.json` com `go_live: true`. Aluno escolhe.

### Step 2: Health check (10 verificacoes)

Le `.env` do claw, conecta SSH, valida:

| # | Check | Comando |
|---|---|---|
| 1 | VPS ping | `ping -c 1 -W 2 {VPS_IP}` |
| 2 | SSH conecta | `ssh ... echo OK` |
| 3 | OpenClaw service | `systemctl is-active openclaw` |
| 4 | Heartbeat <5min | `tail -1 ~/openclaw/heartbeat.log` |
| 5 | Telegram bot | `curl getMe` |
| 6 | OpenAI API | `curl /v1/models` |
| 7 | UFW active | `ufw status` |
| 8 | Fail2ban | `systemctl is-active fail2ban` |
| 9 | Disk usage <80% | `df -h /` |
| 10 | RAM usage <80% | `free -m` |

### Step 3: Output

```
========================================
  STATUS — alfred
========================================

  ✓ VPS responde         (12ms)
  ✓ SSH conecta          (root@xxx.xxx.xxx.xxx)
  ✓ OpenClaw service     (active, uptime 5d 3h)
  ✓ Heartbeat            (3min atras)
  ✓ Telegram bot         (@alfred_bot, online)
  ✓ OpenAI API           (200 OK)
  ✓ UFW firewall         (active, 2 rules)
  ✓ Fail2ban             (active, 0 banned)
  ✓ Disco                (12GB / 50GB usado, 24%)
  ✓ RAM                  (340MB / 1GB, 34%)

GASTOS NO MES (estimado):
  ChatGPT API:  $4.20  (de $15 budget)
  VPS:          $5.00  (Hostinger KVM 1)
  Total:        $9.20

PROXIMOS EVENTOS:
  - Backup automatico: hoje 03:00 UTC
  - Audit semanal: domingo 09:00 UTC

Tudo OK. ✓
```

### Se algo falhar

Mostra qual check falhou + sugere comando de fix:

```
  ✗ OpenClaw service     (FAILED — exited 2min atras)

PROBLEMA DETECTADO. Tentar fix automatico?

  ssh root@xxx 'systemctl restart openclaw && journalctl -u openclaw -n 50'
```
