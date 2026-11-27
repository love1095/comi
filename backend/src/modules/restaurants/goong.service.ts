import { Inject, Injectable } from '@nestjs/common';
import { AppError } from '../../common/errors/app-error';
import { ENV } from '../../config/config.module';
import { Env } from '../../config/env';

export interface GeocodeResult {
  address: string;
  lat: number;
  lng: number;
  placeId?: string;
}

interface GoongGeocodeResponse {
  results?: { formatted_address: string; place_id?: string; geometry: { location: { lat: number; lng: number } } }[];
}

/** Goong geocoding (§14.2): address → candidates the owner confirms on a map pin. */
@Injectable()
export class GoongService {
  constructor(@Inject(ENV) private readonly env: Env) {}

  async geocode(address: string): Promise<GeocodeResult[]> {
    if (!this.env.GOONG_API_KEY) throw new AppError('SERVICE_UNAVAILABLE', 'Geocoding is not configured');
    const url = new URL('https://rsapi.goong.io/geocode');
    url.searchParams.set('address', address);
    url.searchParams.set('api_key', this.env.GOONG_API_KEY);
    const res = await fetch(url, { signal: AbortSignal.timeout(5000) });
    if (!res.ok) throw new AppError('SERVICE_UNAVAILABLE', `Geocoding failed (${res.status})`);
    const body = (await res.json()) as GoongGeocodeResponse;
    return (body.results ?? []).slice(0, 5).map((r) => ({
      address: r.formatted_address,
      lat: r.geometry.location.lat,
      lng: r.geometry.location.lng,
      placeId: r.place_id,
    }));
  }
}
