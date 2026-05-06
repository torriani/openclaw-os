---
name: openclaw-os:daily
description: |
  Operacoes diarias multi-claw. Roda health check em todos os claws ativos,
  sincroniza inventario de skills, gera alertas (claws offline >30min, custos altos).
  Use 1x por dia ou semana pra fleet.
---

# OpenClaw OS — Daily Ops

**Tempo:** 5-10 min (automatico, voce so revisa)
**Objetivo:** Manter saude da fleet inteira.

## Quando usar

- 1x por dia (manual ou via cron)
- Quando quer ver overview de todos os claws de uma vez
- Antes de fechar o dia

## Conteudo de referencia


## Fluxo

1. **Listar claws ativos:**
   ```bash
   ls ~/.openclaw/*/state.json
   ```
   Filtra os com `go_live: true`.

2. **Pra cada claw, rodar health check (10 verificacoes do /openclaw-os:status)**

3. **Sumario fleet-wide:**
   ```
   ========================================
     FLEET DAILY OPS — 2026-05-05
   ========================================

   CLAWS ATIVOS: 5

   ✓ alfred       Healthy    Heartbeat 2min,  $4.20/mes
   ✓ sofia        Healthy    Heartbeat 1min,  $7.80/mes
   ⚠ zeus         Degraded   Heartbeat 12min, $18.40/mes  ← perto do budget
   ✗ jarvis       Offline    Heartbeat 4h     ← INVESTIGAR
   ✓ luna         Healthy    Heartbeat 5min,  $3.10/mes

   FLEET TOTAL: $33.50/mes (5 claws, media $6.70)

   ALERTAS:
     - jarvis offline ha 4h: rodar /openclaw-os:status jarvis pra diagnosticar
     - zeus a 92% do budget: revisar uso ou aumentar limite

   PROXIMO DAILY OPS: amanha 06:00 UTC (cron)
   ```

4. **Atualizar registry** em `~/.openclaw/fleet-status.json`

## Veto conditions

- Claw offline >24h → escalate (alerta visivel, nao some no log)
