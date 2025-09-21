import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { environment } from '../../../environments/environment';

@Injectable({ providedIn: 'root' })

export class barchartService {
  private apiUrl = `${environment.apiUrl}/table`; // Replace with your actual base URL

  constructor(private http: HttpClient) {}

  getLastThreeYearTaxSum() {
    return this.http.get<{ [year: string]: number }>(`${this.apiUrl}/tax-sum/last-3-years`);
  }
}
