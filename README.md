# 🛡️ Test Process Monitoring / Мониторинг процесса Test

![Status](https://img.shields.io/badge/status-active-brightgreen)  
![Language](https://img.shields.io/badge/language-bash-blue)  

This project monitors the `test` process on Linux.  
It logs process restarts and sends status to a monitoring server via HTTPS.  

Проект мониторит процесс `test` на Linux.  
Логирует перезапуски процесса и отправляет статус на сервер мониторинга через HTTPS.

---

## 📂 Project Structure / Структура проекта

test_for_Effective_Mobile_DevOps/
├── README.md # This file / Этот файл
├── scripts/
│ └── monitor_test.sh # Monitoring script / Скрипт мониторинга
├── systemd/
│ ├── monitoring-test.service # systemd service unit / Юнит service
│ └── monitoring-test.timer # systemd timer unit / Юнит timer
├── install_monitoring.sh # Installation script / Скрипт установки
└── uninstall_monitoring.sh # Uninstallation script / Скрипт удаления


---

## ⚙️ Features / Функциональность

| Feature | Status |
|---------|--------|
| Process monitoring / Мониторинг процесса | ✅ |
| Logs process restarts / Логирование перезапусков | ✅ |
| Sends status to monitoring API / Отправка статуса на API | ✅ |
| Runs every minute via systemd timer / Запуск каждую минуту через systemd timer | ✅ |
| Simple install/uninstall scripts / Простая установка и удаление | ✅ |

---

## 📝 Installation / Установка

### English ну и по приколу по Русски
```bash
# Clone the repository
git clone https://github.com/username/test_for_Effective_Mobile_DevOps.git
cd test_for_Effective_Mobile_DevOps

# Install the monitoring solution
sudo ./install_monitoring.sh

# Клонируем репозиторий
git clone https://github.com/username/test_for_Effective_Mobile_DevOps.git
cd test_for_Effective_Mobile_DevOps

# Устанавливаем систему мониторинга
sudo ./install_monitoring.sh


---



🔍 How to Check / Проверка работы

# Check timer status
systemctl status monitoring-test.timer

# Check log file
cat /var/log/monitoring.log

# Check if process is running
pgrep -x test

# Проверить статус таймера
systemctl status monitoring-test.timer

# Просмотреть лог
cat /var/log/monitoring.log

# Проверить процесс
pgrep -x test


---

🧹 Uninstallation / Удаление

sudo ./uninstall_monitoring.sh