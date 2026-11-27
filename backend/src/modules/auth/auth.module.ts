import { AdminAuthController } from './admin-auth.controller';
import { StaffAccountController } from './staff-account.controller';
import { Global, Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';
import { AuthController } from './auth.controller';
import { AuthService } from './auth.service';
import { FirebaseVerifier } from './firebase-verifier';
import { TokenService } from './token.service';

@Global()
@Module({
  imports: [
    JwtModule.registerAsync({
      global: true,
      inject: [ENV],
      useFactory: (env: Env) => ({ secret: env.JWT_SECRET, signOptions: { issuer: 'comi' }, verifyOptions: { issuer: 'comi' } }),
    }),
  ],
  controllers: [AuthController, StaffAccountController, AdminAuthController],
  providers: [AuthService, TokenService, FirebaseVerifier],
  exports: [TokenService],
})
export class AuthModule {}
