//
//  Network.swift
//  SSLPinningTest
//
//  Created by Zentech-038 on 13/10/22.
//

import Foundation
import UIKit
import Security
import CommonCrypto


class NetworkRequest: NSObject, URLSessionDelegate {
        
    static let shared = NetworkRequest()
        
    //var certificatePublicKeys:[String] = ["i7WTqTvh0OioIruIfFR4kMPnBqrS2rdiVPl/s2uC/CY="]

    var certificatePublicKeys:[String] = ["i7WTqTvh0OioIruIfFR4kMPnBqrS2rdiVPl/s2uC/CY="]
        
        let rsa2048Asn1Header:[UInt8] = [
            0x30, 0x82, 0x01, 0x22, 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86,
            0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00, 0x03, 0x82, 0x01, 0x0f, 0x00
        ]
        
        private func sha256(data : Data) -> String {
            var keyWithHeader = Data(rsa2048Asn1Header)
            keyWithHeader.append(data)
            
            var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
            keyWithHeader.withUnsafeBytes {
                _ = CC_SHA256($0, CC_LONG(keyWithHeader.count), &hash)
            }
            return Data(hash).base64EncodedString()
        }
    
    
    //MARK: HTTP POST , GET , PUT , DELETE METHODS
    
    func getRequest(urlString: String, completion: @escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        let token = UserDefaults.standard.value(forKey: "jwtToken") as? String ?? ""
        
        if let url = URL(string: urlString) {
            
            //Configure request.
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            request.httpMethod = "GET"
            
            //let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
            let session = URLSession(configuration: .default)
            let sessionDataTask = session.dataTask(with: request, completionHandler: {
                (data:Data?, response:URLResponse?, error:Error?) in
                
                if error != nil {
                    
                    //Manage error.
                    completion(nil, error!)
                    
                } else {
                    
                    //Data received.
                    guard let data = data,
                            let response = response as? HTTPURLResponse,
                            error == nil
                        else {
                            print("error", error ?? URLError(.badServerResponse))
                            return
                        }
                    
                    if response.statusCode == 200 {
                        print("HTTP Success")
                    } else {
                        print("HTTP Error code = \(response.statusCode)")
                        if response.statusCode == 401 {
                            // self.logoutDueToTimeout()
                        }
                    }
                    
                    if let json = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
                        print("Data received = \(json)")
                    } else {
                        print(data)
                    }
                    completion(data, nil)
                }
            })
            sessionDataTask.resume()
        }
    }
    
    
    func postRequest(urlString: String, params:[String:Any], completion: @escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        let token = UserDefaults.standard.value(forKey: "jwtToken") as? String ?? ""
        
        guard let serviceUrl = URL(string: urlString) else { return }
        let parameterDictionary = params
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        //let session = URLSession(configuration: .default)
        session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                
                //Manage error.
                completion(nil, error!)
                
            } else {
                
                //Data received.
                guard let data = data,
                        let response = response as? HTTPURLResponse,
                        error == nil
                    else {
                        print("error", error ?? URLError(.badServerResponse))
                        return
                    }
                
                if response.statusCode == 200 {
                    print("HTTP Success")
                } else {
                    print("HTTP Error code = \(response.statusCode)")
                    if response.statusCode == 401 {
                        // self.logoutDueToTimeout()
                    }
                }
                
                if let json = try? JSONSerialization.jsonObject(with: data) as? [String:String] {
                    print("Data received = \(json)")
                } else {
                    print(data)
                }
                completion(data, nil)
            }
        }.resume()
    }
    
    
    //MARK: Put Request
    func putRequest(urlString: String, params:[String:Any], completion: @escaping (_ data:Data?, _ error:Error?) -> Void) {
        
        let token = UserDefaults.standard.value(forKey: "jwtToken") as? String ?? ""

        let parameterDictionary = params
        
        guard let url = URL(string: urlString) else {
            print("Error: cannot create URL")
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                print("Error: error calling PUT")
                print(error!)
                completion(nil,error)
                return
            }
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                print("Error: HTTP request failed")
                if (response as? HTTPURLResponse)?.statusCode == 401 {
                   // self.logoutDueToTimeout()
                }
                return
            }
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
                completion(data, nil)
            } catch {
                print("Error: Trying to convert JSON data to string")
                completion(nil, error)
                return
            }
        }.resume()
    }
    
    //MARK: Delete Request
    func deleteRequest(urlString: String, completion: @escaping (_ data:Data?, _ error:Error?) -> Void) {
        
            let token = UserDefaults.standard.value(forKey: "jwtToken") as? String ?? ""

            guard let url = URL(string: urlString) else {
                print("Error: cannot create URL")
                return
            }
            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling DELETE")
                    print(error!)
                    completion(nil,error)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    if (response as? HTTPURLResponse)?.statusCode == 401 {
                        // self.logoutDueToTimeout()
                    }
                    return
                }
                do {
                    guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                        print("Error: Cannot convert data to JSON")
                        return
                    }
                    guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                        print("Error: Cannot convert JSON object to Pretty JSON data")
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                        print("Error: Could print JSON in String")
                        return
                    }
                    
                    print(prettyPrintedJson)
                    completion(data, nil)
                } catch {
                    print("Error: Trying to convert JSON data to string")
                    completion(nil, error)
                    return
                }
            }.resume()
        }
    
    
    
    
    //MARK: URLSession Delegate methods
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge,nil)
            return
        }
        
        if let certificate =  SecTrustGetCertificateAtIndex(serverTrust, 2) {
            
            let serverPublicKey = SecCertificateCopyKey(certificate)
            let serverPublicKeyData = SecKeyCopyExternalRepresentation(serverPublicKey!, nil)
            let data:Data = serverPublicKeyData as! Data
            let serverHashKey = sha256(data: data)
            if certificatePublicKeys.contains(serverHashKey) {
                print("Public Key Pinning completed successfully")
                completionHandler(.useCredential, URLCredential.init(trust: serverTrust))
            }else{
                print("ssl pinning - key comparison failed")
                completionHandler(.cancelAuthenticationChallenge,nil)
                
            }
        }
    }
    
}


extension UIApplication{
class func getPresentedViewController() -> UIViewController? {
    var presentViewController = UIApplication.shared.keyWindow?.rootViewController
    while let pVC = presentViewController?.presentedViewController
    {
        presentViewController = pVC
    }
    return presentViewController
  }
}
