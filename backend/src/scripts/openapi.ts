/**
 * Writes backend/openapi.json without a database, for the Dart client generator:
 *   npm run openapi && (cd .. && melos run api:generate)
 */
import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { writeFileSync } from 'fs';
import { join } from 'path';
import { AppModule } from '../app.module';
import { buildOpenApi, configureApp } from '../bootstrap';

async function main() {
  process.env.DATABASE_URL ??= 'postgresql://unused';
  process.env.JWT_SECRET ??= 'x'.repeat(32);
  process.env.REFRESH_TOKEN_PEPPER ??= 'x'.repeat(16);
  process.env.NODE_ENV ??= 'test';

  const app = await NestFactory.create(AppModule, { logger: false, abortOnError: false, preview: true });
  configureApp(app);
  const doc = buildOpenApi(app);
  const out = join(__dirname, '..', '..', 'openapi.json');
  writeFileSync(out, JSON.stringify(doc, null, 2));
  console.log(`Wrote ${out} (${Object.keys(doc.paths).length} paths)`);
  await app.close();
}

void main();
