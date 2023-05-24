//
//  MatchDetailsModel.swift
//  SIAssessmentDemo
//
//  Created by Zentech-038 on 24/05/23.
//

import Foundation

class MatchData {
    var matchDetail:MatchDetail = MatchDetail()
    var teamsData:Teams = Teams()
}

class MatchDetail {
    var teamHome:String = ""
    var teamAway:String = ""
    var match:Match = Match()
}

class Match{
    var date:String = ""
    var time:String = ""
}

class Teams {
    var four:TeamDetail = TeamDetail()
    var five:TeamDetail = TeamDetail()
}

class TeamDetail {
    var nameFull:String = ""
    var nameShort:String = ""
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
                    
                    let teams = json?["Teams"] as? [String:Any]
                    let team_four = teams?["4"] as? [String:Any]
                    let team_five = teams?["5"] as? [String:Any]
                    
                    let teamData1 = TeamDetail()
                    teamData1.nameFull = team_four?["Name_Full"] as? String ?? ""
                    
                    let teamData2 = TeamDetail()
                    teamData2.nameFull = team_five?["Name_Full"] as? String ?? ""
                    
                    let Teams = Teams()
                    Teams.four = teamData1
                    Teams.five = teamData2
                    
                    matchData.teamsData = Teams
                    completion(matchData,nil)
                    
                } catch {
                    print("error Msg")
                    completion(nil, error)
                }
            }

        })
    }
    
}
