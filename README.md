# Sitio Web Estático con CI/CD (GitHub Actions + AWS S3 + Terraform)

Este proyecto implementa una infraestructura automatizada para el despliegue de un sitio web estático en Amazon S3, utilizando Terraform para la Infraestructura como Código (IaC) y GitHub Actions para el flujo de Integración y Despliegue Continuo (CI/CD).

## 🚀 Características

- **Infraestructura como Código:** Gestión de recursos de AWS mediante Terraform.
- **CI/CD Automatizado:** Despliegue automático al realizar cambios en la rama principal.
- **S3 Hosting:** Alojamiento de sitio web estático escalable y de bajo costo.
- **Backend Remoto:** Almacenamiento del estado de Terraform en S3 para colaboración.

## 📁 Estructura del Proyecto

```text
.
├── .github/workflows/
│   └── deploy.yml      # Definición del flujo CI/CD
├── app/
│   └── index.html      # Código fuente del sitio web
├── infra/
│   └── main.tf         # Definición de infraestructura (S3, Políticas)
└── README.md           # Documentación del proyecto
```

## 🛠️ Tecnologías Utilizadas

- **HTML5/CSS3:** Para la interfaz del sitio web.
- **Terraform:** Para el aprovisionamiento de infraestructura.
- **AWS (S3):** Para el almacenamiento y hosting.
- **GitHub Actions:** Para la automatización del despliegue.

## 🌿 Estrategia de Ramas

El repositorio sigue una estructura organizada de ramas:

- `main`: Rama de producción. Contiene el código estable y lo que está desplegado actualmente.


## ⚙️ Configuración y Uso

### Prerrequisitos

1. Cuenta de AWS con permisos para S3.
2. Terraform instalado localmente (opcional, para pruebas manuales).
3. Secretos configurados en GitHub (Settings > Secrets and variables > Actions):
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`

### Despliegue Automático

Cada vez que se realiza un `push` a la rama `main`, el workflow de GitHub Actions realiza lo siguiente:
1. Clona el repositorio.
2. Configura las credenciales de AWS.
3. Inicializa y aplica los cambios de Terraform en la carpeta `infra/`.
4. Sincroniza el contenido de la carpeta `app/` con el bucket de S3 creado.
5. Proporciona la URL pública del sitio web.

### Uso Local

Para realizar cambios locales y probar la infraestructura:

```bash
cd infra
terraform init
terraform plan
terraform apply
```

## ✒️ Autor
- **Yennyfer Gomez**
