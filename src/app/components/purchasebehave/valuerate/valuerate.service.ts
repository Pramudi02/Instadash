import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../../environments/environment';

export interface Pur{
  productName: string;
  productSoldCount: number;
  totalCustomerCount: number;
  value: number;
}

@Injectable({
    providedIn: 'root' 
  })

export class valuerateservice{

     private apiUrl = `${environment.apiUrl}/Customer/product-stats`;  
    
        constructor(private http: HttpClient) { }
            
        getpur(productId: string): Observable<Pur>{
          return this.http.get<Pur>(`${this.apiUrl}/${productId}`);
        }
} 