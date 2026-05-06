# AULA 03 — IDENTIDADE (DRAFT pra agente que monta HTML)

> Esse arquivo serve de input pro agente que constroi a aula em HTML.
> Combine com o conteudo original da aula (que ja existe) e a skill
> `/openclaw-os:identity` que automatiza o processo.

---

## Estrutura sugerida da aula

A aula da Etapa 3 (Identidade) tem 5 passos que ja existem:
1. USER.md
2. SOUL.md
3. AGENTS.md
4. IDENTITY.md
5. BOOT.md

A skill **nao substitui a aula**. Ela e uma ferramenta que **automatiza
o processo manual** que a aula descreve.

### Onde encaixar a skill na aula

**Logo no comeco da Etapa 3, depois da intro "Quem e voce, quem e ele",
antes do Passo 1**, adicionar uma **caixa-destaque** explicando os 2
caminhos:

> ## Como vamos fazer essa etapa
>
> Voce tem 2 caminhos pra construir os 5 arquivos. **Ambos chegam no
> mesmo lugar.**
>
> ### Caminho A — Manual (~2h)
> Voce le cada secao da aula, cola o prompt no Claude Code da VPS, ele
> te entrevista pergunta a pergunta, voce responde. No final ele gera
> os 5 arquivos diretamente em `~/openclaw/identity/` no VPS.
>
> Use esse caminho se: voce gosta de entender cada detalhe, tem 2h
> tranquilas e quer maximo controle.
>
> ### Caminho B — Skill assistida (~30min) **RECOMENDADO**
> Abre o Claude Code **no seu computador** (nao no VPS) e roda:
>
> ```
> /openclaw-os:identity
> ```
>
> A skill conduz voce em 7 etapas:
> 1. Pergunta se voce tem pasta com documentos seus/da empresa
>    (pitch deck, manifesto, posts, brand book) — se tiver, le tudo
>    pra enriquecer contexto
> 2. Te entrega 5 prompts pra colar em ChatGPT/Claude/Gemini que
>    ja te conhece (cada prompt gera 1 dos 5 arquivos)
> 3. Voce cola as respostas de volta na skill
> 4. A skill compila tudo + dados da pasta
> 5. Gera os 5 .md prontos em `~/openclaw-identity/` no seu computador
> 6. Te da um prompt final pra colar no Telegram junto com os 5 arquivos
>    anexados — o claw substitui no VPS, faz backup, da restart, audita
>    e responde com score
> 7. O claw faz uma pergunta polemica no final pra validar que o SOUL pegou
>
> Use esse caminho se: voce quer ir direto, ja tem ChatGPT que te conhece,
> e/ou tem documentos da sua empresa que podem acelerar a construcao.

### Onde a skill aparece de novo na aula

**No final da aula, no Checkpoint:**

> ### Checkpoint da Etapa 3
> [...checklist original...]
>
> **Atalho:** se voce usou o Caminho B (`/openclaw-os:identity`), o
> proprio claw fez a auditoria automatica via Telegram quando voce
> mandou os arquivos. Se passou com score 10/10, esta etapa esta
> validada.

---

## Conteudo da skill em detalhe (pra contextualizar a aula)

### O que a skill faz **diferente** da aula manual

| Aspecto | Aula manual (Caminho A) | Skill (Caminho B) |
|---|---|---|
| Onde roda | Claude Code da VPS (via SSH) | Claude Code do Mac do aluno |
| Tempo | ~2h | ~30min |
| Entrevista | Pergunta-por-pergunta no Claude Code | 5 prompts em batch no ChatGPT |
| Documentos da empresa | Aluno copia/cola manualmente | Skill le pasta inteira automaticamente |
| Onde os arquivos sao gerados | Direto no VPS | Mac local, depois envia pro VPS |
| Como vai pro VPS | Ja esta la | Aluno anexa no Telegram, claw substitui |
| Auditoria final | Aluno cola prompt e roda manualmente | Automatica no prompt do Telegram |

### O ponto-chave da skill

**A skill aproveita uma coisa que o aluno geralmente ja tem: um
ChatGPT/Claude que ja o conhece de meses de conversa.**

Em vez de comecar do zero entrevistando o aluno (Caminho A), a skill:
1. Pega o que o ChatGPT ja sabe sobre ele (5 prompts batch)
2. Enriquece com documentos da empresa (se houver)
3. Compila tudo localmente
4. Manda pronto pro claw via Telegram

Isso reduz 2h pra 30min sem perder qualidade — e na verdade GANHA
qualidade, porque os documentos da empresa entram no contexto.

---

## Sugestoes de UI/UX pra aula em HTML

### Caixa "2 caminhos"
Card lado a lado: Caminho A (manual) vs Caminho B (skill). Visual
parecido com a comparacao "SEM ALMA / COM ALMA" que ja existe na aula.

### Caminho B com timeline
Mostra os 7 steps da skill como timeline numerada:

```
01 → Pergunta se tem pasta com documentos
02 → Le os arquivos da pasta (se houver)
03 → 5 prompts pro ChatGPT (USER, SOUL, AGENTS, IDENTITY, BOOT)
04 → Compila tudo + contexto da pasta
05 → Gera 5 arquivos em ~/openclaw-identity/
06 → Voce manda pro Telegram com prompt
07 → Claw substitui no VPS, audita, valida
```

### Boxes de "tipos de documentos que servem"
Quando explicar a parte da pasta, listar exemplos visuais:

```
✓ Pitch deck                ✓ Manifesto / brand book
✓ Plano de negocios         ✓ Posts seus (Insta, LinkedIn)
✓ Transcricoes de podcasts  ✓ Plano estrategico
✓ Documentos da equipe      ✓ Sobre nos do site
```

### Comando destacado
Em algum lugar visivel da aula, destacar o comando da skill em monospace
grande:

```
/openclaw-os:identity
```

---

## Pre-requisitos da skill (mencionar na aula)

- Aluno completou Phase 4 (claw rodando no Telegram)
- Aluno esta no **computador local** (Mac), nao via SSH no VPS
- Aluno tem **uma IA que ja o conhece** (ChatGPT Plus com memoria, Claude
  Pro com Projects, ou Gemini com contexto longo)
- Opcional mas recomendado: pasta com 3+ documentos sobre ele/empresa

---

## O que a skill NAO faz (deixar claro na aula)

- Nao roda no VPS — aluno nao precisa abrir SSH
- Nao instala nada — so cria 5 arquivos .md locais
- Nao envia automaticamente pro claw — aluno precisa abrir Telegram e
  anexar os arquivos manualmente (com prompt fornecido pela skill)
- Nao funciona sem um claw ja no ar (Phase 4 obrigatoria antes)

---

## Bonus: como o claw recebe e instala

Quando o aluno cola o prompt + anexa os 5 arquivos no Telegram, o claw
faz internamente:

```bash
# 1. Backup dos atuais
cp -r ~/openclaw/identity ~/openclaw/identity-backup-$(date +%s)

# 2. Substitui pelos novos
cp /tmp/uploads/USER.md     ~/openclaw/identity/
cp /tmp/uploads/SOUL.md     ~/openclaw/identity/
cp /tmp/uploads/AGENTS.md   ~/openclaw/identity/
cp /tmp/uploads/IDENTITY.md ~/openclaw/identity/
cp /tmp/uploads/BOOT.md     ~/openclaw/identity/

# 3. Restart pra carregar
systemctl restart openclaw

# 4. Audita
# (le cada arquivo, valida criterios, gera score)

# 5. Responde com score 0-10 e pergunta polemica
```

Tudo isso o claw faz sozinho a partir do prompt que a skill entrega.
