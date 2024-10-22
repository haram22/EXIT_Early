////
////  BannerAPI.swift
////  Sabotage
////
////  Created by 김하람 on 1/4/24.
////
//
//import Foundation
//var finalActionContent: String = ""
//
//func EjectionPostRequest() {
//    // 서버 링크가 유요한지 확인
//    guard let url = URL(string: "\(urlLink)ejection/\(userId)") else {
//        print("🚨 Invalid URL")
//        return
//    }
//    print("✅ Valid URL = \(url)")
//    print("🥹 userId = \(userId)")
//    var request = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
////    let body:[String: AnyHashable] = [
////        "category": category,
////        "content": content
////    ]
////    request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//    
//    let task = URLSession.shared.dataTask(with: request) { data, _, error in
//        if let error = error {
//            print("🚨 Error: \(error.localizedDescription)")
//            return
//        }
//        
//        guard let data = data, !data.isEmpty else {
//            print("✅ [actionPostRequest] No data returned from the server")
//            return
//        }
//        do {
//            // 데이터를 성공적으로 받은 경우, 해당 데이터를 JSON으로 파싱하기
//            let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
//            if let jsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: .prettyPrinted),
//               let convertString = String(data: jsonData, encoding: .utf8) {
//                print("✅ Success: \(convertString)")
//            } else {
//                print("✅ Success with JSON response: \(jsonResponse)")
//            }
//            // 메인 스레드에서 알림 전송
//            DispatchQueue.main.async {
//                 NotificationCenter.default.post(name: .addNotification, object: nil)
//                
//                print("✅ [actionPostRequest] Notification posted in actionPostRequest")
//            }
//        } catch {
//            print("🚨 Error parsing JSON: ", error)
//        }
//
//    }
//    task.resume()
//}
//struct BannerData: Codable {
//    var data: BannerContent
//}
//
//struct BannerContent: Codable {
//    var content: String
//    // 추가적으로 필요한 필드가 있으면 여기에 선언합니다.
//}
//
//// 함수 수정
////func getBannerActionData(completion: @escaping (String) -> Void) {
////    if let url = URL(string: "\(urlLink)actionItem/expose/\(userId)") {
////        let session = URLSession(configuration: .default)
////        let task = session.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("🚨 Error: \(error.localizedDescription)")
////                return
////            }
////            if let JSONdata = data {
////                let decoder = JSONDecoder()
////                do {
////                    let decodeData = try decoder.decode(BannerData.self, from: JSONdata)
////                    print("ram : \(decodeData)")
////                    print("content = \(decodeData.data.content)")
////                    DispatchQueue.main.async {
////                        completion(decodeData.data.content) // 비동기 작업의 결과를 반환합니다.
////                    }
////                } catch {
////                    print("🚨 JSON decoding error: \(error)")
////                }
////            }
////        }
////        task.resume()
////    }
////}
//
//func getBannerActionData() -> String{
////    var finalActionContent: String = ""
//    if let url = URL(string: "\(urlLink)actionItem/expose/\(userId)") {
//        let session = URLSession(configuration: .default)
//        let task = session.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("🚨 Error: \(error.localizedDescription)")
//                return
//            }
//            // JSON data를 가져온다. optional 풀어줘야 함
//            if let JSONdata = data {
//                let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
//            
//                // JSONDecoder 사용하기
//                let decoder = JSONDecoder() // initialize
//                do {
//                    let decodeData = try decoder.decode(BannerData.self, from: JSONdata)
//                    
//                    finalActionContent = decodeData.data.content
//                    print("ram : \(decodeData)")
//                    print("content = \(decodeData.data.content)")
//                } catch {
//                    print("🚨 JSON decoding error: \(error)")
//                }
//            }
//            print("---------> \(finalActionContent)")
//        }
//        task.resume()
//    }
//    return finalActionContent
//}
////func getBannerActionData(completion: @escaping (String) -> Void) {
////    if let url = URL(string: "\(urlLink)actionItem/expose/\(userId)") {
////        let session = URLSession(configuration: .default)
////        let task = session.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("🚨 Error: \(error.localizedDescription)")
////                completion("") // 오류 시 빈 문자열 반환
////                return
////            }
////
////            if let JSONdata = data {
////                let decoder = JSONDecoder()
////                do {
////                    let decodeData = try decoder.decode(BannerData.self, from: JSONdata)
////                    let content = decodeData.data.content
////                    print("content = \(content)")
////                    completion(content) // 성공 시 content 반환
////                } catch {
////                    print("🚨 JSON decoding error: \(error)")
////                    completion("") // 디코딩 오류 시 빈 문자열 반환
////                }
////            } else {
////                completion("") // 데이터 없음 시 빈 문자열 반환
////            }
////        }
////        task.resume()
////    } else {
////        completion("") // 유효하지 않은 URL 시 빈 문자열 반환
////    }
////}
//
////
////struct BannerData: Codable {
////    let message: String
////    let comment: String
////    let data: BannerItem
////    let successful: Bool
////}
////
////struct BannerItem: Codable {
////    let id: Int
////    let category: String
////    let content: String
////    let exposureCount: Int
////}
