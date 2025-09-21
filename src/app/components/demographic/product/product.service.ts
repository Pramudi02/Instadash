import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../../environments/environment';

export interface Topproduct{
    productId : string,
    name :string
}

@Injectable({
    providedIn: 'root' 
  })

export class productservice{
        private apiUrl = `${environment.apiUrl}/Customer`; // Replace with your actual base URL

        constructor(private http: HttpClient) { }
        
        getproRecords(){
      return this.http.get<Topproduct>(`${this.apiUrl}/top-product`)
        }
} 