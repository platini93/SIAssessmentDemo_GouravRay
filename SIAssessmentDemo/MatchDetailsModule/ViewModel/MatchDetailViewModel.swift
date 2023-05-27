
import Foundation

protocol MatchViewProtocol {
   func showActIndicator()
   func hideActIndicator()
   func showAlertView(message:String)
}

class MatchDetailViewModel {
        
    var matchModel:MatchDetailsModel = MatchDetailsModel()
    
    var matchData: MatchData = MatchData() {
           didSet {
               self.bindMatchDetailViewModelToController()
           }
       }
    
    var bindMatchDetailViewModelToController:(() -> ()) = {}
    
    var view: MatchViewProtocol?
    
    init(view: MatchViewProtocol) {
        self.view = view
        callAPIToGetMatchData() // call for first API data
        //callSecondAPIToGetMatchData() // call for second API data
    }
    
    
    func callAPIToGetMatchData() {
        
        self.view?.showActIndicator()
        matchModel.callMatchAPI(completion: { matchData, error in
           
            self.view?.hideActIndicator()
            if error != nil {
                //print("Error : \(error)")
                self.view?.showAlertView(message: "\(error)")
                
            } else if matchData != nil {
                self.matchData = matchData ?? MatchData()
            }

        })
    }
    
    func callSecondAPIToGetMatchData() {
        
        self.view?.showActIndicator()
        matchModel.callSecondMatchAPI(completion: { matchData, error in
           
            self.view?.hideActIndicator()
            if error != nil {
                //print("Error : \(error)")
                self.view?.showAlertView(message: "\(error)")
                
            } else if matchData != nil {
                self.matchData = matchData ?? MatchData()
            }

        })
    }
}
