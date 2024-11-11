import Foundation
import Combine

class MarketDetailViewModel: ObservableObject {
    @Published var summaryContent = "Nội dung summary"
    @Published var overviewContent = "Nội dung overview"
    @Published var competitionContent = "Nội dung competition"
    @Published var customersContent = "Nội dung customers"
    @Published var keyDataContent = "Nội dung keyData"
    @Published var numberArticles = 0
    @Published var numberWords = 0
    
    @Published var isSummaryApiComplete: Bool = false
    @Published var isOverviewApiComplete: Bool = false
    @Published var isCompetitionApiComplete: Bool = false
    @Published var isCustomersApiComplete: Bool = false
    @Published var isKeyDataApiComplete: Bool = false
    
    

    // Hàm khởi tạo để gọi API khi có dữ liệu từ view
    func startResearch(industry: String, location: String, purpose: String) {
        // Gọi API đầu tiên
        callInitialAPI(industry: industry, location: location, purpose: purpose) {
            // Kiểm tra điều kiện để gọi các API tiếp theo
            if self.numberArticles != 0 {
                // Đặt bộ đếm thời gian 10 giây để gọi callConcurrentAPIs
                Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
                    self.callConcurrentAPIs(industry: industry, location: location, purpose: purpose)
                }
            }
        }
    }

    
    // Hàm gọi API đầu tiên để lấy numberArticles và numberWords
    private func callInitialAPI(industry: String, location: String, purpose: String, completion: @escaping () -> Void) {
        let url = URL(string: "https://6798-34-86-107-178.ngrok-free.app/query")!
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 600
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
            "queries": [
                ["industry": industry, "location": location, "purpose": purpose]
            ]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Lỗi khi gọi API đầu tiên: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let numberArticles = json["numberArticles"] as? Int,
                   let numberWords = json["numberWords"] as? Int {
                    DispatchQueue.main.async {
                        self.numberArticles = numberArticles
                        self.numberWords = numberWords
                        completion() // Gọi completion để bắt đầu các API còn lại
                    }
                }
            } catch {
                print("Lỗi parse JSON cho API đầu tiên: \(error)")
            }
        }
        task.resume()
    }
    
    // Hàm gọi đồng thời các API khác với từng URL và contentType
    private func callConcurrentAPIs(industry: String, location: String, purpose: String) {
        let dispatchGroup = DispatchGroup()

        // URL cho từng API
        let urls = [
            "https://7103-35-222-51-251.ngrok-free.app/query", // API 1: summaryContent
            "https://2c60-34-83-235-18.ngrok-free.app/query", // API 2: overviewContent
            "https://663e-34-83-25-83.ngrok-free.app/query", // API 3: competitionContent
            "https://4f6b-34-66-143-108.ngrok-free.app/query", // API 4: customersContent
            "https://d31e-34-72-74-117.ngrok-free.app/query"  // API 5: keyDataContent
        ]
        
        // API 1: summaryContent
        dispatchGroup.enter()
        callAPI(endpoint: urls[0], industry: industry, location: location, purpose: purpose, contentType: "summaryContent") {
            dispatchGroup.leave()
        }

        // API 2: overviewContent
        dispatchGroup.enter()
        callAPI(endpoint: urls[1], industry: industry, location: location, purpose: purpose, contentType: "overviewContent") {
            dispatchGroup.leave()
        }

        // API 3: competitionContent
        dispatchGroup.enter()
        callAPI(endpoint: urls[2], industry: industry, location: location, purpose: purpose, contentType: "competitionContent") {
            dispatchGroup.leave()
        }

        // API 4: customersContent
        dispatchGroup.enter()
        callAPI(endpoint: urls[3], industry: industry, location: location, purpose: purpose, contentType: "customersContent") {
            dispatchGroup.leave()
        }

        // API 5: keyDataContent
        dispatchGroup.enter()
        callAPI(endpoint: urls[4], industry: industry, location: location, purpose: purpose, contentType: "keyDataContent") {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            print("Tất cả các API đã hoàn thành.")
        }
    }
    
    // Hàm gọi API chung với endpoint và contentType để lấy nội dung tương ứng
    private func callAPI(endpoint: String, industry: String, location: String, purpose: String, contentType: String, completion: @escaping () -> Void) {
        guard let url = URL(string: endpoint) else { return }

        var request = URLRequest(url: url)
        request.timeoutInterval = 600
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestData: [String: Any] = [
            "queries": [
                ["industry": industry, "location": location, "purpose": purpose]
            ]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: requestData, options: [])

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print("Lỗi khi gọi \(contentType): \(error?.localizedDescription ?? "Unknown error")")
                completion()
                return
            }

            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let message = choices.first?["message"] as? [String: Any] {
                    
                    DispatchQueue.main.async {
                        switch contentType {
                        case "summaryContent":
                            self.summaryContent = message["summaryContent"] as? String ?? "Không có dữ liệu"
                            self.isSummaryApiComplete = true
                        case "overviewContent":
                            self.overviewContent = message["overviewContent"] as? String ?? "Không có dữ liệu"
                            self.isOverviewApiComplete = true
                        case "competitionContent":
                            self.competitionContent = message["competitionContent"] as? String ?? "Không có dữ liệu"
                            self.isCompetitionApiComplete = true
                        case "customersContent":
                            self.customersContent = message["customersContent"] as? String ?? "Không có dữ liệu"
                            self.isCustomersApiComplete = true
                        case "keyDataContent":
                            self.keyDataContent = message["keyDataContent"] as? String ?? "Không có dữ liệu"
                            self.isKeyDataApiComplete = true
                        default:
                            break
                        }
                        completion()
                    }
                }
                else {
                    print("Lỗi: Không có 'choices' hoặc 'message' trong JSON cho \(contentType)")
                    completion()
                }
            } catch {
                print("Lỗi parse JSON cho \(contentType): \(error)")
                completion()
            }
        }
        task.resume()
    }
}
