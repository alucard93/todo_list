# Documentacao da animacao 3: mudanca de cor do titulo

## Onde acontece no projeto

- `ColorTween`: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:53)
- `AnimatedBuilder`: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:88)
- Gatilho: [lib/widgets/add_task.widget.dart](/c:/Users/Vinicius/Documents/GitHub/todo_list/lib/widgets/add_task.widget.dart:153)

## Objetivo

Essa animacao troca a cor do texto `Adicionar Tarefa` conforme o estado de abertura da area de descricao.

## Tipo de animacao

- Widget usado para rebuild: `AnimatedBuilder`
- Valor animado: `Animation<Color?>`
- Fonte da cor: `ColorTween`
- Duracao atual: `300ms`
- Transicao atual: `Colors.red` para `Colors.green`

## Estado e objetos envolvidos

No `AddTask`, essa animacao depende destes elementos:

```dart
late AnimationController iconAnimationController;
late Animation<Color?> colorAnimation;
```

O controller e compartilhado com outras animacoes do `AddTask`, entao a mudanca de cor fica sincronizada com a abertura e o fechamento do bloco opcional.

## Implementacao atual

### 1. Criacao da animacao de cor

```dart
colorAnimation = ColorTween(
  begin: Colors.red,
  end: Colors.green,
).animate(iconAnimationController);
```

### 2. Rebuild do texto com `AnimatedBuilder`

```dart
AnimatedBuilder(
  animation: iconAnimationController,
  builder: (_, _) {
    return Text(
      "Adicionar Tarefa",
      style: theme.textTheme.titleLarge!.copyWith(
        color: colorAnimation.value,
        fontFamily: "Poppins",
      ),
    );
  },
)
```

## Como essa animacao funciona

O `AnimatedBuilder` escuta o `iconAnimationController`.
Sempre que o controller avanca ou volta, o builder roda de novo e aplica o valor atual de `colorAnimation.value` no texto.

Na pratica:

- `forward()` leva a cor do inicio ao fim
- `reverse()` traz a cor do fim para o inicio

## Modelo para reaproveitar

Use esse padrao quando voce quiser animar:

- titulo de secao
- label de status
- texto de alerta
- qualquer texto que precise responder a um estado visual

### Estrutura minima

```dart
class ExampleWidgetState extends State<ExampleWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Color?> textColorAnimation;
  var isActive = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    textColorAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.blue,
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void toggleState() {
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
AnimatedBuilder(
  animation: controller,
  builder: (_, _) {
    return Text(
      "Titulo",
      style: TextStyle(color: textColorAnimation.value),
    );
  },
)
```

## Quando usar esse modelo

Use quando o texto precisa mostrar mudanca de estado sem trocar de tela nem sumir da interface.

Esse padrao funciona bem quando:

- a cor precisa acompanhar outra animacao
- o texto precisa reagir a um toggle
- voce quer evitar estados visuais bruscos

## Ajustes comuns

- Para mudar as cores: altere `begin` e `end`
- Para suavizar mais: envolva com `CurvedAnimation`
- Para usar tema: troque `Colors.*` por `theme.colorScheme.*`

Exemplo com curva:

```dart
textColorAnimation = ColorTween(
  begin: Colors.grey,
  end: Colors.blue,
).animate(
  CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
  ),
);
```

## Cuidados

- `colorAnimation.value` pode ser nulo em algumas configuracoes tipadas, entao mantenha o tipo `Color?` quando necessario.
- Se o texto nao precisar reconstruir toda a arvore, mantenha o builder o mais pequeno possivel.
- Se varias partes da tela usam a mesma cor animada, vale centralizar tudo no mesmo controller, como ja acontece no `AddTask`.

## Resumo rapido

Esse padrao usa `AnimatedBuilder` para reconstruir um `Text` conforme uma `ColorTween`.
No `AddTask`, ele deixa o titulo mudar de cor de forma sincronizada com a interacao principal do formulario.
