---
name: openclaw-os:backup
description: |
  Etapa 9 — Backup automatico via GitHub. Cria repo privado pro agente,
  conecta /agent ao remote, configura git push diario (cron 23h da Etapa 7),
  testa restore (clone num lugar diferente, valida que tudo voltou). Pre-req:
  Etapa 8 OK + conta GitHub. Tempo: ~25min.
---

# Etapa 9 — Backup

**Tempo:** 25 min
**Objetivo:** Agente versionado no GitHub. Se a VPS cair, voce restaura
em 5min em outra VPS.

## Apresentacao

```
========================================
  ETAPA 9 — BACKUP via GITHUB
========================================

Vamos criar um repo PRIVADO no GitHub e versionar /agent inteiro.

Beneficios:
  - Backup automatico todo dia 23h (cron ja configurado na Etapa 7)
  - Historico completo (vc ve o que mudou em cada dia)
  - Restore facil (clone em outra VPS = agente de volta em 5min)
  - Privacidade (repo privado, so voce ve)

Tempo: ~25min. Pronto?
```

## Os passos

### Passo 1 — Criar repo privado no GitHub

```
PASSO 1/5 — CRIAR REPO

1. Vai em github.com (logado)
2. Click no "+" no topo direito → New repository
3. Nome: claw-{seu-nome}-backup (ex: claw-alfred-backup)
4. Descricao: "Backup automatico do meu agente OpenClaw"
5. Privacy: PRIVATE (importante!)
6. NAO inicializa com README
7. Click "Create repository"

GitHub mostra a tela com a URL do repo. Algo tipo:
  https://github.com/{seu-user}/claw-{seu-nome}-backup.git

Cola aqui essa URL.
```

### Passo 2 — Configurar SSH key na VPS

```
PASSO 2/5 — SSH KEY DA VPS PRO GITHUB

No Terminal 2 (SSH na VPS):

    ssh-keygen -t ed25519 -C "vps-{seu-nome}@openclaw"

Aceita os defaults (Enter, Enter, Enter — sem senha pro key).

Mostra a chave publica:

    cat ~/.ssh/id_ed25519.pub

Copia o output INTEIRO (comeca com `ssh-ed25519 AAA...`).

Vai em github.com → Settings (canto sup direito do seu avatar) →
SSH and GPG keys → New SSH key:
  Title: VPS-{seu-nome}-openclaw
  Key: cola a chave que voce copiou

Click "Add SSH key" e me diz "ok".
```

### Passo 3 — Conectar /agent ao remote

```
PASSO 3/5 — git remote

No Terminal 2:

    cd /agent
    git init                                    # se ainda nao iniciou
    git add -A
    git commit -m "initial commit"
    git remote add origin git@github.com:{seu-user}/claw-{seu-nome}-backup.git
    git branch -M main
    git push -u origin main

Se pedir confirmacao de host (yes/no), digita "yes".

Quando o push terminar, me diz "pushed".
```

### Passo 4 — Validar cron de backup

```
PASSO 4/5 — VALIDAR BACKUP AUTOMATICO

O cron de backup ja foi configurado na Etapa 7 (Imunologico).
Vamos forcar uma rodada agora pra testar:

No Terminal 2:

    cd /agent
    git add -A && git commit -m "test backup" && git push

Volta no GitHub e abre o repo. Voce deve ver os arquivos do agente
(memory/, identity/, openclaw.json, etc).

Cola aqui um print ou descreve o que voce ve.
```

### Passo 5 — Teste de restore (opcional mas recomendado)

```
PASSO 5/5 — TESTE DE RESTORE

Pra ter certeza que o backup funciona, faz um teste de restore:

No SEU computador (NAO na VPS), abre um terminal:

    cd /tmp
    git clone git@github.com:{seu-user}/claw-{seu-nome}-backup.git
    cd claw-{seu-nome}-backup
    ls -la

Se voce ve memory/, identity/, openclaw.json — restore OK.

Apaga depois pra nao ficar lixo:

    cd ..
    rm -rf claw-{seu-nome}-backup

Confirma "restore ok" pra fechar.
```

## Atualizar state.json

```json
{
  "current_etapa": 10,
  "etapas_completas": [0..9],
  "backup": {
    "github_repo": "git@github.com:{user}/claw-{nome}-backup.git",
    "ssh_key_configured": true,
    "first_push": true,
    "restore_tested": true
  }
}
```

## Fechar

```
✓ Etapa 9 concluida

Seu agente agora tem:
  ✓ Backup diario automatico (cron 23h)
  ✓ Historico completo no GitHub (privado)
  ✓ Restore validado

Se a VPS pegar fogo, voce levanta o agente em outra VPS em 5min.

PROXIMA ETAPA: Etapa 10 — Resolvendo Problemas (uso ad-hoc)
```

## Origem
Curso M2 · Etapa 9 (Backup).
