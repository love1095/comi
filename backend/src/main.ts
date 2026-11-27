import 'reflect-metadata';
import { NestFactory } from '@nestjs/core';
import { SwaggerModule } from '@nestjs/swagger';
import { Logger } from 'nestjs-pino';
import { AppModule } from './app.module';
import { buildOpenApi, configureApp } from './bootstrap';
import { loadEnv } from './config/env';
import { RedisIoAdapter } from './modules/realtime/realtime.gateway';

async function bootstrap() {
  const env = loadEnv(); // fail fast on bad config
  const app = await NestFactory.create(AppModule, { bufferLogs: true });
  app.useLogger(app.get(Logger));
  configureApp(app);
  app.useWebSocketAdapter(new RedisIoAdapter(app, env.REDIS_URL));

  if (env.SWAGGER_ENABLED ?? env.NODE_ENV !== 'production') {
    SwaggerModule.setup('docs', app, buildOpenApi(app));
  }

  await app.listen(env.PORT);
  app.get(Logger).log(`comi API on http://localhost:${env.PORT}/api/v1 · docs at /docs`);
}

void bootstrap();
