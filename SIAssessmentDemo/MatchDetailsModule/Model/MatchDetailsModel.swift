//
//  MatchDetailsModel.swift
//  SIAssessmentDemo
//
//  Created by Zentech-038 on 24/05/23.
//

import Foundation

class MatchData {
    var matchDetail:MatchDetail = MatchDetail()
}

class MatchDetail {
    var teamHome:String = ""
    var teamAway:String = ""
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
                    
                    completion(matchData,nil)
                    
                    /*
                    if employeeArray?.count ?? 0 > 0 {
                        for member in employeeArray! {
                            let id = member["id"] as? Int ?? 0
                            let name = member["employee_name"] as? String ?? ""
                            let salary = member["employee_salary"] as? UInt64 ?? 0
                            let age = member["employee_age"] as? Int ?? 0
                            
                            let employee = Employee()
                            employee.id = id
                            employee.employeeName = name
                            employee.employeeSalary = salary
                            employee.employeeAge = age
                            
                            allEmployee.append(employee)
                        }
                       completion(allEmployee, nil)
                    } else {
                        completion(nil, nil)
                    } */
                } catch {
                    print("error Msg")
                    completion(nil, error)
                }
            }

        })
    }
    
}
