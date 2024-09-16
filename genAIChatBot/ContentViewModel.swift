import SwiftUI

@MainActor
class ContentViewModel: ObservableObject {
    
    @Published var message = ""
    @Published var chatMessages = [ChatMessage]()
    @Published var isWaitingForResponse = false

    let apiURL = "https://api-inference.huggingface.co/models/meta-llama/Meta-Llama-3-8B-Instruct/v1/chat/completions"
    let apiKey = "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"  
    
    func sendMessage() async throws {
        let userMessage = ChatMessage(owner: .user, message)
        chatMessages.append(userMessage)
        message = ""
        isWaitingForResponse = true
        
        let assistantMessage = ChatMessage(owner: .sigMO, "")
        chatMessages.append(assistantMessage)
        
        // Fetch the response from Hugging Face API
        if let responseText = try await fetchResponseFromAPI(message: userMessage.text) {
            if let lastMessage = chatMessages.last {
                let newMessage = ChatMessage(owner: .sigMO, responseText)
                chatMessages[chatMessages.count - 1] = newMessage
            }
        } 
        
        isWaitingForResponse = false
    }
    
    func fetchResponseFromAPI(message: String) async throws -> String? {
        guard let url = URL(string: apiURL) else {
            print("Invalid URL")
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // JSON payload
        let json: [String: Any] = [
            "model": "meta-llama/Meta-Llama-3-8B-Instruct",
            "messages": [
                ["role": "user", "content": message]
            ],
            "max_tokens": 500,
            "stream": false
        ]
        
        let jsonData = try JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData
        
        // Send HTTP request
        let (data, _) = try await URLSession.shared.data(for: request)
        
        // response
        if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let choices = jsonResponse["choices"] as? [[String: Any]],
           let messageContent = choices.first?["message"] as? [String: Any],
           let content = messageContent["content"] as? String {
            return content
        } else {
            return "No valid response from the API."
        }
    }
}
