---
name: openclaw-os:integrations
description: |
  Etapa 5 — Conecta o agente ao mundo real. Web Search nativo, Google
  Workspace (Calendar, Gmail, Drive) via gog CLI, PDF reader, Session Memory
  experimental, Memory Flush personalizado, 2 crons (lembrete agenda 1h +
  daily briefing 7h). Pre-req: Etapa 4 OK. Tempo: ~30min.
---

# Etapa 5 — Integracoes & Crons

**Tempo:** 30 min
**Objetivo:** Agente conectado a Calendar, Gmail, Drive, web, PDF — e com
2 automacoes proativas (lembrete agenda + daily briefing).

## Pre-checks

- state.json: `etapas_completas` contem [0..4]
- Memoria funcionando (testada na Etapa 4)

## Apresentacao

```
========================================
  ETAPA 5 — INTEGRACOES & CRONS
========================================

Vamos conectar seu agente ao mundo:

  - Web Search nativo (busca em tempo real)
  - Google Workspace (Calendar, Gmail, Drive) via gog CLI
  - PDF Reader nativo (analisa documentos)
  - Session Memory experimental
  - Memory Flush personalizado
  - Cron 1: Lembrete de agenda (toda hora)
  - Cron 2: Daily briefing (7h, seg-sex)

Tempo: ~30min. Pronto?
```

## Os passos

### Passo 1 — Mapear integracoes pelo USER.md

```
PASSO 1/8 — MAPEAR INTEGRACOES

Cola este PROMPT no Telegram:

────────────────────────────────────────
Le meu USER.md e me recomenda 3-5 integracoes prioritarias baseadas
no meu perfil (negocio, rotina, ferramentas que ja uso).

Foca em:
  - Web Search (todo mundo precisa)
  - Google Workspace (Calendar, Gmail, Drive) se eu uso Google
  - Outras integracoes especificas se fizer sentido pra mim

Me retorna uma lista priorizada.
────────────────────────────────────────

Cola aqui o que ele recomendou.
```

### Passo 2 — Ativar Web Search

```
PASSO 2/8 — WEB SEARCH NATIVO

No Terminal 2 (SSH na VPS):

    claude /web-search:enable

Deve retornar ✓ ou similar. Cola o output.
```

### Passo 3 — Instalar gog CLI

```
PASSO 3/8 — GOG CLI (Google Workspace)

No Terminal 2:

    npm install -g gog

Quando terminar:

    gog auth login

Vai abrir um link pra voce logar na conta Google. Faz login com a
conta que voce quer que o agente use (sugiro criar uma conta dedicada
pro agente — ex: alfred.assistant@gmail.com).

Quando confirmar "Authenticated", me diz "ok".
```

### Passo 4 — Validar gog

```
PASSO 4/8 — TESTAR GOG

Cola UM POR VEZ:

    gog calendar list --account=SEU_EMAIL --limit 5

    gog gmail inbox --limit 10

Se retornarem dados (eventos do calendario, emails), ta OK.
Cola aqui um trecho do output pra eu validar.
```

### Passo 5 — Cron lembrete agenda

```
PASSO 5/8 — CRON LEMBRETE DE AGENDA

No Terminal 2:

    claude /cron:create lembrete-agenda

Configuracao:
  Schedule: 0 * * * * (toda hora cheia)
  Acao: ler proximas 2h da agenda, avisar no Telegram se evento <60min
  sessionTarget: isolated
  agentTurn: true
  announce: telegram

Confirma e me diz "criado".
```

### Passo 6 — Cron daily briefing

```
PASSO 6/8 — CRON DAILY BRIEFING

No Terminal 2:

    claude /cron:create daily-briefing

Configuracao:
  Schedule: 0 7 * * 1-5 (7h da manha, seg a sex)
  Acao: 3 reunioes do dia + 5 emails mais relevantes + memory/pending.md
  Modelo: Sonnet (mais barato)
  announce: telegram

Confirma e me diz "criado".
```

### Passo 7 — PDF nativo + Session Memory + Memory Flush

```
PASSO 7/8 — RECURSOS EXTRAS

Cola este PROMPT no Telegram:

────────────────────────────────────────
Ativa pra mim:

  1. PDF nativo — voce consegue ler PDFs que eu te mandar
  2. Session Memory experimental no openclaw.json (memoria + sessions
     com hybrid query)
  3. Memory Flush personalizado — antes de compactar uma sessao, salva
     TUDO em memory/ (decisoes, licoes, pendencias, projetos)

Confirma quando ativar os 3.
────────────────────────────────────────
```

### Passo 8 — Split de modelos

```
PASSO 8/8 — SPLIT DE MODELOS

Cola este PROMPT:

────────────────────────────────────────
Configura split de modelos:

  - Haiku → heartbeats e checks simples (20x barato)
  - Sonnet → crons (lembrete-agenda, daily-briefing)
  - Opus → interacao direta comigo (qualidade maxima)

Atualiza openclaw.json com isso.
────────────────────────────────────────
```

## Validacao

```
TESTE FINAL:

1. Espera o proximo horario cheio (ex: 14:00) — voce deve receber
   um Telegram com "Proximo evento: X em 45min" (ou "nada nas
   proximas 2h").

2. Amanha as 7h, voce deve receber o daily briefing automatico.

Se ambos chegarem, integracoes OK.
```

## Atualizar state.json

```json
{
  "current_etapa": 6,
  "etapas_completas": [0..5],
  "integrations": {
    "web_search": true,
    "gog_calendar": true,
    "gog_gmail": true,
    "pdf_reader": true,
    "session_memory": true,
    "cron_lembrete_agenda": true,
    "cron_daily_briefing": true,
    "model_split": {"heartbeats": "haiku", "crons": "sonnet", "interactive": "opus"}
  }
}
```

## Fechar

```
✓ Etapa 5 concluida

PROXIMA ETAPA: Etapa 6 — Proatividade (~25min)

Volta ao /openclaw-os:setup.
```

## Origem
Curso M2 · Etapa 5 (Integracoes & Crons).
