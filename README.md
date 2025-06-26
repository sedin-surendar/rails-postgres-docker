# 🚀 Rails + PostgreSQL + Docker Starter

This repository contains a Ruby on Rails application configured to run inside Docker, with PostgreSQL as the database. It's a clean setup for local development, testing, or deployment with minimal dependencies on your host system.

---

## 🔧 Stack

- **Ruby on Rails** (v7.x)
- **PostgreSQL** (v15)
- **Docker** (with Dockerfile & optional Compose)
- **Yarn + Node.js** for JS handling
- **bash entrypoint** for reliable container boot

- 📁 Directory Structure
- .
├── Dockerfile
├── entrypoint.sh
├── Gemfile
├── Gemfile.lock
├── config/
│   └── database.yml
└── myapp/
    └── ... Rails app code ...
