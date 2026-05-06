---
name: openclaw-os:phase-1
description: |
  Phase 1 do pipeline OpenClaw OS — Memory Extraction. Usa ChatGPT (ou Gemini/Claude)
  pra extrair perfil completo do aluno em ~10 minutos. Gera USER.md preenchido.
  Atualiza state.json com memory_extracted=true. Pre-req: state.json existe.
---

# Phase 1 — Memory Extraction

**Tempo:** 10 min
**Objetivo:** Extrair 80% do perfil do aluno via prompt no ChatGPT, gerar `USER.md`.

## Pre-checks

1. Le `~/.openclaw/{claw-slug}/state.json`. Se nao existe, oriente: "Rode /openclaw-os:start primeiro."
2. Verifica `current_phase >= 1`.

## Fluxo

### Step 1: Apresentar a fase

```
========================================
  PHASE 1 — MEMORY EXTRACTION
========================================

Vamos extrair seu perfil em ~10 min usando ChatGPT.

Por que? Seu claw precisa saber QUEM voce e (valores, contexto, jeito de
comunicar) pra te atender bem. Em vez de perguntar 200 coisas pra voce,
extraimos do ChatGPT que ja te conhece.

Pronto?
```

### Step 2: Gerar prompt customizado

Le `~/coreaios/openclaw-os/templates/memory-extraction-prompt.md`. Esse arquivo tem o prompt completo de extracao.

Mostre pro aluno **dentro de um code block** com instrucao clara:

```
Copie este prompt INTEIRO e cole no ChatGPT:

[bloco de codigo com o prompt completo]

Quando ChatGPT responder, copie a resposta INTEIRA e cole aqui.
```

### Step 3: Aguardar resposta do aluno

Aluno cola a resposta do ChatGPT (markdown longo com perfil estruturado).

### Step 4: Salvar como USER.md

```bash
mkdir -p ~/.openclaw/{claw-slug}/identity
cat > ~/.openclaw/{claw-slug}/identity/USER.md << 'EOF'
{conteudo colado pelo aluno}
EOF
```

### Step 5: Validar

Cheque se o markdown tem as secoes minimas:
- Identidade basica (nome, idade, cidade)
- Trabalho/Negocio
- Valores e principios
- Estilo de comunicacao
- Contexto pessoal

Se faltar mais de 2 secoes, oriente: "ChatGPT nao gerou perfil completo. Quer rodar de novo ou seguir mesmo assim?"

### Step 6: Atualizar state.json

```json
{
  "current_phase": 2,
  "phases_completed": [1],
  "memory_extracted": true,
  "user_md_path": "~/.openclaw/{claw-slug}/identity/USER.md"
}
```

### Step 7: Fechar

```
Phase 1 concluida ✓

USER.md salvo em ~/.openclaw/{claw-slug}/identity/USER.md
({N} secoes, {linhas} linhas)

Volte ao /openclaw-os:start e me diga "ok" pra avancar pra Phase 2.
```

## Veto conditions

- USER.md vazio → repetir extracao
- Aluno colou texto curto (<500 chars) → suspeita, perguntar se ChatGPT respondeu completo

## Origem

Baseado em `legacy/squads/openclaw-manager/tasks/memory-extraction.md` e prompt em `~/coreaios/openclaw-os/templates/memory-extraction-prompt.md`.
