---
name: openclaw-os:ssh
description: |
  Etapa 11 — Bonus SSH com chave. Configura alias `vps` no ~/.ssh/config
  pro aluno conectar com 1 comando (em vez de digitar IP+senha sempre).
  Tambem migra de auth por senha pra auth por chave (mais seguro). Pre-req:
  Etapa 9 OK. Tempo: ~10min.
---

# Etapa 11 — SSH com Chave (Bonus)

**Tempo:** 10 min
**Objetivo:** `ssh vps` em vez de `ssh root@123.45.67.89` toda vez.

## Apresentacao

```
========================================
  ETAPA 11 — SSH COM CHAVE
========================================

Nao precisa decorar IP. Nao precisa digitar senha. Configura uma vez,
usa pra sempre:

    ssh vps

E voce esta dentro.

Tempo: 10min.
```

## Os passos

### Passo 1 — Gerar chave SSH no Mac (se ainda nao tem)

```
PASSO 1/4 — GERAR CHAVE SSH

No SEU computador (Mac, NAO na VPS):

    ls ~/.ssh/

Se ja tem `id_ed25519` ou `id_rsa`, pula pro Passo 2.

Se nao tem:

    ssh-keygen -t ed25519 -C "{seu-email}"

Aceita os defaults (Enter, Enter, Enter — sem passphrase pra ficar
mais facil).

Confirma "ok" quando terminar.
```

### Passo 2 — Copiar chave publica pra VPS

```
PASSO 2/4 — COPIAR CHAVE

No SEU computador:

    ssh-copy-id root@SEU_IP

(troca SEU_IP pelo IP da Hostinger)

Vai pedir a senha root UMA ULTIMA VEZ.

Quando terminar, testa:

    ssh root@SEU_IP

Se entrou SEM PEDIR SENHA → chave funcionando.

Sai do SSH (digita `exit`) e me diz "ok".
```

### Passo 3 — Criar alias `vps`

```
PASSO 3/4 — ALIAS

No SEU computador:

    nano ~/.ssh/config

Adiciona no final do arquivo (ou cria se nao existir):

    Host vps
        HostName SEU_IP
        User root
        IdentityFile ~/.ssh/id_ed25519

(troca SEU_IP pelo IP)

Salva (Ctrl+O, Enter, Ctrl+X).

Testa:

    ssh vps

Se entrou na VPS direto → alias funcionando!
```

### Passo 4 — Desabilitar auth por senha (opcional, mais seguro)

```
PASSO 4/4 — DESABILITAR SENHA (OPCIONAL)

⚠️ ATENCAO: Faz isso SO se o Passo 3 funcionou. Caso contrario,
voce fica sem acesso.

Conecta na VPS:

    ssh vps

Edita SSH config:

    nano /etc/ssh/sshd_config

Procura e altera:

    PasswordAuthentication yes  →  PasswordAuthentication no
    PermitRootLogin yes         →  PermitRootLogin prohibit-password

Salva e reinicia SSH:

    systemctl restart sshd

Sai e tenta de novo:

    ssh vps

Deve entrar normalmente (com a chave).

Pra ter certeza que senha foi bloqueada, tenta de outro terminal:

    ssh -o PreferredAuthentications=password root@SEU_IP

Deve falhar (Permission denied). Isso e BOM — significa que so quem
tem sua chave consegue entrar.
```

## Atualizar state.json

```json
{
  "current_etapa": 12,
  "etapas_completas": [0..11],
  "go_live": true,
  "go_live_at": "{timestamp}",
  "ssh": {
    "alias_vps_configured": true,
    "key_auth_only": true
  }
}
```

## Go-live final

```
========================================
  CLAW {NOME} ESTA COMPLETO ✓
========================================

Voce passou pelas 12 etapas oficiais do M2.

Daqui pra frente:
  - Use seu agente pelo Telegram diariamente
  - /openclaw-os:status         pra health check
  - /openclaw-os:troubleshoot   se algo der errado
  - /openclaw-os:use-cases      pra novos casos de uso

PARABENS! Voce construiu um agente AI pessoal de verdade. 🎉
```

## Origem
Curso M2 · Etapa 11 (SSH com chave).
