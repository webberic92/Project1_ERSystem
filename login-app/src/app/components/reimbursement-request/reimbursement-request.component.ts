import { Component, OnInit } from '@angular/core';
import {ReimbursementService} from "../../services/reimbursement.service";
import {FormControl, FormGroup} from "@angular/forms";
import {Reimbursement} from "../../models/Reimbursement";
import {NgForm} from '@angular/forms';
import {AuthService} from "../../services/auth.service";

@Component({
  selector: 'app-reimbursement-request',
  templateUrl: './reimbursement-request.component.html',
  styleUrls: ['./reimbursement-request.component.css']
})

export class ReimbursementRequestComponent implements OnInit {

  defaultTypeOption='4';

  constructor(private reimbursementService: ReimbursementService,
              private authService: AuthService) { }

  ngOnInit() {
  }

  submitRequest(form: NgForm){
    let reimbursement = new Reimbursement();

    reimbursement.description = form.value['reimbursement-description'];
    reimbursement.amount = form.value['reimbursement-amount'];
    reimbursement.typeId = parseInt(form.value['reimbursement-type']);
    reimbursement.authorId = this.authService.getLoggedInUser().id;
    reimbursement.resolverId;
    reimbursement.dateResolved = null;
    reimbursement.dateSubmitted = new Date('0001-01-01T00:00:00');
    reimbursement.statusId = 1;

    this.reimbursementService.addReimbursement(reimbursement)
      .subscribe(() => console.log('success'),
        () => console.log('failure'));
  }
}
