import { Injectable } from '@angular/core';
import { Observable, of } from 'rxjs';
import { HttpClient } from '@angular/common/http';
import { environment } from '../../../../environments/environment';

export interface cusdetail{
    aCount : number,
    iaCount: number,
}

@Injectable({
    providedIn: 'root' 
  })

export class customerservice{

    private apiUrl = `${environment.apiUrl}/Customer`;  

    constructor(private http: HttpClient) { }
        
    getpur(){
      return this.http.get<cusdetail>(`${this.apiUrl}/active-and-inactive`)
    }
} 
