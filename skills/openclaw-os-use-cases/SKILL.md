---
name: openclaw-os:use-cases
description: |
  Etapa 8 — 20+ casos de uso prontos. Mostra ao aluno o que ele pode fazer
  com o agente em 4 categorias: Produtividade pessoal, Negocio (CEO/COO),
  Conteudo (criadores), Pesquisa & Decisao. Lista pratica + exemplos de
  prompts. Pre-req: Etapa 7 OK. Tempo: ~20min.
---

# Etapa 8 — Casos de Uso

**Tempo:** 20 min
**Objetivo:** Aluno sabe O QUE pedir pro agente. Sai daqui com 20+ casos
prontos pra testar.

## Apresentacao

```
========================================
  ETAPA 8 — CASOS DE USO
========================================

Voce passou de paciente a profissional. Seu agente esta no ar, com
identidade, memoria, integracoes, proatividade e imunologico.

Agora a pergunta: O QUE PEDIR PRA ELE?

Vou te mostrar 4 categorias de uso, com 5 exemplos cada.
Voce escolhe 3 pra testar AGORA e ver o agente em acao.
```

## Os 4 grupos

### Grupo 1 — Produtividade pessoal

```
1. "Resume meus 10 emails mais recentes em 1 linha cada."
2. "O que tenho na agenda amanha? E qual o mais critico?"
3. "Cria um draft de email pra cliente X agradecendo a reuniao
    de hoje. Tom: profissional caloroso."
4. "Adiciona na minha pending.md: ligar pro contador na sexta."
5. "Me lembra todo dia as 18h de fechar o computador."
```

### Grupo 2 — Negocio (CEO/COO)

```
1. "Analisa minha receita do mes em comparacao com o mes passado.
    Pega numeros do meu Drive (planilha financeiro.xlsx)."
2. "Quais sao os 3 problemas mais frequentes que clientes
    reportaram nos ultimos 30 dias? Le memory/feedback/
    e meu Gmail."
3. "Cria proposta pra cliente X baseada no template em
    Drive/templates/proposta.md, customiza pra empresa dele
    (busca info da empresa na web)."
4. "Audita meu pipeline de vendas. Quantos negocios estao
    parados ha mais de 7 dias?"
5. "Me da um briefing pro board meeting de quinta. 5 bullets
    sobre numeros, problemas, oportunidades."
```

### Grupo 3 — Conteudo (criadores)

```
1. "Pega meu ultimo post no Instagram (analise web), e me da
    3 angulos novos pra um post amanha sobre o mesmo tema."
2. "Le esse PDF [anexa] e me da 5 ideias de carrossel."
3. "Cria roteiro de reels de 30s sobre [topico]. Tom: o do
    SOUL.md."
4. "Reescreve esse texto [cola] pra ficar 30% mais curto, mantem
    o ponto principal."
5. "Gera 10 hooks pra um video sobre [topico]. Estilo viral."
```

### Grupo 4 — Pesquisa & Decisao

```
1. "Pesquisa concorrentes do meu nicho que cobram entre R$ X e Y.
    Me da nomes, posicionamento e preco."
2. "Esse paper [anexa PDF] tem alguma evidencia que apoia minha
    tese de que [tese]? Cita pagina e trecho."
3. "Devo ou nao devo investir em [decisao]? Pega informacao da
    web, le minhas decisions.md (que decisoes parecidas eu ja
    tomei?), e me da 3 cenarios: pessimista, base, otimista."
4. "Compara [produto A] vs [produto B] vs [produto C] em 5
    criterios que importam pro meu uso."
5. "Le minhas notas em memory/projects/projeto-X.md e me diz:
    quais foram os 3 maiores aprendizados?"
```

## Teste pratico

```
ESCOLHA 3 CASOS PRA TESTAR AGORA:

Pega 3 dos 20 acima (idealmente 1 de cada grupo) e manda pro seu
agente no Telegram.

Pra cada um:
  1. Manda o prompt
  2. Le a resposta
  3. Avalia: 0-10 quao util foi
  4. Se nao gostou, refina:
     - "Refaz mais curto"
     - "Refaz com mais profundidade"
     - "Esquece, faz diferente: ..."

Cola aqui os 3 prompts que escolheu + nota que deu pra cada
resposta.
```

## Atualizar state.json

```json
{
  "current_etapa": 9,
  "etapas_completas": [0..8],
  "use_cases_tested": ["caso1", "caso2", "caso3"]
}
```

## Fechar

```
✓ Etapa 8 concluida

PROXIMA ETAPA: Etapa 9 — Backup (~25min)

Voce ja viu o que o agente faz. Agora vamos garantir que voce nao
perde NADA dele com versionamento via GitHub.
```

## Origem
Curso M2 · Etapa 8 (Use Cases).
