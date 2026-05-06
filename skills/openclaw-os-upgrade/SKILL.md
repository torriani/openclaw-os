---
name: openclaw-os:upgrade
description: |
  Brownfield audit + remediate de claw existente. SSH no VPS, audita 6 dimensoes
  (security, identity, memory, skills, costs, immune), gera relatorio de gaps,
  remedia em ordem de prioridade. Use pra atualizar claws antigos ou nao-padronizados.
---

# OpenClaw OS — Upgrade (Brownfield)

**Tempo:** 30-60 min
**Objetivo:** Auditar claw existente e elevar pro padrao OpenClaw OS atual.

## Quando usar

- Aluno tem claw antigo (criado fora do pipeline /openclaw-os:start)
- Aluno migrou de outro sistema e quer padronizar
- Suspeita de gap de seguranca (UFW desligado, sem fail2ban, etc)

## Pre-checks

- Aluno precisa de IP + senha root do claw existente
- Pelo menos 1 claw com state.json em `~/.openclaw/` ou aluno informa creds

## Conteudo de referencia


## Fluxo resumido

1. **Conectar SSH** no claw existente
2. **Audit 6 dimensoes:**
   - Security: UFW, Fail2ban, SSH key-only, dmPolicy
   - Identity: SOUL/USER/IDENTITY/AGENTS existem?
   - Memory: 4-layer ativo? backup configurado?
   - Skills: quantas? heartbeat ativo?
   - Costs: model split configurado? budget alert?
   - Immune: watchdog cron? backup diario?
3. **Gerar relatorio:**
   ```
   AUDIT — alfred (criado 2025-08-01)

   Security    : 6/9 ✗ (faltam: dmPolicy, audit log, 1Password)
   Identity    : 3/4 ✗ (falta: AGENTS.md)
   Memory      : 2/4 ✗ (falta: semantic, procedural)
   Skills      : 1/1 ✓
   Costs       : 0/3 ✗ (sem model split, sem budget, sem rate limit)
   Immune      : 1/5 ✗ (so tem backup; falta watchdog, OOM, audit, key rotation)

   GAPS PRIORITARIOS:
     1. CRITICO: configurar dmPolicy (qualquer um pode falar com o bot)
     2. CRITICO: configurar watchdog (claw nao auto-recupera)
     3. ALTO: model split (usando gpt-4o pra tudo, custo 5x maior)
   ```
4. **Remediate em ordem:**
   - Aluno aprova plano
   - Pra cada gap, executa fix correspondente (chama phase-3, phase-6, etc)
5. **Re-audit:** mostra antes/depois
6. **state.json:** marca `upgraded_at: timestamp`

## Veto conditions

- Audit identifica vulnerabilidade ATIVA (porta 22 aberta sem fail2ban + brute force em logs) → fix IMEDIATO antes de continuar
