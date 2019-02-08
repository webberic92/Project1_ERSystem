import { Component, OnInit } from '@angular/core';
import { Reimbursement} from "../../models/Reimbursement";
import {ReimbursementService} from "../../services/reimbursement.service";

@Component({
  selector: 'app-view-all-reimbursements',
  templateUrl: './view-all-reimbursements.component.html',
  styleUrls: ['./view-all-reimbursements.component.css']
})
export class ViewAllReimbursementsComponent implements OnInit {
  reimbursements: Reimbursement[];

  constructor(private reimbursementService: ReimbursementService) { }

  ngOnInit() {
    this.reimbursementService.getAllReimbursements()
      .subscribe(reimbursements => {
        this.reimbursements = reimbursements;
      })
  }

}
