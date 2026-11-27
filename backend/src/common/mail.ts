import { Global, Inject, Injectable, Logger, Module } from '@nestjs/common';
import nodemailer, { Transporter } from 'nodemailer';
import { ENV } from '../config/config.module';
import { Env } from '../config/env';

export interface MailMessage {
  to: string;
  subject: string;
  text: string;
  attachments?: { filename: string; content: Buffer; contentType?: string }[];
}

/** SMTP mail (Mailpit in dev). Without SMTP_URL, mails are logged and skipped — never fatal. */
@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);
  private readonly transport?: Transporter;

  constructor(@Inject(ENV) private readonly env: Env) {
    if (env.SMTP_URL && env.NODE_ENV !== 'test') this.transport = nodemailer.createTransport(env.SMTP_URL);
  }

  async send(m: MailMessage): Promise<boolean> {
    if (!this.transport) {
      this.logger.log(`mail skipped (no SMTP_URL): "${m.subject}" → ${m.to}`);
      return false;
    }
    try {
      await this.transport.sendMail({ from: this.env.EMAIL_FROM, ...m });
      return true;
    } catch (e) {
      this.logger.warn(`mail failed "${m.subject}" → ${m.to}: ${(e as Error).message}`);
      return false;
    }
  }
}

@Global()
@Module({ providers: [MailService], exports: [MailService] })
export class MailModule {}
