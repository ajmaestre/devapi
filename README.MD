# 📌 Configuración del Proyecto con PostgreSQL y Docker

Este documento proporciona las instrucciones detalladas para:
- Instalar PostgreSQL
- Crear la base de datos
- Descargar la API desde Git
- Construir la imagen de Docker
- Ejecutar el contenedor

---

## 📥 1. Instalación de PostgreSQL

### 🔹 Ubuntu / Debian
```sh
sudo apt update && sudo apt install -y postgresql postgresql-contrib
```

### 🔹 macOS (usando Homebrew)
```sh
brew install postgresql
```

### 🔹 Windows (usando Chocolatey)
```sh
choco install postgresql
```

---

## 🛠️ 2. Creación de la Base de Datos en PostgreSQL

1️⃣ Inicia PostgreSQL:
```sh
sudo systemctl start postgresql  # Linux
pg_ctl -D /usr/local/var/postgres start  # macOS
```

2️⃣ Accede a PostgreSQL:
```sh
sudo -u postgres psql
```

3️⃣ Crea la base de datos y el usuario:
```sql
CREATE DATABASE devdb;
CREATE USER postgres WITH ENCRYPTED PASSWORD '1993';
GRANT ALL PRIVILEGES ON DATABASE devdb TO postgres;
```

4️⃣ Sal de PostgreSQL:
```sh
\q
```

---

## 🔄 3. Descargar la API desde GitHub

Clona el repositorio:
```sh
git clone https://github.com/usuario/repo-api.git
cd repo-api
```

---

## 🐳 4. Construcción de la Imagen Docker

1️⃣ Asegúrate de que Docker está instalado:
```sh
docker --version
```

2️⃣ Construye la imagen:
```sh
docker build -t api-app .
```

---

## 🚀 5. Ejecutar los Contenedores con Docker

### 🔹 Opción 1: Usar `docker run` Manualmente
```sh
docker network create dev-red

docker run -d \  
  --name postgres-db \  
  --network dev-red \  
  -e POSTGRES_USER=postgres \  
  -e POSTGRES_PASSWORD=1993 \  
  -e POSTGRES_DB=devdb \  
  -v postgres-data:/var/lib/postgresql/data \  
  postgres:latest

docker run -d \  
  --name api-app \  
  --network dev-red \  
  -p 8080:80 \  
  api-app
```

### 🔹 Opción 2: Usar `docker-compose` (Recomendado)

1️⃣ Crea un archivo `docker-compose.yml` con el siguiente contenido:
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:latest
    container_name: postgres-db
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: 1993
      POSTGRES_DB: devdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - dev-red

  api:
    build: .
    container_name: api-app
    restart: always
    depends_on:
      - postgres
    ports:
      - "8080:80"
    networks:
      - dev-red

networks:
  dev-red:

volumes:
  postgres-data:
```

2️⃣ Levanta los servicios con:
```sh
docker-compose up -d --build
```

---

## 📝 6. Verificación de Contenedores en Ejecución

```sh
docker ps
```

Si todo está bien, verás los contenedores `postgres-db` y `api-app` en ejecución.

Para acceder a PostgreSQL dentro del contenedor:
```sh
docker exec -it postgres-db psql -U postgres -d devdb
```

Para ver los logs de la API:
```sh
docker logs -f api-app
```

---

## ✅ Conclusión

Siguiendo estos pasos, habrás instalado PostgreSQL, creado la base de datos, descargado la API, construido la imagen y ejecutado los contenedores con Docker. 🚀

