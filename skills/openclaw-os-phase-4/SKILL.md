---
name: openclaw-os:phase-4
description: |
  Phase 4 — Conectar Telegram + Seguranca + Primeiro Teste. Guia o aluno a
  criar bot no @BotFather, conectar ao OpenClaw via 'openclaw provider add
  telegram', configurar dmPolicy allowlist (CRITICO), e mandar primeira
  mensagem. Pre-req: phase 3 OK (OpenClaw rodando).
---

# Phase 4 — Telegram + Seguranca + Primeiro Teste

**Tempo:** 15 min
**Objetivo:** Bot Telegram conectado, allowlist seguro, primeira conversa funcionando.

## IMPORTANTE

Voce **continua sendo o instrutor**. O aluno tem 2 terminais abertos:
- Terminal 1: Claude Code (este, te guiando)
- Terminal 2: SSH no VPS (de Phase 3)

Voce vai guia-lo a executar comandos `openclaw` no Terminal 2.

## Pre-checks

- state.json: `phases_completed` contem [1, 2, 3]
- `openclaw gateway status` retornou `running` na Phase 3

## Fluxo

### Step 1: Apresentar a fase

```
========================================
  PHASE 4 — TELEGRAM + SEGURANCA
========================================

Agora vamos:
  1. Criar um bot no Telegram (via @BotFather)
  2. Conectar o bot ao OpenClaw (1 comando no VPS)
  3. CONFIGURAR ALLOWLIST (critico — sem isso qualquer pessoa pode falar
     com seu bot)
  4. Mandar primeira mensagem e validar que funciona

Tempo: ~15 min. Pronto?
```

Aguarde "ok".

### Step 2: Criar bot no Telegram

```
PASSO 5 de 8 — CRIAR BOT NO TELEGRAM

1. Abre o Telegram (celular ou desktop)
2. Busca @BotFather (e o bot oficial do Telegram pra criar bots)
3. Manda pra ele: /newbot
4. BotFather pergunta o NOME do bot. Coloca o que voce quiser:
     ex: "Meu Agente AI" (pode ter espacos e maiusculas)
5. BotFather pergunta o USERNAME. Tem que terminar em "bot":
     ex: "meu_agente_ai_bot"  ou  "{seu_nome}_bot"
6. BotFather te manda um TOKEN (formato: 123456:ABC-defgh...)

COPIA esse token e me diz "tenho o token".
```

Aguarde "tenho o token". Peca pro aluno colar o token (ele tem que ser secreto, mas a gente precisa dele pro proximo passo).

### Step 3: Conectar Telegram ao OpenClaw

```
PASSO 6 de 8 — CONECTAR AO OPENCLAW

No Terminal 2 (SSH no VPS), cola este comando:

    openclaw provider add telegram

O OpenClaw vai te pedir o token do bot. Cola o token que o BotFather te deu.

Quando o OpenClaw confirmar "Telegram provider added" (ou similar),
me diz "conectou".
```

Aguarde "conectou".

### Step 4: Primeira mensagem (descobrir chat_id)

```
PASSO 6b — DISPARAR /start NO BOT

Agora abre o Telegram, procura pelo seu bot (pelo username ex
@meu_agente_ai_bot), abre o chat com ele e manda:

    /start

Isso faz duas coisas:
  - Inicia a conversa (Telegram exige isso pra o bot poder responder)
  - Registra seu chat_id no OpenClaw automaticamente

O bot DEVE responder algo como "Hello! I'm online" ou similar.

Me diz se ele respondeu ou nao.
```

Se o bot **respondeu** → ✅ avanca
Se **nao respondeu** em 30s → 🔴 troubleshooting:
- Volta no Terminal 2 e roda `openclaw gateway status` — ainda `running`?
- Roda `journalctl -u openclaw -n 30` pra ver logs

### Step 5: SEGURANCA CRITICA — Allowlist

```
========================================
  🔴 PASSO 7 de 8 — SEGURANCA CRITICA
========================================

ATENCAO: ANTES DE QUALQUER OUTRA COISA, voce PRECISA configurar o
allowlist. Sem isso, QUALQUER pessoa que descobrir o username do seu
bot pode mandar mensagens e gastar sua API key.

No Terminal 2 (VPS), cola:

    cat ~/.openclaw/openclaw.json

Procura no arquivo a chave `dmPolicy`. Tem que estar:

    "dmPolicy": "allowlist"

E na lista de IDs autorizados, deve ter SO o seu chat_id (descoberto no
PASSO 6b quando voce mandou /start).

Se estiver `"dmPolicy": "open"` (qualquer um pode falar), TROCA pra
allowlist. Pra editar:

    nano ~/.openclaw/openclaw.json

Salva (Ctrl+O, Enter, Ctrl+X), depois reinicia OpenClaw:

    systemctl restart openclaw

Quando estiver com dmPolicy=allowlist e SO seu chat_id autorizado,
me diz "allowlist ok".
```

Aguarde "allowlist ok". Nao avance sem isso.

### Step 6: Primeiro teste real

```
PASSO 8 de 8 — PRIMEIRO TESTE 🎉

Volta no Telegram, no chat com seu bot, e manda:

    Oi! Me diz quem voce e e o que pode fazer.

Ele deve responder em ate 5 segundos com algo coerente.

Cola aqui o que ele te respondeu pra eu ver se ta tudo OK.
```

Aguarde resposta do aluno colando o output.

Validacao:
- Resposta coerente em portugues, mencionando ser AI/agente → ✅ go-live parcial
- Resposta vazia/erro → 🔴 troubleshooting (logs, API key, dmPolicy)
- Resposta em ingles → ✅ funciona, mas oriente o aluno: "Pra resposta em pt-BR consistente, vamos ajustar a identidade na proxima fase"

### Step 7: Atualizar state.json

```json
{
  "current_phase": 5,
  "phases_completed": [1, 2, 3, 4],
  "telegram": {
    "bot_username": "{username}",
    "chat_id": "{chat_id_do_aluno}",
    "dm_policy": "allowlist",
    "first_test_ok": true
  }
}
```

### Step 8: Fechar fase

```
========================================
  PHASE 4 CONCLUIDA ✓
========================================

Seu bot esta no ar:

  ✓ Bot criado no Telegram (@{username})
  ✓ Conectado ao OpenClaw
  ✓ Allowlist ativa (so VOCE pode falar)
  ✓ Primeira mensagem respondida

CLAW ESTA VIVO E CONVERSANDO! 🎉

Proxima fase: Phase 5 — Personalizar Identidade do claw
(ensinar quem ele e, valores, tom de voz)

Volte ao /openclaw-os:start e diz "ok" pra avancar.
```

## Veto conditions

- Bot nao responde apos /start → PARA. Diagnostica antes.
- dmPolicy = "open" e aluno nao quer mudar → PARA. Esta inseguro.
- Resposta vazia/erro 401 da OpenAI → API key sem credito ou invalida.

## Origem

Passos 5-8 da documentacao oficial OpenClaw:
<https://docs.openclaw.ai/pt-BR/install>

Esta fase apenas guia o aluno a seguir o procedimento oficial.
