//
//  MatchDetailViewModel.swift
//  SIAssessmentDemo
//
//  Created by Zentech-038 on 24/05/23.
//

import Foundation

protocol MatchViewProtocol {
   func showActIndicator()
   func hideActIndicator()
}

class MatchDetailViewModel {
        
    var matchModel:MatchDetailsModel = MatchDetailsModel()
    
    var matchData: MatchData = MatchData() {
           didSet {
               self.bindEmployeeViewModelToController()
           }
       }
    
    var bindEmployeeViewModelToController:(() -> ()) = {}
    
    var view: MatchViewProtocol?
    
    init(view: MatchViewProtocol) {
        self.view = view
        callFuncToGetMatchData()
    }
    
    func callFuncToGetMatchData() {
        
        self.view?.showActIndicator()
        matchModel.callMatchAPI(completion: { matchData, error in
           
            self.view?.hideActIndicator()
            if error != nil {
                print("Error : \(error)")
                
            } else if matchData != nil {
                self.matchData = matchData ?? MatchData()
            }

        })
    }
}
