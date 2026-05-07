---
name: openclaw-os:proactivity
description: |
  Etapa 6 — Proatividade. Cria HEARTBEAT.md (o que checar a cada 4h),
  define horarios de silencio, configura Haiku como modelo de heartbeat
  (~$0.005 vs $0.10 Opus), 2 automacoes (checagem emails+agenda 4/4h +
  organizacao memoria 1x/noite). Pre-req: Etapa 5 OK. Tempo: ~25min.
---

# Etapa 6 — Proatividade

**Tempo:** 25 min
**Objetivo:** Agente nao espera mais voce falar. Ele te avisa quando algo
relevante acontece.

## Apresentacao

```
========================================
  ETAPA 6 — PROATIVIDADE
========================================

Ate agora seu agente e REATIVO. Voce fala, ele responde.
Vamos torna-lo PROATIVO. Ele te avisa sem voce pedir.

Mas com bom senso:
  - Urgencia real → te interrompe (Telegram)
  - Trabalho fundo → silencioso (acumula resumo pro daily)
  - Madrugada/dia de folga → silencio total

Vamos configurar:
  1. HEARTBEAT.md — o que ele checa a cada 4h
  2. Horarios de silencio
  3. Modelo Haiku (20x barato pra heartbeats)
  4. Automacao 1: checagem emails+agenda
  5. Automacao 2: organizacao memoria (noite)

Tempo: ~25min. Pronto?
```

## Os passos

### Passo 1 — Criar HEARTBEAT.md

```
PASSO 1/5 — HEARTBEAT.md

Cola este PROMPT no Telegram:

────────────────────────────────────────
Cria pra mim um HEARTBEAT.md que define o que voce vai checar a cada
4 horas e quando deve me interromper.

Estrutura:

## Checklist de heartbeat (a cada 4h)

  1. Emails urgentes
     - Filtros: cliente conhecido, palavra "urgente", "ASAP"
     - Acao: avisa no Telegram se houver

  2. Agenda
     - Eventos nas proximas 24-48h
     - Acao: lembra se tem reuniao em <2h

  3. Projetos parados
     - Projetos sem update em 7+ dias (memory/projects/)
     - Acao: levanta no daily briefing (nao interrompe)

  4. Metricas
     - Se eu tiver dashboards conectados
     - Acao: alerta se algo sair do normal

## Regra de ouro

Urgencia real = avisa.
Trabalho fundo = silencioso.
Janela de silencio = acumula, nao envia.

Salva em memory/HEARTBEAT.md e me confirma.
────────────────────────────────────────
```

### Passo 2 — Janelas de silencio

```
PASSO 2/5 — HORARIOS DE SILENCIO

Cola este PROMPT:

────────────────────────────────────────
Configura janelas de silencio no meu HEARTBEAT.md:

  - Segunda a sexta: ATIVO 7h-21h
  - Sabado: ATIVO 9h-18h
  - Domingo: SILENCIO TOTAL
  - Todo dia 22h-7h: SILENCIO

Durante silencio, voce NAO me manda Telegram. Acumula tudo num
resumo que entrega no proximo horario ativo.

Confirma quando atualizar.
────────────────────────────────────────
```

### Passo 3 — Configurar Haiku

```
PASSO 3/5 — MODELO HAIKU (heartbeat barato)

No Terminal 2:

    claude /heartbeat:configure

Configuracao:
  model: claude-haiku-4-5
  fallback: claude-sonnet-4-6
  schedule: 0 */4 * * *  (a cada 4 horas)
  silenceWindow:
    - 22:00-07:00 (todo dia)
    - sun (domingo inteiro)

Por que Haiku?
  - Tarefa simples (checar listas, decidir prioridade, avisar)
  - Custo: ~$0.005 por execucao (vs $0.10 do Opus)
  - Economia: 95% no heartbeat

Cola aqui o output da configuracao.
```

### Passo 4 — Automacao 1: checagem emails+agenda

```
PASSO 4/5 — CRON CHECAGEM (4/4h)

Cola este PROMPT:

────────────────────────────────────────
Cria a automacao 1 — Checagem proativa:

  Schedule: 0 */4 * * * (a cada 4h)
  Modelo: Haiku
  Acao:
    1. Le inbox (5 emails mais recentes)
    2. Le agenda (proximas 24h)
    3. Decide:
       - Algo urgente? → avisa no Telegram
       - Nada urgente? → silencio (acumula resumo)

  Exemplo de avisos:
    - "Cliente X mandou email importante ha 2h"
    - "Reuniao em 1h: Y. Voce ja tem o material?"

Confirma quando criar.
────────────────────────────────────────
```

### Passo 5 — Automacao 2: organizacao memoria (noite)

```
PASSO 5/5 — CRON ORGANIZACAO MEMORIA

Cola este PROMPT:

────────────────────────────────────────
Cria a automacao 2 — Organizacao noturna:

  Schedule: 0 22 * * * (todo dia 22h)
  Modelo: Sonnet (precisa raciocinar)
  Acao (silenciosa, nunca interrompe):
    1. Le memory/sessions/HOJE.md
    2. Extrai:
       - Decisoes → append em memory/context/decisions.md
       - Licoes → append em memory/context/lessons.md
       - Pendencias novas → memory/pending.md
       - Updates de projetos → memory/projects/{nome}.md
    3. Salva resumo do dia em memory/sessions/HOJE-resumo.md
    4. Move HOJE.md → ONTEM.md
    5. Cria HOJE.md vazio pro dia seguinte

Confirma quando criar. Esse cron nunca te avisa, so trabalha.
────────────────────────────────────────
```

## Validacao

```
TESTE:

1. Espera 4h depois de configurar — voce deve receber heartbeat
   automatico (mesmo que silencioso, da pra ver o log).

2. As 22h, organizacao noturna roda. No dia seguinte, confere
   se memory/sessions/ONTEM.md tem o resumo do dia anterior.
```

## Atualizar state.json

```json
{
  "current_etapa": 7,
  "etapas_completas": [0..6],
  "proactivity": {
    "heartbeat_md": true,
    "silence_windows": true,
    "model_haiku": true,
    "cron_checagem": true,
    "cron_organizacao": true
  }
}
```

## Fechar

```
✓ Etapa 6 concluida

PROXIMA ETAPA: Etapa 7 — Sistema Imunologico (~30min)
```

## Origem
Curso M2 · Etapa 6 (Proatividade).
