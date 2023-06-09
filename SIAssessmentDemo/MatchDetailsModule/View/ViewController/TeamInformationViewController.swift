
import UIKit

class TeamInformationViewController: UIViewController {
    
    var matchData:MatchData = MatchData()
    
    var indiaTeam:[PlayerDetails] = []
    var nzTeam:[PlayerDetails] = []
    
    @IBOutlet weak var squadTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indiaTeam = [matchData.teamsData.four.players.player1, matchData.teamsData.four.players.player2, matchData.teamsData.four.players.player3, matchData.teamsData.four.players.player4, matchData.teamsData.four.players.player5, matchData.teamsData.four.players.player6, matchData.teamsData.four.players.player7,
                     matchData.teamsData.four.players.player8, matchData.teamsData.four.players.player9, matchData.teamsData.four.players.player10, matchData.teamsData.four.players.player11]
        
        nzTeam = [matchData.teamsData.five.players.player1, matchData.teamsData.five.players.player2, matchData.teamsData.five.players.player3, matchData.teamsData.five.players.player4, matchData.teamsData.five.players.player5, matchData.teamsData.five.players.player6, matchData.teamsData.five.players.player7, matchData.teamsData.five.players.player8, matchData.teamsData.five.players.player9, matchData.teamsData.five.players.player10,
                  matchData.teamsData.five.players.player11]
        
        squadTableView.delegate = self
        squadTableView.dataSource = self
        squadTableView.separatorStyle = .none
        squadTableView.register(UINib(nibName: "SquadTableViewCell", bundle: nil), forCellReuseIdentifier: "SquadTableViewCell")
    }
    
}

extension TeamInformationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return indiaTeam.count
        } else {
            return nzTeam.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SquadTableViewCell", for: indexPath) as! SquadTableViewCell
        var data:PlayerDetails = PlayerDetails()
        if indexPath.section == 0 {
            data = indiaTeam[indexPath.row]
        } else {
            data = nzTeam[indexPath.row]
        }
        cell.playerNameLbl.text = data.name_full
        
        if data.isCaptain && data.isKeeper {
            cell.playerRoleLbl.text = "Captain & Wicket-Keeper"
        } else if data.isKeeper {
            cell.playerRoleLbl.text = "Wicket-Keeper"
        } else if data.isCaptain {
            cell.playerRoleLbl.text = "Captain"
        } else {
            cell.playerRoleLbl.text = ""
        }
        cell.playerRoleLbl.textColor = .blue
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            //return "INDIA"
            return matchData.teamsData.four.nameFull.uppercased()
        } else {
            //return "NEW ZEALAND"
            return matchData.teamsData.five.nameFull.uppercased()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var data:PlayerDetails = PlayerDetails()
        if indexPath.section == 0 {
            data = indiaTeam[indexPath.row]
        } else {
            data = nzTeam[indexPath.row]
        }
        
        let alert = UIAlertController(title: "Info", message: "Batting Style : \(data.batting.style) \n Bowling Style : \(data.bowling.style)", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
