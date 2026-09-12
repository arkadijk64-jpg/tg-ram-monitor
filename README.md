# Telegram Server RAM Monitor

Простой Bash-скрипт для мониторинга оперативной памяти (RAM) и подкачки (Swap) на Linux-сервере с отправкой отчетов в Telegram-бот.

Функционал
- Мониторинг RAM и Swap с помощью `free -m`.
- Использование Telegram Bot API (Long Polling через `curl`).
- Проверка `ADMIN_ID` для доступа.
- Логирование событий в локальный файл.

Требования
- `bash`
- `curl`
- `jq`

Запуск
1. Клонировать репозиторий:
   ```bash
   git clone [https://github.com/arkadjk64-jpg/tg-ram-monitor.git](https://github.com/arkadjk64-jpg/tg-ram-monitor.git)
   cd tg-ram-monitor
