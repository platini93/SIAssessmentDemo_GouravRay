
import Foundation

class MatchData {
    var matchDetail:MatchDetail = MatchDetail()
    var teamsData:Teams = Teams()
}

class MatchDetail {
    var teamHome:String = ""
    var teamAway:String = ""
    var match:Match = Match()
    var venue:Venue = Venue()
}

class Match {
    var date:String = ""
    var time:String = ""
}

class Venue {
    var name:String = ""
}

class Teams {
    var four:TeamDetail1 = TeamDetail1()
    var five:TeamDetail2 = TeamDetail2()
}

class TeamDetail1 {
    var nameFull:String = ""
    var nameShort:String = ""
    var players:Players1 = Players1()
}

class TeamDetail2 {
    var nameFull:String = ""
    var nameShort:String = ""
    var players:Players2 = Players2()
}

class Players1 {
    var player1: PlayerDetails = PlayerDetails()
    var player2: PlayerDetails = PlayerDetails()
    var player3: PlayerDetails = PlayerDetails()
    var player4: PlayerDetails = PlayerDetails()
    var player5: PlayerDetails = PlayerDetails()
}

class Players2 {
    var player1: PlayerDetails = PlayerDetails()
    var player2: PlayerDetails = PlayerDetails()
    var player3: PlayerDetails = PlayerDetails()
    var player4: PlayerDetails = PlayerDetails()
    var player5: PlayerDetails = PlayerDetails()
}

class PlayerDetails {
    var name_full:String = ""
    var isKeeper:Bool = false
    var isCaptain:Bool = false
    var batting:Batting = Batting()
    var bowling:Bowling = Bowling()
}

class Batting {
    var style:String = ""
}

class Bowling {
    var style:String = ""
}

class MatchDetailsModel {
    
    func callMatchAPI(completion: @escaping (_ allUsers:MatchData?, _ error:Error?) -> Void) {
        
        let matchData: MatchData = MatchData()
        
        NetworkRequest.shared.getRequest(urlString: URLConstants.matchDetailsAPI, completion: {data, error in
            
            if error != nil {
                
                print("Error = \(String(describing: error))")
                completion(nil, error)
                
            } else if data != nil {
                print("Data inside closure = \(String(describing: data))")
                do{
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : Any]
                    print("Json Data = \(String(describing: json))")
                    
                    let matchDetail = json?["Matchdetail"] as? [String:Any]
                    let team_home = matchDetail?["Team_Home"] as? String ?? ""
                    let team_away = matchDetail?["Team_Away"] as? String ?? ""
                    
                    let matchdetail = MatchDetail()
                    matchdetail.teamHome = team_home
                    matchdetail.teamAway = team_away

                    matchData.matchDetail = matchdetail
                    
                    let match = matchDetail?["Match"] as? [String:Any]
                    let match_date = match?["Date"] as? String ?? ""
                    let match_time = match?["Time"] as? String ?? ""
                    
                    matchData.matchDetail.match.date = match_date
                    matchData.matchDetail.match.time = match_time
                    
                    let venue = matchDetail?["Venue"] as? [String:Any]
                    let venue_name = venue?["Name"] as? String ?? ""
                    matchData.matchDetail.venue.name = venue_name

                    let teams = json?["Teams"] as? [String:Any]
                    let team_four = teams?["4"] as? [String:Any]
                    let team_five = teams?["5"] as? [String:Any]
                    
                    let teamData1 = TeamDetail1()
                    teamData1.nameFull = team_four?["Name_Full"] as? String ?? ""
                    
                    let teamData2 = TeamDetail2()
                    teamData2.nameFull = team_five?["Name_Full"] as? String ?? ""
                    
                    let Teams = Teams()
                    Teams.four = teamData1
                    Teams.five = teamData2
                    
                    matchData.teamsData = Teams
                    
                    /////////  team 1 - -----------------------------------------------------------------------
                
                    let players1 = team_four?["Players"] as? [String:Any]
                    let player1 = players1?["3632"] as? [String:Any]
                    var full_name1 = player1?["Name_Full"] as? String ?? ""
                    var isKeeper1 = player1?["Iskeeper"] as? Bool ?? false
                    var isCaptain1 = player1?["Iscaptain"] as? Bool ?? false
                    var batting1 = player1?["Batting"] as? [String:Any]
                    var battingStyle1 = batting1?["Style"] as? String ?? ""
                    var bowling1 = player1?["Bowling"] as? [String:Any]
                    var bowlingStyle1 = bowling1?["Style"] as? String ?? ""
                    
                    let Player1 = PlayerDetails()
                    Player1.name_full = full_name1
                    Player1.isKeeper = isKeeper1
                    Player1.isCaptain = isCaptain1
                    Player1.batting.style = battingStyle1
                    Player1.bowling.style = bowlingStyle1
                    
                    matchData.teamsData.four.players.player1 = Player1
                    
                    let player2 = players1?["3722"] as? [String:Any]
                    full_name1 = player2?["Name_Full"] as? String ?? ""
                    isKeeper1 = player2?["Iskeeper"] as? Bool ?? false
                    isCaptain1 = player2?["Iscaptain"] as? Bool ?? false
                    batting1 = player2?["Batting"] as? [String:Any]
                    battingStyle1 = batting1?["Style"] as? String ?? ""
                    bowling1 = player2?["Bowling"] as? [String:Any]
                    bowlingStyle1 = bowling1?["Style"] as? String ?? ""
                    
                    let Player2 = PlayerDetails()
                    Player2.name_full = full_name1
                    Player2.isKeeper = isKeeper1
                    Player2.isCaptain = isCaptain1
                    Player2.batting.style = battingStyle1
                    Player2.bowling.style = bowlingStyle1
                    
                    matchData.teamsData.four.players.player2 = Player2
                    
                    let player3 = players1?["3852"] as? [String:Any]
                    full_name1 = player3?["Name_Full"] as? String ?? ""
                    isKeeper1 = player3?["Iskeeper"] as? Bool ?? false
                    isCaptain1 = player3?["Iscaptain"] as? Bool ?? false
                    batting1 = player3?["Batting"] as? [String:Any]
                    battingStyle1 = batting1?["Style"] as? String ?? ""
                    bowling1 = player3?["Bowling"] as? [String:Any]
                    bowlingStyle1 = bowling1?["Style"] as? String ?? ""
                    
                    let Player3 = PlayerDetails()
                    Player3.name_full = full_name1
                    Player3.isKeeper = isKeeper1
                    Player3.isCaptain = isCaptain1
                    Player3.batting.style = battingStyle1
                    Player3.bowling.style = bowlingStyle1
                    
                    matchData.teamsData.four.players.player3 = Player3
                    
                    let player4 = players1?["4176"] as? [String:Any]
                    full_name1 = player4?["Name_Full"] as? String ?? ""
                    isKeeper1 = player4?["Iskeeper"] as? Bool ?? false
                    isCaptain1 = player4?["Iscaptain"] as? Bool ?? false
                    batting1 = player4?["Batting"] as? [String:Any]
                    battingStyle1 = batting1?["Style"] as? String ?? ""
                    bowling1 = player4?["Bowling"] as? [String:Any]
                    bowlingStyle1 = bowling1?["Style"] as? String ?? ""
                    
                    let Player4 = PlayerDetails()
                    Player4.name_full = full_name1
                    Player4.isKeeper = isKeeper1
                    Player4.isCaptain = isCaptain1
                    Player4.batting.style = battingStyle1
                    Player4.bowling.style = bowlingStyle1
                    
                    matchData.teamsData.four.players.player4 = Player4
                    
                    let player5 = players1?["4532"] as? [String:Any]
                    full_name1 = player5?["Name_Full"] as? String ?? ""
                    isKeeper1 = player5?["Iskeeper"] as? Bool ?? false
                    isCaptain1 = player5?["Iscaptain"] as? Bool ?? false
                    batting1 = player5?["Batting"] as? [String:Any]
                    battingStyle1 = batting1?["Style"] as? String ?? ""
                    bowling1 = player5?["Bowling"] as? [String:Any]
                    bowlingStyle1 = bowling1?["Style"] as? String ?? ""
                    
                    let Player5 = PlayerDetails()
                    Player5.name_full = full_name1
                    Player5.isKeeper = isKeeper1
                    Player5.isCaptain = isCaptain1
                    Player5.batting.style = battingStyle1
                    Player5.bowling.style = bowlingStyle1
                    
                    matchData.teamsData.four.players.player5 = Player5
                    
                    
                    /////////  team 2 - -----------------------------------------------------------------------
                    
                    let players1_2 = team_five?["Players"] as? [String:Any]
                    let player1_2 = players1_2?["3752"] as? [String:Any]
                    var full_name1_2 = player1_2?["Name_Full"] as? String ?? ""
                    var isKeeper1_2 = player1_2?["Iskeeper"] as? Bool ?? false
                    var isCaptain1_2 = player1_2?["Iscaptain"] as? Bool ?? false
                    var batting1_2 = player1_2?["Batting"] as? [String:Any]
                    var battingStyle1_2 = batting1_2?["Style"] as? String ?? ""
                    var bowling1_2 = player1_2?["Bowling"] as? [String:Any]
                    var bowlingStyle1_2 = bowling1_2?["Style"] as? String ?? ""
                    
                    let Player1_2 = PlayerDetails()
                    Player1_2.name_full = full_name1_2
                    Player1_2.isKeeper = isKeeper1_2
                    Player1_2.isCaptain = isCaptain1_2
                    Player1_2.batting.style = battingStyle1_2
                    Player1_2.bowling.style = bowlingStyle1_2
                    
                    matchData.teamsData.five.players.player1 = Player1_2
                    
                    
                    let player2_2 = players1_2?["4330"] as? [String:Any]
                    full_name1_2 = player2_2?["Name_Full"] as? String ?? ""
                    isKeeper1_2 = player2_2?["Iskeeper"] as? Bool ?? false
                    isCaptain1_2 = player2_2?["Iscaptain"] as? Bool ?? false
                    batting1_2 = player2_2?["Batting"] as? [String:Any]
                    battingStyle1_2 = batting1_2?["Style"] as? String ?? ""
                    bowling1_2 = player2_2?["Bowling"] as? [String:Any]
                    bowlingStyle1_2 = bowling1_2?["Style"] as? String ?? ""
                    
                    let Player2_2 = PlayerDetails()
                    Player2_2.name_full = full_name1_2
                    Player2_2.isKeeper = isKeeper1_2
                    Player2_2.isCaptain = isCaptain1_2
                    Player2_2.batting.style = battingStyle1_2
                    Player2_2.bowling.style = bowlingStyle1_2
                    
                    matchData.teamsData.five.players.player2 = Player2_2
                    
                    
                    let player3_2 = players1_2?["4338"] as? [String:Any]
                    full_name1_2 = player3_2?["Name_Full"] as? String ?? ""
                    isKeeper1_2 = player3_2?["Iskeeper"] as? Bool ?? false
                    isCaptain1_2 = player3_2?["Iscaptain"] as? Bool ?? false
                    batting1_2 = player3_2?["Batting"] as? [String:Any]
                    battingStyle1_2 = batting1_2?["Style"] as? String ?? ""
                    bowling1_2 = player3_2?["Bowling"] as? [String:Any]
                    bowlingStyle1_2 = bowling1_2?["Style"] as? String ?? ""
                    
                    let Player3_2 = PlayerDetails()
                    Player3_2.name_full = full_name1_2
                    Player3_2.isKeeper = isKeeper1_2
                    Player3_2.isCaptain = isCaptain1_2
                    Player3_2.batting.style = battingStyle1_2
                    Player3_2.bowling.style = bowlingStyle1_2
                    
                    matchData.teamsData.five.players.player3 = Player3_2
                    
                    let player4_2 = players1_2?["4964"] as? [String:Any]
                    full_name1_2 = player4_2?["Name_Full"] as? String ?? ""
                    isKeeper1_2 = player4_2?["Iskeeper"] as? Bool ?? false
                    isCaptain1_2 = player4_2?["Iscaptain"] as? Bool ?? false
                    batting1_2 = player4_2?["Batting"] as? [String:Any]
                    battingStyle1_2 = batting1_2?["Style"] as? String ?? ""
                    bowling1_2 = player4_2?["Bowling"] as? [String:Any]
                    bowlingStyle1_2 = bowling1_2?["Style"] as? String ?? ""
                    
                    let Player4_2 = PlayerDetails()
                    Player4_2.name_full = full_name1_2
                    Player4_2.isKeeper = isKeeper1_2
                    Player4_2.isCaptain = isCaptain1_2
                    Player4_2.batting.style = battingStyle1_2
                    Player4_2.bowling.style = bowlingStyle1_2
                    
                    matchData.teamsData.five.players.player4 = Player4_2
                    
                    let player5_2 = players1_2?["10167"] as? [String:Any]
                    full_name1_2 = player5_2?["Name_Full"] as? String ?? ""
                    isKeeper1_2 = player5_2?["Iskeeper"] as? Bool ?? false
                    isCaptain1_2 = player5_2?["Iscaptain"] as? Bool ?? false
                    batting1_2 = player5_2?["Batting"] as? [String:Any]
                    battingStyle1_2 = batting1_2?["Style"] as? String ?? ""
                    bowling1_2 = player5_2?["Bowling"] as? [String:Any]
                    bowlingStyle1_2 = bowling1_2?["Style"] as? String ?? ""
                    
                    let Player5_2 = PlayerDetails()
                    Player5_2.name_full = full_name1_2
                    Player5_2.isKeeper = isKeeper1_2
                    Player5_2.isCaptain = isCaptain1_2
                    Player5_2.batting.style = battingStyle1_2
                    Player5_2.bowling.style = bowlingStyle1_2
                    
                    matchData.teamsData.five.players.player5 = Player5_2
        
                    completion(matchData,nil)
                    
                } catch {
                    print("error Msg")
                    completion(nil, error)
                }
            }

        })
    }
    
}
