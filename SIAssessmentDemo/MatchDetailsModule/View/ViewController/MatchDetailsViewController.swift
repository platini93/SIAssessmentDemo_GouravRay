
import UIKit

class MatchDetailsViewController: UIViewController, MatchViewProtocol  {
    
    @IBOutlet weak var innerView: UIView!
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
        innerView.layer.cornerRadius = 10.0
        matchViewModel = MatchDetailViewModel(view: self)
        matchViewModel?.bindMatchDetailViewModelToController = {
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
    
    func showAlertView(message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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

