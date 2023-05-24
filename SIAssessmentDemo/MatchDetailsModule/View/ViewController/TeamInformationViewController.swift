
import UIKit

class TeamInformationViewController: UIViewController {

    var matchData:MatchData = MatchData()
    
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
        
        // Do any additional setup after loading the view.
    }
    


}
