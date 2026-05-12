# Documentacao da animacao 1: expansao do campo de descricao

## Onde acontece no projeto

- Origem: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:116)
- Gatilho: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:138)

## Objetivo

Essa animacao abre e fecha a area de descricao no formulario de `AddTask`.
O efeito visual acontece pela mudanca gradual da altura de um `AnimatedContainer`.

## Tipo de animacao

- Widget usado: `AnimatedContainer`
- Propriedade animada: `height`
- Duracao atual: `300ms`
- Direcao:
  - abre quando a altura vai de `0` para `60`
  - fecha quando a altura vai de `60` para `0`

## Estado que controla a animacao

No `AddTask`, a animacao depende de dois valores:

```dart
var isContainerOpen = false;
var containerHeight = 0.0;
```

Cada um tem um papel diferente:

- `isContainerOpen`: representa a intencao de aberto/fechado
- `containerHeight`: representa o valor visual que o `AnimatedContainer` vai animar

## Implementacao atual

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 300),
  height: containerHeight,
  child: Visibility(
    visible: containerHeight != 0,
    child: TextField(
      controller: descriptionController,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: "Adicionar informacoes",
      ),
    ),
  ),
)
```

## Como o gatilho funciona

Quando o usuario toca no icone:

```dart
onTap: () {
  isContainerOpen = !isContainerOpen;

  setState(() {
    if (isContainerOpen) {
      containerHeight = 60;
    } else {
      containerHeight = 0;
    }
  });
}
```

O ponto central e este: o Flutter compara a altura antiga com a nova altura e faz a transicao automaticamente.

## Modelo para reaproveitar

Use esse padrao quando voce quiser abrir ou recolher:

- campos extras
- filtros
- secoes avancadas
- detalhes opcionais

### Estrutura minima

```dart
class ExampleWidgetState extends State<ExampleWidget> {
  var isOpen = false;
  var expandedHeight = 0.0;

  void toggleArea() {
    setState(() {
      isOpen = !isOpen;
      expandedHeight = isOpen ? 60 : 0;
    });
  }
}
```

```dart
GestureDetector(
  onTap: toggleArea,
  child: const Icon(Icons.add),
)

AnimatedContainer(
  duration: const Duration(milliseconds: 300),
  height: expandedHeight,
  child: Visibility(
    visible: expandedHeight > 0,
    child: const Placeholder(),
  ),
)
```

## Quando usar esse modelo

Use quando o conteudo:

- ocupa pouco espaco
- pode aparecer dentro da mesma tela
- nao precisa de animacao manual com controller

Se voce so quer animar tamanho, `AnimatedContainer` costuma ser a opcao mais simples.

## Ajustes comuns

- Para abrir mais alto: troque `60` por outro valor
- Para ficar mais lento: aumente a `duration`
- Para suavizar o efeito: adicione `curve`, por exemplo `Curves.easeInOut`

Exemplo:

```dart
AnimatedContainer(
  duration: const Duration(milliseconds: 400),
  curve: Curves.easeInOut,
  height: expandedHeight,
  child: child,
)
```

## Cuidados

- Se a altura for `0`, o conteudo continua existindo na arvore. O `Visibility` ajuda a esconder visualmente o campo.
- Se o conteudo tiver altura variavel, pode valer mais usar `AnimatedSize`.
- Se a area aberta puder ultrapassar o espaco disponivel, teste com teclado e telas menores.

## Resumo rapido

Esse padrao resolve animacao de abrir/fechar alterando uma propriedade visual simples.
No `AddTask`, ele foi aplicado para expandir a descricao sem precisar de `AnimationController`.
