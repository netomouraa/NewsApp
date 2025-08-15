# HISTORY.md

## 📅 Histórico do Projeto - Aplicativo de Feed de Notícias

Este documento registra **decisões técnicas**, **ideias futuras** e **motivos de mudanças** na arquitetura ao longo do desenvolvimento.

---

### 07-08-2025 — Definição inicial do projeto
- **Objetivo**: Criar um aplicativo iOS para consumir o feed de notícias do portal G1.
- **Primeira decisão**: Utilizar **MVVM** como arquitetura principal, para separar camada de apresentação, lógica de negócio e serviços de rede.
- **Justificativa**: MVVM é bem suportado pelo SwiftUI e Combine, facilita testes unitários e permite evolução para arquiteturas mais complexas como MVVM-C (MVVM + Coordinator) no futuro.

---

### 08-08-2025 — Testes de arquitetura
- **Testado**: UIKit + MVVM + Coordinator
- **Resultado**: Arquitetura sólida e escalável, mas exigiu mais código e comunicação View ↔ ViewModel.
- **Decisão**: Migrar para **SwiftUI + Combine** para reduzir complexidade.

---

### 11-08-2025 — Implementação inicial
- **Feito**:
  - Modelos `Codable` para parse do JSON de notícias.
  - Serviço de rede genérico (`APIClient`) usando `URLSession` e Combine.
  - ViewModel com estado `@Published` para notícias, carregamento e erros.
  - View (`NewsListView`) com `List` para exibir título, imagem e descrição.
  - Mock de dados (`MockNewsService`) para uso em testes e Previews.
- **Motivo**: Garantir fluxo end-to-end funcional rapidamente, com suporte a testes.

---

### 15-08-2025 — Melhorias planejadas (futuro)
1. **Modularização**  
   - Desacoplar camadas e facilitar a reutilização de código, refatoração e testes.

2. **Cache de Imagens**  
   - Usar `URLCache` ou `Kingfisher` para evitar recarregar imagens.
   - Melhoraria performance e reduziria uso de rede.
   
3. **Tela de Detalhe da Notícia**  
   - Ao clicar em uma notícia, abrir um `SafariView` interno com a URL.
   - Poderia evoluir para uma tela própria com renderização de HTML.

4. **Suporte a Múltiplas Fontes de Notícias**  
   - Permitir troca de endpoint para diferentes canais (`g1`, `ge`, `gshow`).

5. **Testes Unitários e de UI**  
   - Criar testes para validar parsing do JSON.
   - Criar snapshot tests para a UI.

---

### 15-08-2025 — Decisões técnicas
- **Porque Combine?**  
  - Integração nativa com SwiftUI.
  - Permite fácil cancelamento de requisições.
  - Código mais limpo comparado a callbacks aninhados.

- **Porque manter mocks no projeto?**  
  - Facilita desenvolvimento offline.
  - Útil para previews no SwiftUI.
  - Acelera testes automatizados.

---

### 15-08-2025 — Arquiteturas testadas e descartadas
- **MVP (Model-View-Presenter)**  
  - Simples de implementar, mas menos intuitivo com SwiftUI, exigindo adaptadores extras.
  - Descartado por não se integrar bem com o binding reativo.

- **VIPER**  
  - Muito verboso para o tamanho do projeto.
  - Descartado por overhead de camadas e arquivos.

---
