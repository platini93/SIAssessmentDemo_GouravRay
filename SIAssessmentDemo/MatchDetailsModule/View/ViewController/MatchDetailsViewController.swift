
import UIKit

class MatchDetailsViewController: UIViewController, MatchViewProtocol  {
    
    @IBOutlet weak var matchLbl: UILabel!
    @IBOutlet weak var dateAndTimeLbl: UILabel!
    @IBOutlet weak var venueLbl: UILabel!
    
    @IBOutlet weak var teamInfoBtn: UIButton!
    
    @IBAction func teamInfoAction(_ sender: Any) {
        let teamVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TeamInformationViewController") as! TeamInformationViewController
        teamVC.matchData = self.matchData
        self.present(teamVC, animated: true)
    }
    
    var matchData:MatchData = MatchData()
    
    weak var matchViewModel:MatchDetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamInfoBtn.layer.cornerRadius = 5.0
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
            venueLbl.text = "Venue : \(self.matchData.matchDetail.venue.name)"
        }
        
    }
    
}

