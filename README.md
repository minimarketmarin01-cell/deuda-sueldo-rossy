# Deuda de sueldo — Rossy

App para controlar la deuda de sueldo de Rossy (Minimarket Marín 376). Corre en un Cloudflare Worker, guarda todo en D1.

## Qué hace

- Calcula lo devengado: ingreso mínimo legal chileno, mes a mes, desde una fecha de inicio hasta hoy.
- Resta los abonos registrados, agrupados por origen (transferencias, efectivo, cuentas pagadas, etc.).
- Cada grupo se puede activar/desactivar según corresponda o no a sueldo.
- Permite agregar abonos nuevos a futuro; la deuda se recalcula sola.

## Infraestructura ya creada

- **D1 database**: `deuda_sueldo_rossy` (`03b54ed8-ac3a-4bc0-aae6-379b881ab68e`), ya tiene el esquema y los datos extraídos del Excel original cargados.
- **Worker**: `deuda-sueldo-rossy`, todavía no desplegado (falta el paso de deploy, ver abajo).

## Desplegar

El deploy corre por GitHub Actions (`.github/workflows/deploy.yml`) cada vez que se hace push a `main`. Para activarlo:

1. Ve a **Settings → Secrets and variables → Actions** en este repo.
2. Agrega dos secrets:
   - `CLOUDFLARE_API_TOKEN`: crea uno en [dash.cloudflare.com/profile/api-tokens](https://dash.cloudflare.com/profile/api-tokens) con permisos de **Workers Scripts: Edit** y **D1: Edit** (usa la plantilla "Edit Cloudflare Workers").
   - `CLOUDFLARE_ACCOUNT_ID`: lo ves en el panel derecho de cualquier página del dashboard de Cloudflare.
3. Con los secrets puestos, cualquier push a `main` despliega solo. También puedes lanzarlo a mano desde la pestaña **Actions → Deploy → Run workflow**.

Alternativa manual (si prefieres no usar GitHub Actions):

```bash
npm install
npx wrangler login
npm run deploy
```

Una vez desplegado, la URL queda como `https://deuda-sueldo-rossy.<tu-subdominio>.workers.dev` (Cloudflare te la muestra al terminar el deploy, o la ves en el dashboard → Workers & Pages).

## Base de datos

El esquema y los datos ya están cargados directamente en D1 (no vía `wrangler d1 migrations apply`, para tenerlo listo de inmediato). Los archivos en `migrations/` documentan exactamente qué se cargó:

- `0001_schema.sql` — tablas (`settings`, `salary_tramos`, `categories`, `payments`)
- `0002_seed.sql` — datos extraídos del Excel original

Si en el futuro necesitas cambiar el esquema, agrega un archivo nuevo `migrations/0003_....sql` y corre:

```bash
npm run db:migrate
```

(Wrangler sabe que 0001 y 0002 ya están aplicadas, así que no las repite.)

## Seguridad

**Esta app no tiene login.** Cualquiera con la URL puede ver y editar los datos. Como es una URL `workers.dev` no indexada, es razonablemente privada, pero si te preocupa:

- La forma recomendada y gratis es activar [Cloudflare Access](https://developers.cloudflare.com/cloudflare-one/policies/access/) sobre el Worker (pide login con tu email antes de mostrar la página).
- Pídeme que te lo configure si quieres.

## Supuestos del cálculo (revisar)

- El sueldo base usado es el **ingreso mínimo legal**, no lo que decía el Excel original — edítalo en la tabla de tramos si el sueldo pactado era otro.
- El grupo "Transferencias Santander 2023-2024" está marcado como abono por defecto pero es una inferencia mía (el Excel no dice explícitamente que sea sueldo) — revísalo.
- Quedan excluidos por defecto: una transferencia anotada "isabel", transferencias de clientes, plan de celular, y unas cifras sueltas sin encabezado en la columna A del Excel.
- No incluye gratificación legal, cotizaciones previsionales ni indemnización. Es una estimación para negociar, no un finiquito.
