import {Component, OnInit} from '@angular/core';
import {ReimbursementService} from "../../services/reimbursement.service";
import {AuthService} from '../../services/auth.service';
import {Reimbursement} from "../../models/Reimbursement";

@Component({
  selector: 'app-view-reimbursements',
  templateUrl: './view-reimbursements.component.html',
  styleUrls: ['./view-reimbursements.component.css']
})
export class ViewReimbursementsComponent implements OnInit {
  reimbursements: Reimbursement[];

  constructor(
    private reimbursementService: ReimbursementService,
    private authService: AuthService) {
  }

  ngOnInit() {
    let loggedInUserId = this.authService.getLoggedInUser().id;
    this.reimbursementService.getReimbursementsByAuthorId(loggedInUserId)
      .subscribe(reimbursements => this.reimbursements = reimbursements);
  }

}

