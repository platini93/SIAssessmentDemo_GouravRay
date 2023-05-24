//
//  ViewController.swift
//  SIAssessmentDemo
//
//  Created by Zentech-038 on 24/05/23.
//

import UIKit

class MatchDetailsViewController: UIViewController, MatchViewProtocol  {
    
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
        print("\n\n Match Data team away = \(matchData.matchDetail.teamAway)")
    }
    
}

