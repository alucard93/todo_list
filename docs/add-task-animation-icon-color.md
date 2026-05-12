# Documentacao da animacao 4: mudanca de cor do icone animado

## Onde acontece no projeto

- `ColorTween`: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:53)
- `AnimatedIcon`: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:148)
- Gatilho: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:153)

## Objetivo

Essa animacao altera a cor do `AnimatedIcon` ao mesmo tempo em que o icone faz a transicao de `menu` para `close`.

## Tipo de animacao

- Widget visual: `AnimatedIcon`
- Propriedade animada: `color`
- Fonte da cor: `Animation<Color?>`
- Controle manual: `AnimationController`
- Duracao atual: `300ms`
- Transicao atual: `Colors.red` para `Colors.green`

## Estado e objetos envolvidos

A animacao usa os mesmos objetos-base do fluxo principal:

```dart
late AnimationController iconAnimationController;
late Animation<Color?> colorAnimation;
late Animation<double> iconAnimation;
```

Aqui existe uma sincronizacao importante:

- `iconAnimation` controla a forma do icone
- `colorAnimation` controla a cor do icone
- os dois dependem do mesmo controller

## Implementacao atual

### 1. Criacao da animacao de cor

```dart
colorAnimation = ColorTween(
  begin: Colors.red,
  end: Colors.green,
).animate(iconAnimationController);
```

### 2. Aplicacao no `AnimatedIcon`

```dart
AnimatedIcon(
  color: colorAnimation.value,
  icon: AnimatedIcons.menu_close,
  progress: iconAnimation,
)
```

### 3. Gatilho

```dart
if (isContainerOpen) {
  iconAnimationController.forward();
} else {
  iconAnimationController.reverse();
}
```

## Como essa animacao funciona

O icone recebe dois sinais ao mesmo tempo:

- `progress`: muda o desenho do icone
- `color`: muda a cor do icone

Como os dois saem do mesmo controller, a mudanca visual fica coerente. O icone nao so abre ou fecha; ele tambem muda de cor no mesmo ritmo.

## Modelo para reaproveitar

Use esse padrao quando voce quiser um icone que:

- mude de forma
- mude de cor
- reforce visualmente um estado ativo/inativo

### Estrutura minima

```dart
class ExampleWidgetState extends State<ExampleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> iconProgress;
  late Animation<Color?> iconColor;
  var isActive = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    iconProgress = Tween(begin: 0.0, end: 1.0).animate(controller);
    iconColor = ColorTween(
      begin: Colors.grey,
      end: Colors.blue,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleIcon() {
    setState(() {
      isActive = !isActive;
      if (isActive) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }
}
```

```dart
GestureDetector(
  onTap: toggleIcon,
  child: AnimatedIcon(
    color: iconColor.value,
    icon: AnimatedIcons.menu_close,
    progress: iconProgress,
  ),
)
```

## Quando usar esse modelo

Esse modelo e bom para acoes que precisam de feedback visual mais forte, por exemplo:

- abrir e fechar filtros
- expandir painel lateral
- ativar modo de edicao
- alternar entre estado neutro e estado ativo

## Ajustes comuns

- Para mudar a identidade visual: troque as cores do `ColorTween`
- Para mudar o par de icones: troque `AnimatedIcons.menu_close`
- Para suavizar o ritmo: aplique `CurvedAnimation` no controller ou nas animacoes derivadas

Exemplo:

```dart
final curved = CurvedAnimation(
  parent: controller,
  curve: Curves.easeInOut,
);

iconProgress = Tween(begin: 0.0, end: 1.0).animate(curved);
iconColor = ColorTween(
  begin: Colors.grey,
  end: Colors.blue,
).animate(curved);
```

## Cuidados

- Como `colorAnimation.value` depende do progresso do controller, o widget precisa reconstruir quando o controller muda. No `AddTask`, isso acontece porque o `setState()` do toggle ja refaz a area.
- Se voce quiser que o icone repinte durante toda a animacao mesmo sem outro rebuild ao redor, pode envolver o icone em `AnimatedBuilder`.
- Se a cor e a forma nao precisarem ficar sincronizadas, use controllers separados.

## Resumo rapido

Esse padrao combina transformacao de icone com transicao de cor usando o mesmo `AnimationController`.
No `AddTask`, ele reforca visualmente a abertura e o fechamento da area opcional.
