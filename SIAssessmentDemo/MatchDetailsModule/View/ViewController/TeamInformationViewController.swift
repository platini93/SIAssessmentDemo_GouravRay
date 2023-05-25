
import UIKit

class TeamInformationViewController: UIViewController {
    
    var matchData:MatchData = MatchData()
    
    var indiaTeam:[PlayerDetails] = []
    var nzTeam:[PlayerDetails] = []
    
    @IBOutlet weak var squadTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Team 1 player 1 = \(matchData.teamsData.four.players.player1.name_full)")
        print("Team 1 player 2 = \(matchData.teamsData.four.players.player2.name_full)")
        print("Team 1 player 3 = \(matchData.teamsData.four.players.player3.name_full)")
        print("Team 1 player 4 = \(matchData.teamsData.four.players.player4.name_full)")
        print("Team 1 player 5 = \(matchData.teamsData.four.players.player5.name_full)")
        print("\n\n")
        print("Team 2 player 1 = \(matchData.teamsData.five.players.player1.name_full)")
        print("Team 2 player 2 = \(matchData.teamsData.five.players.player2.name_full)")
        
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
        if data.isKeeper {
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
            return "INDIA"
        } else {
            return "NEW ZEALAND"
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    
}
