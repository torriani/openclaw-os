---
name: openclaw-os:help
description: |
  Lista todos os comandos da skill OpenClaw OS com descricao detalhada,
  pre-requisitos, e quando usar cada um.
---

# OpenClaw OS — Help

Mostre EXATAMENTE este texto quando invocado:

```
========================================
  OPENCLAW OS — COMANDOS DISPONIVEIS
========================================

PIPELINE PRINCIPAL (ordem natural)

  /openclaw-os:start
    → Comeca pipeline do zero (7 fases, ~90min)
    → Use isto pra criar claw novo

  /openclaw-os:resume
    → Retoma pipeline interrompido
    → Use se voce parou no meio e quer continuar

OPERACAO DIA A DIA

  /openclaw-os:status
    → Health check rapido (10 verificacoes em 30s)
    → Use pra confirmar que claw ta saudavel

  /openclaw-os:daily
    → Operacoes diarias multi-claw
    → Use uma vez por semana pra fleet inteira

  /openclaw-os:add-skill
    → Adicionar skill nova ao claw existente
    → Use quando quiser ensinar nova capacidade

GERENCIAR CLAW EXISTENTE

  /openclaw-os:upgrade
    → Brownfield audit + remediate
    → Use se claw foi criado fora do pipeline ou ta desatualizado

  /openclaw-os:extract-memory
    → Re-extrair perfil do aluno (USER.md)
    → Use se perfil mudou bastante (mudou de empresa, foco, etc)

FASES INDIVIDUAIS (avancado)

  /openclaw-os:phase-1   Memory Extraction (10min)
  /openclaw-os:phase-2   Credentials (10min)
  /openclaw-os:phase-3   Infra + Security 9-layer (20min)
  /openclaw-os:phase-4   Identity + Memory 4-layer (15min)
  /openclaw-os:phase-5   Skills + Crons + Heartbeat (15min)
  /openclaw-os:phase-6   Costs + Immune System (10min)
  /openclaw-os:phase-7   Mission Control + Go-Live (10min)

  → Use se precisar refazer 1 fase isolada
  → /openclaw-os:start chama estas em sequencia automaticamente

PRE-REQUISITOS DO ALUNO

  1. VPS Hostinger (Ubuntu 24.04)
  2. Conta ChatGPT (Plus recomendado)
  3. Telegram instalado

CUSTOS MENSAIS ESTIMADOS

  VPS:          $5-10
  ChatGPT API:  $5-15 (com model split)
  Total:        $10-25

DUVIDAS COMUNS

  Q: Quanto tempo total?
  A: 90min se primeira vez, 30min se ja conhece.

  Q: Posso parar no meio?
  A: Sim. Use /openclaw-os:resume pra retomar.

  Q: Como faco com 5 alunos ao mesmo tempo?
  A: Cada aluno roda /openclaw-os:start na sessao dele.
     state.json fica em ~/.openclaw/{nome-do-claw}/, separado.

  Q: Onde ficam credenciais?
  A: ~/.openclaw/{claw}/.env (chmod 600, nunca vai pra Git)
```
