//
//  APICaller.swift
//  Sabotage
//
//  Created by 김하람 on 12/30/23.
//

import Foundation

import UIKit




var limitData: LimitDummyDataType? //초기값도 모르기 때문에 옵셔널 ? 붙여준다.

let urlLink = "http://119.202.103.118:8080/api/" // 서버 주소
let userId = UserDefaults.standard.string(forKey: "userID") ?? ""
let nickname = UserDefaults.standard.string(forKey: "nickname") ?? ""

// MARK: - Update _ 특정 데이터에 대한 값을 서버에 수정하는 함수
func makeUpdateRequest(with idName: String, name: String, age: Int, part: String, imgUrl: String) {
    guard let encodedName = idName.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
        print("Encoding failed")
        return
    }

    guard let url = URL(string: "\(urlLink)goalGroup/\(userId)") else {
        print("🚨 Invalid URL")
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "PATCH"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let body: [String: Any] = [
        "name": name,
        "age": age,
        "part": part,
        "imgURL": imgUrl
    ]

    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

    let task = URLSession.shared.dataTask(with: request) { data, _, error in
        guard let data = data, error == nil else {
            print("🚨 \(error?.localizedDescription ?? "Unknown error")")
            return
        }
        do {
            let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            print("✅ success: \(response)")
            DispatchQueue.main.async {
                DispatchQueue.main.async {
//                    NotificationCenter.default.post(name: .addNotification, object: nil)
                }
            }
        } catch {
            print("🚨 ", error)
        }
    }
    task.resume()
}
