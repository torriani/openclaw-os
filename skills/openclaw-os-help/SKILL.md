---
name: openclaw-os:help
description: |
  Lista detalhada dos 16 comandos da skill OpenClaw OS, com tempo estimado,
  pre-requisitos, e quando usar cada um. Util quando esquecer qual etapa
  rodar a seguir.
---

# OpenClaw OS — Help

Mostra exatamente isto:

```
========================================
  OPENCLAW OS — COMANDOS DISPONIVEIS
========================================

PARA COMECAR

  /openclaw-os:setup
  → Orquestrador-mor. Conduz as 12 etapas em ordem (~5h total).
    USE ISTO. Nao precisa decorar mais nenhum comando.

ETAPAS DO CURSO M2 (ordem oficial)

  /openclaw-os:abertura       Abertura · 18min
  /openclaw-os:install        Etapa 1: Setup · 55min
  /openclaw-os:security       Etapa 2: Seguranca · 25min
  /openclaw-os:identity       Etapa 3: Identidade · 30min
  /openclaw-os:memory         Etapa 4: Memoria · 40min
  /openclaw-os:integrations   Etapa 5: Integracoes · 30min
  /openclaw-os:proactivity    Etapa 6: Proatividade · 25min
  /openclaw-os:immune         Etapa 7: Imunologico · 30min
  /openclaw-os:use-cases      Etapa 8: Casos de uso · 20min
  /openclaw-os:backup         Etapa 9: Backup GitHub · 25min
  /openclaw-os:troubleshoot   Etapa 10: Problemas · ad-hoc
  /openclaw-os:ssh            Etapa 11: SSH com chave · 10min

OPERACAO DIA A DIA

  /openclaw-os:resume         Retomar de onde parou
  /openclaw-os:status         Health check rapido
  /openclaw-os:help           Esta ajuda

PRE-REQUISITOS

  - ChatGPT Plus (~$20/mes)
  - Telegram instalado
  - VPS Hostinger KVM 2, Ubuntu 24.04 (~R$ 49/mes)

CUSTOS MENSAIS

  VPS Hostinger:  R$ 49/mes
  ChatGPT Plus:   ~R$ 100/mes
  Total:          ~R$ 150/mes

REPO PUBLICO

  https://github.com/torriani/openclaw-os

DUVIDAS COMUNS

  Q: Quanto tempo total?
  A: ~5h. Pode parar e retomar com /openclaw-os:resume.

  Q: Posso pular etapa?
  A: Nao. Cada etapa e gate da proxima.

  Q: Onde fica meu state.json?
  A: ~/.openclaw/{claw-slug}/state.json

  Q: Esqueci qual etapa estava?
  A: Roda /openclaw-os:resume — le o state.json e mostra.
```
