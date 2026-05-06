---
name: openclaw-os
description: |
  OpenClaw OS — Sistema completo para criar agentes AI pessoais 24/7 no VPS dos seus alunos.
  Pipeline guiado de 7 fases: memoria, credenciais, infra+seguranca, identidade, skills, custos+immune, mission control.
  Pre-requisitos: VPS Hostinger, conta ChatGPT, Telegram. Use /openclaw-os:start para comecar do zero.
  Subcomandos: start, provision, upgrade, daily, status, resume, add-skill, extract-memory, help.
---

# OpenClaw OS

Sistema unificado pra criar e gerenciar agentes AI pessoais (claws) rodando 24/7 em VPS.

## O que e um claw

Um **claw** e um agente AI pessoal do aluno, rodando num VPS dele, conectado ao Telegram, com identidade propria, memoria persistente, skills proprias, e immune system.

## Subcomandos disponiveis

Digite `/openclaw-os:` no prompt e o autocomplete mostra:

| Comando | Quando usar |
|---|---|
| `/openclaw-os:start` | **COMECE AQUI**. Pipeline guiado completo do zero. Roda as 7 fases em sequencia. |
| `/openclaw-os:resume` | Retoma pipeline interrompido (le state.json). |
| `/openclaw-os:upgrade` | Atualiza claw existente (brownfield audit + remediate). |
| `/openclaw-os:daily` | Operacoes diarias multi-claw (health check + sync). |
| `/openclaw-os:status` | Health check rapido de um claw. |
| `/openclaw-os:add-skill` | Adicionar skill nova ao claw. |
| `/openclaw-os:extract-memory` | Extrair perfil do aluno via ChatGPT (gera USER.md). |
| `/openclaw-os:help` | Lista comandos com descricao detalhada. |

Subcomandos avancados (rodados pelo `:start` automaticamente, mas chamaveis isolados):

| Comando | Fase |
|---|---|
| `/openclaw-os:phase-1` | Memory Extraction (perfil do aluno) |
| `/openclaw-os:phase-2` | Credentials Collection (VPS, ChatGPT, Telegram) |
| `/openclaw-os:phase-3` | Infra + Security 9-layer hardening |
| `/openclaw-os:phase-4` | Identity + Memory 4-layer system |
| `/openclaw-os:phase-5` | Skills + Crons + Heartbeat |
| `/openclaw-os:phase-6` | Costs + Immune System |
| `/openclaw-os:phase-7` | Mission Control + Go-Live |

## Pre-requisitos do aluno

Antes de rodar `/openclaw-os:start`, o aluno precisa ter:

1. **Conta Hostinger com VPS** (KVM 1 ou 2, Ubuntu 24.04 instalado)
2. **Conta ChatGPT** (Plus de preferencia, pra extracao de perfil)
3. **Telegram instalado** no celular

## Como o pipeline funciona

```
START
  |
  v
Phase 1: Memory Extraction      (10 min) — usa ChatGPT pra extrair perfil
  |
  v
Phase 2: Credentials            (10 min) — coleta VPS, ChatGPT API, Telegram bot
  |
  v
Phase 3: Infra + Security       (20 min) — instala OpenClaw + 9 camadas seguranca
  |
  v
Phase 4: Identity + Memory      (15 min) — cria SOUL, USER, IDENTITY, AGENTS
  |
  v
Phase 5: Skills + Crons         (15 min) — primeira skill + heartbeat
  |
  v
Phase 6: Costs + Immune         (10 min) — model split + watchdog + backup
  |
  v
Phase 7: Mission Control        (10 min) — health check final + checklist
  |
  v
GO-LIVE (claw 24/7 rodando)
```

**Tempo total estimado:** 90 minutos por aluno.

## Estado e retomada

O pipeline salva estado em `~/.openclaw/{claw-name}/state.json` apos cada fase. Se o aluno fechar a sessao no meio, na proxima vez e so rodar `/openclaw-os:resume` que continua de onde parou.

## Quando o aluno digita `/openclaw-os` (sem subcomando)

Quando o usuario invocar esta skill sem subcomando, mostre este menu e pergunte qual quer rodar:

```
OpenClaw OS — escolha o que fazer:

  1. /openclaw-os:start          (criar claw novo do zero)
  2. /openclaw-os:resume         (continuar pipeline interrompido)
  3. /openclaw-os:upgrade        (atualizar claw existente)
  4. /openclaw-os:status         (health check)
  5. /openclaw-os:daily          (operacoes diarias)
  6. /openclaw-os:help           (ver detalhes de cada comando)

Digite o numero ou o comando completo.
```

Apos a escolha, oriente o usuario a digitar o comando `/openclaw-os:NOME` correspondente. NAO execute o subcomando voce mesmo: o usuario precisa invoca-lo pelo prompt para a skill correta carregar.

## Arquitetura interna

A skill OpenClaw OS e standalone (nao depende de squads). Templates ficam em `~/coreaios/openclaw-os/templates/`, checklists em `~/coreaios/openclaw-os/checklists/`, estado em `~/.openclaw/{claw-name}/state.json`.

Origem: fusao dos squads `openclaw-creator` (9 fases setup + security + immune) e `openclaw-manager` (memory extraction + credentials + brownfield + fleet ops). Squads originais ficam arquivados em `squads/_archive/`.
