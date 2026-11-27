import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { IsEmail, IsOptional, IsString, Matches, MaxLength, MinLength } from 'class-validator';

export class CustomerExchangeDto {
  @ApiProperty({ description: 'Firebase ID token from the phone' })
  @IsString()
  @MinLength(5)
  idToken: string;
}

export class StaffRegisterDto {
  @ApiProperty() @IsEmail() @MaxLength(200) email: string;
  @ApiProperty({ minLength: 8 }) @IsString() @MinLength(8) @MaxLength(128) password: string;
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(100) name: string;
  @ApiPropertyOptional() @IsOptional() @Matches(/^\+?[0-9]{8,15}$/) phone?: string;
}

export class StaffLoginDto {
  @ApiProperty() @IsEmail() email: string;
  @ApiProperty() @IsString() @MinLength(1) @MaxLength(128) password: string;
}

export class RefreshDto {
  @ApiProperty() @IsString() @MinLength(10) refreshToken: string;
}

export class TokenPairDto {
  @ApiProperty() accessToken: string;
  @ApiProperty() refreshToken: string;
  @ApiProperty({ description: 'Access token lifetime in seconds' }) expiresIn: number;
}
