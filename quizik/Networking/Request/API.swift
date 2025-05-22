//
//  API.swift
//  quizik
//
//  Created by Revolutic on 22/05/2025.
//  Copyright © 2025 Revolutic LLC. All rights reserved.
//

//import Foundation
//
//enum API: String {
//    
//    //        // Query item
//    //        let queryItem = [ URLQueryItem(name: "keyName", value: "ValueName") ]
//    //
//    //        /*
//    //        // Body as string
//    //        let bodyString = "yourParameterString"
//    //        let body = bodyString.data(using: .utf8) */
//    //
//    //        // Body as dictionary
//    //        let parameters : [String : Any] = [ "key1" : "value1", "key2": "value2" ]
//    //        guard let body = try? JSONSerialization.data(withJSONObject: parameters) else { return }
//    //
//    //        // Headers
//    //        let headers: [String: String] = [ "Header-key1": "value1",
//    //                                          "Header-key2": "value2" ]
//    
//    //Login
//    case LOGIN_API = "/auth-service/oauth/token"
//    
//    //unit
//    case UNIT_API = "/patient-service/patient-unit/getUnit"
//    
//    //Summary
//    case DEVICE_LIST_API = "/patient-service/patient/getdevices"
//    
//    case ECG_SUMMARY_API = "/ecg-service/ecg-data/latest"
//    
//    case BP_SUMMARY_API = "/bp-service/bp/latest"
//    
//    case PPG_SUMMARY_API = "/ppg-service/ppg-data/latest"
//    
//    case THERMOMETER_SUMMARY_API = "/thermometer-service/thermometerdata/latest"
//    
//    case GLUCOSE_SUMMARY_API = "/glucometer-service/glucometer-data/latest"
//    
//    case BODYSCALE_SUMMARY_API = "/bodyscale-service/bodyscale-data/latest"
//    
//    case WEIGHTSCALE_SUMMARY_API = "/weight-service/weight-data/latest"
//    
//    //Notification Alert
//    
//    case NOTIFICATION_ECG_ALERT_API = "/ecg-service/ecg-data/notifications/alert"
//    
//    case NOTIFICATION_PPG_ALERT_API = "/ppg-service/ppg-data/notifications/alert"
//    
//    case NOTIFICATION_GLUCOMETER_ALERT_API = "/glucometer-service/glucometer-data/notifications/alert"
//    
//    case NOTIFICATION_BP_ALERT_API = "/bp-service/bp/notifications/alert"
//    
//    case NOTIFICATION_THERMOMETER_ALERT_API = "/thermometer-service/thermometerdata/notifications/alert"
//    
//    case NOTIFICATION_WEIGHTSCALE_ALERT_API = "/weight-service/weight-data/notifications/alert"
//    
//    case NOTIFICATION_BODYSCALE_ALERT_API = "/bodyscale-service/bodyscale-data/notifications/alert"
//    
//    //Notification Borderline
//    
//    case NOTIFICATION_ECG_BORDERLINE_API = "/ecg-service/ecg-data/notifications/borderline"
//    
//    case NOTIFICATION_PPG_BORDERLINE_API = "/ppg-service/ppg-data/notifications/borderline"
//    
//    case NOTIFICATION_GLUCOMETER_BORDERLINE_API = "/glucometer-service/glucometer-data/notifications/borderline"
//    
//    case NOTIFICATION_BP_BORDERLINE_API = "/bp-service/bp/notifications/borderline"
//    
//    case NOTIFICATION_THERMOMETER_BORDERLINE_API = "/thermometer-service/thermometerdata/notifications/borderline"
//    
//    case NOTIFICATION_WEIGHTSCALE_BORDERLINE_API = "/weight-service/weight-data/notifications/borderline"
//    
//    case NOTIFICATION_BODYSCALE_BORDERLINE_API = "/bodyscale-service/bodyscale-data/notifications/borderline"
//    
//    
//    func getHeader()->[String:String]{
//        
//        if self == .LOGIN_API{
//            let credentialData = "\(USERNAME):\(PASSWORD)".data(using: .utf8)
//            guard let cred = credentialData else { return ["" : ""] }
//            let base64Credentials = cred.base64EncodedData(options: [])
//            guard let base64Date = Data(base64Encoded: base64Credentials) else { return ["" : ""] }
//            return ["Authorization": "Basic \(base64Date.base64EncodedString())","Content-Type": "application/x-www-form-urlencoded"]
//        }else{
//            
//            var tokenType = ""
//            var token = ""
//            
//            if let oAuth = UserDefaults.standard.decode(for: LoginModel.self, using: .LoginModel){
//                
//                if let tokenTypeValue = oAuth.token_type{
//                    tokenType = tokenTypeValue
//                }
//                
//                if let tokenValue = oAuth.access_token{
//                    token = tokenValue
//                }
//                
//            }
//            
//            return ["Authorization": "\(tokenType) \(token)"]
//        }
//        
//    }
//    
//    func addEncoding(params : [String : String])-> Data{
//        
//        if self == .LOGIN_API{
//            let jsonString = params.reduce("") { "\($0)\($1.0)=\($1.1)&" }
//            
//            guard let body = try? jsonString.data(using: .utf8, allowLossyConversion: false) else { return Data()}
//            
//            return body
//            
//        }else{
//            guard let body = try? JSONSerialization.data(withJSONObject: params) else { return Data() }
//            
//            return body
//        }
//        
//    }
//    
//    // To get the API endpoint with request setup
//    func getAPIEndpoint(queryItems: [URLQueryItem] = [], headers: HTTPHeaders = [ : ], body : Data = Data(),httpMethod : HTTPMethod) -> Endpoint {
//        
//        let pathValue = self.rawValue
//        
//        return Endpoint(path: pathValue, httpMethod: httpMethod, headers: headers, body: body, queryItems: queryItems)
//    }
//}
