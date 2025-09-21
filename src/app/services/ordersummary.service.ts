import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { Order } from '../models/ordersummery.model'; // Adjust path as needed
import { AuthService } from '../services/auth.service'; // Adjust path as needed
import { environment } from '../../environments/environment';

@Injectable({
  providedIn: 'root',
})
export class OrderService {
  private readonly ORDERS_API = `${environment.apiUrl}/api/orders`;
  private readonly STATUS_API = `${environment.apiUrl}/api/orderstatus/summary`;

  constructor(private http: HttpClient, private authService: AuthService) {}

  getOrders(): Observable<Order[]> {
    return this.http.get<Order[]>(this.ORDERS_API);
  }

  getOrderStatusSummary(): Observable<{ [key: string]: number }> {
    return this.http.get<{ [key: string]: number }>(this.STATUS_API);
  }

  getOrdersByCompany(): Observable<Order[]> {
    const companyId = this.authService.getCurrentUser()?.CompanyId;
    if (!companyId) {
      throw new Error('User company ID is not available.');
    }
    return this.http.get<Order[]>(`${this.ORDERS_API}/company/${companyId}`);
  }

  getOrderStatusSummaryByCompany(): Observable<{ [key: string]: number }> {
  const companyId = this.authService.getCurrentUser()?.CompanyId;
  if (!companyId) throw new Error('User company ID is not available.');
  return this.http.get<{ [key: string]: number }>(
    `${environment.apiUrl}/api/orderstatus/summary/company/${companyId}`
  );
}
getCustomerDetails(customerId: string) {
  return this.http.get<any>(`${environment.apiUrl}/api/customer/${customerId}`);
}


}
