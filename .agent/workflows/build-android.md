---
description: Build and run the app on Android with optimized settings
---

# Build Android App (Optimized for Low RAM)

Este workflow executa o app Android com configurações otimizadas para evitar travamento do sistema.

## Passos

1. **Limpar cache (apenas se necessário)**
   ```bash
   flutter clean
   ```
   ⚠️ Só execute isso se houver problemas ou após mudanças nas dependências.

// turbo
2. **Executar em modo verbose**
   ```bash
   flutter run -v
   ```
   O modo verbose mostra o progresso do build em tempo real, para você saber que não travou.

## Configurações Aplicadas

- **Gradle Heap**: Limitado a 1.5GB (antes: 8GB)
- **Multidex**: Habilitado para Firebase
- **Encoding**: UTF-8 configurado

## Dicas

- **Primeira execução**: Pode demorar 5-10 minutos (baixando dependências)
- **Execuções seguintes**: ~30 segundos
- **Hot Reload**: Use `r` no terminal para mudanças rápidas sem rebuild completo
- **Se travar**: Verifique o uso de RAM com `htop` ou `free -h`
