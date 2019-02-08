import {Injectable} from '@angular/core';
import {ReimbursementRequestComponent} from "../components/reimbursement-request/reimbursement-request.component";
import {Observable, of} from "rxjs";
import {Reimbursement} from "../models/Reimbursement";
import {HttpClient} from "@angular/common/http";
import { HttpHeaders } from '@angular/common/http';
import {environment} from "../../environments/environment";


@Injectable({
  providedIn: 'root'
})

export class ReimbursementService {
  constructor(private httpClient: HttpClient) {
  }

  getReimbursementsByAuthorId(authorId: number): Observable<Reimbursement[]> {
    return this.httpClient.get<Reimbursement[]>('http://localhost:8080/login/reimbursementsbyauthor/' + authorId);
  }

  getAllReimbursements(): Observable<Reimbursement[]>{
    return this.httpClient.get<Reimbursement[]>('http://localhost:8080/login/reimbursements/');
  }

  addReimbursement(reimbursement: Reimbursement): Observable<Reimbursement>{

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'

      })
    };

    return this.httpClient.post<Reimbursement>('http://localhost:8080/login/reimbursements/', reimbursement, httpOptions);
  }
  updateReimbursement(reimbursement: Reimbursement): Observable<Reimbursement>{

    const httpOptions = {
      headers: new HttpHeaders({
        'Content-Type': 'application/json'
      })
    };

    return this.httpClient.put<Reimbursement>('http://localhost:8080/login/reimbursements/', reimbursement, httpOptions);
  }


}
