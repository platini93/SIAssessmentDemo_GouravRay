//
//  ViewController.swift
//  SIAssessmentDemo
//
//  Created by Zentech-038 on 24/05/23.
//

import UIKit

class MatchDetailsViewController: UIViewController, MatchViewProtocol  {
    
    @IBOutlet weak var matchLbl: UILabel!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var venueLbl: UILabel!
    
    var matchData:MatchData = MatchData()
    
    weak var matchViewModel:MatchDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        matchViewModel = MatchDetailViewModel(view: self)
        matchViewModel?.bindEmployeeViewModelToController = {
                self.updateUI()
        }
    }
    
    func showActIndicator() {
        DispatchQueue.main.async {
            self.showActivityIndicator()
        }
    }
    
    func hideActIndicator() {
        DispatchQueue.main.async {
            self.hideActivityIndicator()
        }
    }
    
    func updateUI() {
        matchData = matchViewModel?.matchData ?? MatchData()
        DispatchQueue.main.async { [self] in
            matchLbl.text = "Match : \(self.matchData.teamsData.four.nameFull) vs \(self.matchData.teamsData.five.nameFull)"
            dateAndTimeLbl.text = "Date & Time : \(self.matchData.matchDetail.match.date) \(self.matchData.matchDetail.match.time)"
        }
        
    }
    
}

