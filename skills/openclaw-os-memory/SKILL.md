---
name: openclaw-os:memory
description: |
  Etapa 4 — Sistema de memoria persistente em camadas. Resolve o "Alzheimer
  entre sessoes": agente lembra de decisoes, licoes, projetos, pendencias.
  Cria estrutura memory/ no VPS, MEMORY.md como indice geral, sessions/ pra
  diario, context/ pra decisoes/licoes/people, projects/ pra um arquivo por
  projeto. Configura memory_search() e feedback loops. Pre-req: Etapa 3 OK.
  Tempo: ~40min.
---

# Etapa 4 — Memoria

**Tempo:** 40 min
**Objetivo:** Agente nao esquece nada entre sessoes.

## Pre-checks

- state.json: `etapas_completas` contem [0, 1, 2, 3]
- Identidade ja construida (5 arquivos USER/SOUL/AGENTS/IDENTITY/BOOT no VPS)

## Apresentacao

```
========================================
  ETAPA 4 — MEMORIA
========================================

Sem memoria, todo dia voce comeca do zero. Conta tudo de novo. O agente
esquece a decisao que voces tomaram ontem.

Vamos resolver isso com memoria em CAMADAS:

  CARREGADO SEMPRE (pequeno, sempre no contexto):
    memory/MEMORY.md           — indice geral
    memory/sessions/HOJE.md    — diario do dia
    memory/sessions/ONTEM.md   — diario de ontem

  BUSCADO SOB DEMANDA (grande, busca quando precisa):
    memory/context/decisions.md      — regras permanentes
    memory/context/lessons.md        — erros que nao podem repetir
    memory/context/people.md         — pessoas e contexto
    memory/projects/{nome}.md        — um arquivo por projeto
    memory/pending.md                — aguardando seu input

Tempo: ~40min. Pronto?
```

## Os 5 passos

### Passo 1 — Criar estrutura

```
PASSO 1/5 — ESTRUTURA DE PASTAS

No Terminal 2 (SSH na VPS), cola:

    cd /agent
    mkdir -p memory/{context,projects,sessions,integrations,feedback}
    touch memory/MEMORY.md memory/pending.md
    touch memory/context/{decisions,lessons,people,business-context}.md
    tree memory/ -L 2

Cola aqui o output do `tree`.
```

Validacao: estrutura tem pastas `context/`, `projects/`, `sessions/`,
`integrations/`, `feedback/` e arquivos base.

### Passo 2 — Configurar carregamento no boot

```
PASSO 2/5 — BOOT COM MEMORIA

Cola este PROMPT no chat com seu agente no Telegram:

────────────────────────────────────────
Atualiza meu BOOT.md pra incluir memoria. Adiciona estes passos:

  1. Le memory/MEMORY.md (indice geral)
  2. Le memory/sessions/HOJE.md (se existir)
  3. Le memory/sessions/ONTEM.md (se existir)
  4. Checa memory/pending.md (algo aguardando minha decisao)

Apos atualizar, me confirma que o BOOT agora carrega memoria toda
vez que voce abre uma sessao nova.
────────────────────────────────────────

Quando ele confirmar, me diz "ok".
```

### Passo 3 — Definir busca sob demanda

```
PASSO 3/5 — MEMORY_SEARCH E MEMORY_GET

Cola este PROMPT no Telegram:

────────────────────────────────────────
Configura duas funcoes de memoria pra mim:

  memory_search(termo) — busca em memory/context/, memory/projects/
                         e memory/sessions/ por palavra-chave
  memory_get(arquivo)  — le um arquivo especifico de memoria

Use isto quando eu te perguntar algo do passado. Em vez de chutar,
voce busca primeiro.

Me confirma que esta configurado.
────────────────────────────────────────
```

### Passo 4 — Regra inviolavel: extrair antes de compactar

```
PASSO 4/5 — EXTRAIR ANTES DE COMPACTAR

Cola este PROMPT (CRITICO):

────────────────────────────────────────
Cria uma regra inviolavel no AGENTS.md:

REGRA: Antes de compactar qualquer sessao ou conversa, extrai e salva:
  - Decisoes tomadas → memory/context/decisions.md
  - Licoes aprendidas (erros, surpresas) → memory/context/lessons.md
  - Projetos discutidos → memory/projects/{nome}.md
  - Pendencias (aguardando minha decisao) → memory/pending.md

Compactar SEM extrair = perder informacao = falha grave.

Me confirma que adicionou no AGENTS.md.
────────────────────────────────────────
```

### Passo 5 — Teste real

```
PASSO 5/5 — TESTE DE MEMORIA

1. No Telegram, manda pro seu agente:
   "Anota: cor preferida do meu cliente e azul-marinho.
    Salva em decisions.md."

2. Espera ele confirmar "salvo".

3. Fecha completamente o chat (sai do Telegram, abre de novo).

4. Manda:
   "Qual a cor preferida do meu cliente?"

5. Ele DEVE responder "azul-marinho" sem voce precisar repetir.

Se respondeu correto → memoria OK.
Se nao lembrou → algo falhou no boot ou no memory_search.

Cola aqui a resposta dele.
```

## Atualizar state.json

```json
{
  "current_etapa": 5,
  "etapas_completas": [0, 1, 2, 3, 4],
  "memory": {
    "structure_created": true,
    "boot_updated": true,
    "memory_search_configured": true,
    "extraction_rule_active": true,
    "test_passed": true
  }
}
```

## Fechar etapa

```
✓ Etapa 4 concluida

Seu agente agora tem memoria persistente:
  ✓ Estrutura memory/ em camadas
  ✓ MEMORY.md como indice geral
  ✓ sessions/ pra diario
  ✓ context/ pra decisoes/licoes/people
  ✓ projects/ pra projetos
  ✓ pending.md pra aguardando
  ✓ Boot atualizado pra carregar memoria
  ✓ memory_search() e memory_get() configurados
  ✓ Regra: extrair antes de compactar
  ✓ Teste passou

PROXIMA ETAPA: Etapa 5 — Integracoes (~30min)

Volta ao /openclaw-os:setup e diz "ok" pra liberar.
```

## Veto conditions

- Estrutura nao criou → diagnostica permissoes
- Teste de memoria falhou → boot nao atualizou direito
- Aluno quer pular → BLOCK. Sem memoria, agente vira chatbot sem alma.

## Origem

Curso M2 · Etapa 4 (Memoria).
Squad openclaw-creator/agents/identity-builder.md (4-layer memory system).
