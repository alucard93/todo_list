# Documentacao da animacao 2: transicao do icone menu_close

## Onde acontece no projeto

- Controller: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:42)
- Tween: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:47)
- Widget animado: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:134)
- Gatilho: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:138)

## Objetivo

Essa animacao transforma o icone de menu em icone de fechar e faz o caminho inverso quando a area de descricao e recolhida.

## Tipo de animacao

- Widget usado: `AnimatedIcon`
- Icone usado: `AnimatedIcons.menu_close`
- Controle manual: `AnimationController`
- Duracao atual: `300ms`

## Estado e objetos necessarios

No `AddTask`, a animacao depende destes campos:

```dart
late AnimationController iconAnimationController;
late Animation<double> iconAnimation;
```

E o widget usa:

```dart
class _AddTaskState extends State<AddTask>
    with SingleTickerProviderStateMixin
```

O `SingleTickerProviderStateMixin` existe para fornecer o `vsync` do controller.

## Implementacao atual

### 1. Criacao do controller

```dart
iconAnimationController = AnimationController(
  vsync: this,
  duration: Duration(milliseconds: 300),
);
```

### 2. Criacao da animacao

```dart
iconAnimation = Tween(
  begin: 0.0,
  end: 1.0,
).animate(iconAnimationController);
```

### 3. Uso no widget

```dart
AnimatedIcon(
  icon: AnimatedIcons.menu_close,
  progress: iconAnimation,
)
```

### 4. Gatilho

```dart
if (isContainerOpen) {
  iconAnimationController.forward();
} else {
  iconAnimationController.reverse();
}
```

## Como essa animacao funciona

O `AnimatedIcon` nao decide sozinho quando deve mudar.
Quem manda nele e o `AnimationController`:

- `forward()`: vai de `0.0` para `1.0`
- `reverse()`: volta de `1.0` para `0.0`

No `AddTask`, isso deixa o icone sincronizado com a abertura e o fechamento do campo de descricao.

## Modelo para reaproveitar

Use esse padrao quando voce precisar de um icone que reflita um estado visual:

- abrir/fechar
- menu/cancelar
- play/pause
- lista/remover

### Estrutura minima

```dart
class ExampleWidgetState extends State<ExampleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  late Animation<double> iconProgress;
  var isOpen = false;

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    iconProgress = Tween(begin: 0.0, end: 1.0).animate(iconController);
  }

  @override
  void dispose() {
    iconController.dispose();
    super.dispose();
  }

  void toggleIcon() {
    setState(() {
      isOpen = !isOpen;
      if (isOpen) {
        iconController.forward();
      } else {
        iconController.reverse();
      }
    });
  }
}
```

```dart
GestureDetector(
  onTap: toggleIcon,
  child: AnimatedIcon(
    icon: AnimatedIcons.menu_close,
    progress: iconProgress,
  ),
)
```

## Quando usar esse modelo

Esse modelo vale a pena quando:

- o icone precisa comunicar mudanca de estado
- o efeito precisa ser controlado manualmente
- voce quer sincronizar o icone com outra animacao da tela

Se a animacao for isolada e simples, widgets implicitos podem bastar. Aqui o controller faz sentido porque o icone precisa acompanhar o restante da interacao.

## Ajustes comuns

- Para trocar o efeito: mude `AnimatedIcons.menu_close` para outro par disponivel
- Para acelerar ou desacelerar: altere a `duration`
- Para aplicar curva: use `CurvedAnimation`

Exemplo com curva:

```dart
iconProgress = CurvedAnimation(
  parent: iconController,
  curve: Curves.easeInOut,
);
```

## Cuidados

- Sempre descarte o controller em `dispose()`
- O mixin precisa combinar com a quantidade de controllers. Para um controller, `SingleTickerProviderStateMixin` e suficiente.
- Se o estado inicial ja deveria aparecer aberto, sincronize o valor booleano e o valor do controller logo no `initState`

## Resumo rapido

Esse padrao resolve animacao de icone orientada por estado.
No `AddTask`, ele foi usado para comunicar visualmente que a area opcional pode abrir e depois fechar.
