# Documentação do App Todo List (Flutter)

## Sumário

- [Visão geral](#visão-geral)
- [Fluxo principal](#fluxo-principal)
- [Mapa de arquivos](#mapa-de-arquivos)
- [Detalhamento por arquivo](#detalhamento-por-arquivo)
  - [lib/main.dart](#libmaindart)
  - [lib/pages/tasks_list.page.dart](#libpagestasks_listpagedart)
  - [lib/models/task.model.dart](#libmodelstaskmodeldart)
  - [lib/widgets/add_task.widget.dart](#libwidgetsadd_taskwidgetdart)
- [Fluxo de dados](#fluxo-de-dados)
- [Pontos de extensão](#pontos-de-extensão)

## Visão geral

Este documento descreve os arquivos selecionados do app Todo List, detalhando responsabilidades, estados, interações entre widgets e comportamento de UI. O foco é explicar como a criação, exibição e atualização de tarefas acontece na aplicação.

## Fluxo principal

1. O app inicia em `MyApp` e carrega a tela `TasksListPage`.
2. O usuário toca em "Nova tarefa" e abre o bottom sheet com `AddTask`.
3. O formulário valida o título e cria uma instância de `Task`.
4. O bottom sheet fecha retornando o `Task`.
5. A lista local é atualizada e a UI é re-renderizada.

## Mapa de arquivos

| Arquivo                          | Papel                              | Depende de       | Entrega para                    |
| -------------------------------- | ---------------------------------- | ---------------- | ------------------------------- |
| lib/main.dart                    | Inicializa o app e tema global     | Flutter Material | TasksListPage                   |
| lib/pages/tasks_list.page.dart   | Tela principal e controle da lista | Task, AddTask    | UI da lista                     |
| lib/models/task.model.dart       | Modelo de domínio de tarefa        | —                | TasksListPage, AddTask          |
| lib/widgets/add_task.widget.dart | Formulário de criação de tarefa    | Task             | Retorna Task para TasksListPage |

## Detalhamento por arquivo

### lib/main.dart

#### Responsabilidade (main.dart)

Ponto de entrada do app, definição de tema e tela inicial.

#### Componentes principais

- `main()`: executa o app via `runApp(const MyApp())`.
- `MyApp`: widget raiz que monta o `MaterialApp`.

#### Configurações relevantes

- `title`: "Todo List".
- `debugShowCheckedModeBanner`: desabilitado.
- `ThemeData`:
  - `ColorScheme.fromSeed(seedColor: Colors.indigo)`.
  - `AppBarTheme` e `FloatingActionButtonThemeData` com cores padronizadas.
- `home`: `TasksListPage()`.

#### Observações

- Camada sem estado de negócio.
- Mudanças globais de identidade visual devem ser feitas aqui.

### lib/pages/tasks_list.page.dart

#### Responsabilidade (TasksListPage)

Tela principal com listagem de tarefas e ações de criação/atualização local.

#### Estrutura de classes

- `TasksListPage` (`StatefulWidget`): precisa de estado por conta da lista mutável.
- `_TasksListPageState`: mantém a lista e lida com interações da UI.

#### Estado mantido

- `tasks: List<Task>`: armazenamento em memória das tarefas.

#### Funções principais

- `addTask()`:
  - abre `showModalBottomSheet<Task>`.
  - renderiza `AddTask` no `builder`.
  - aguarda o retorno do `Task`.
  - adiciona o item à lista com `setState()`.

#### UI (estrutura)

- `Scaffold` com `AppBar`, `body` e `FloatingActionButton`.
- `ListView.builder` para renderização eficiente.
- `Card` para cada tarefa, contendo:
  - `Checkbox` para `isCompleted`.
  - `Text` de título e descrição.
  - `IconButton` com estrela para `isImportant`.

#### Comportamentos

- `Checkbox` chama `task.changeStatus()`.
- Estrela chama `task.changeImportance()`.
- Toda mudança local dispara `setState()`.

### lib/models/task.model.dart

#### Responsabilidade

Representa o domínio de uma tarefa e suas operações básicas.

#### Campos

- `title` (obrigatório)
- `description` (opcional)
- `isCompleted` (default: `false`)
- `isImportant` (default: `false`)

#### Métodos

- `changeStatus(bool status)`
- `changeImportance()`

#### Observações (TasksListPage)

- Modelo mutável (operações alteram o próprio objeto).
- Pode evoluir para modelo imutável com `copyWith`.

### lib/widgets/add_task.widget.dart

#### Responsabilidade (Task)

Formulário apresentado no bottom sheet para criação de nova tarefa.

#### Estrutura de classes (AddTask)

- `AddTask` (`StatefulWidget`): estado local do formulário.
- `_AddTaskState`: controles e validação.

#### Estados e controles

- `isImportant`: flag de importância.
- `showDescription`: controla visibilidade da descrição.
- `titleController`, `descriptionController`: inputs.
- `formKey`: validação do formulário.

#### Funções principais (AddTask)

- `addTask()`:
  - valida o formulário.
  - cria `Task` com título/descrição/importância.
  - fecha o bottom sheet retornando o `Task`.
- `dispose()`:
  - libera controllers.

#### UI (estrutura) (AddTask)

- `Padding` ajustado ao teclado.
- `Form` com validação de título.
- Campo de descrição opcional.
- Ícones para alternar descrição e importância.
- Botão "Adicionar" para submeter.

## Fluxo de dados

1. `AddTask` cria `Task` e retorna via `Navigator.pop(task)`.
2. `TasksListPage` recebe o retorno em `addTask()`.
3. A lista `tasks` é atualizada e a UI reflete o novo estado.
4. Alterações de status/importância são locais e imediatas.

## Pontos de extensão

- Persistência (SQLite, Hive, SharedPreferences).
- Edição e remoção de tarefas.
- Ordenação e filtros (importantes, concluídas, pendentes).
- Separação por camadas (estado global, repositórios, serviços).
