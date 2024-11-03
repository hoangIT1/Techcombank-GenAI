import Foundation

class MarketDetailViewModel: ObservableObject {
    @Published var summaryContent = "Nội dung summary"
    @Published var overviewContent = "Nội dung overview"
    @Published var competitionContent = "Nội dung competition"
    @Published var customersContent = "Nội dung customers"
    @Published var keyDataContent = "Nội dung keyData"
    
    // Dữ liệu mẫu hoặc thực hiện hàm loadData() để gọi API sau này
    init() {
        // loadData() sẽ được gọi khi có API
    }
}
