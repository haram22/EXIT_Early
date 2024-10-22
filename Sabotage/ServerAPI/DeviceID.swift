////
////  DeviceID.swift
////  Sabotage
////
////  Created by 김하람 on 1/1/24.
////
//import UIKit
////import TAKUUID
//import Foundation
//import SwiftUI
//
//func deviceIDPostRequest(with deviceId: String) {
//    guard let url = URL(string: "\(urlLink)user") else {
//        print("🚨 Invalid URL")
//        return
//    }
//    print("✅ Valid URL = \(url)")
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    
//    let body: [String: AnyHashable] = [
//        "deviceId": deviceId
//    ]
//    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//    let task = URLSession.shared.dataTask(with: request) { data, _, error in
//        // 오류 처리
//        if let error = error {
//            print("🚨 Error: \(error.localizedDescription)")
//            return
//        }
//        guard let data = data, !data.isEmpty else {
//            print("✅ [deviceIDPostRequest] No data returned from the server")
//            return
//        }
//        do {
//            if let response = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                if let data = response["data"] as? [String: Any] {
//                    if let id = data["id"] as? Int {
//                        UserDefaults.standard.set(id, forKey: "userID")
//                        
//                        print("ID: \(id)")
//                        print("USERID: \(UserDefaults.standard.integer(forKey: "userID"))")
//                    }
//                    if let nickname = data["nickname"] as? String {
//                        UserDefaults.standard.set(nickname, forKey: "nickname")
//                        if let storedNickname = UserDefaults.standard.string(forKey: "nickname") {
//                            print("nickname = \(storedNickname)")
//                        }
//                    }
//                }
//                print("✅ \(response)")
//            }
//        } catch {
//            print("🚨 JSON parsing error: ", error)
//        }
//    }
//    task.resume()
//}
//
//func initUUID() {
////    let uuidStorage = TAKUUIDStorage.sharedInstance()
////    uuidStorage.migrate()
////    if let uuid = uuidStorage.findOrCreate() {
////        print("🔑 = \(uuid)")
////        deviceIDPostRequest(with: uuid)
////    } else {
////        print("🔑 = nil")
////    }
//    
//}
//
