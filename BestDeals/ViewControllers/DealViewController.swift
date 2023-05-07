//
//  DealViewController.swift
//  BestDeals
//
//  Created by J Eff on 08.05.2023.
//

import UIKit

let dealURL = URL(string: "https://www.cheapshark.com/api/1.0/deals?storeID=1&upperPrice=15")!

enum Alert {
    case success
    case failed
    
    var title: String {
        switch self {
        case .success:
            return "Success"
        case .failed:
            return "Failed"
        }
    }
    
    var message: String {
        switch self {
        case .success:
            return "You can see the results in the Debug area"
        case .failed:
            return "You can see error in the Debug area"
        }
    }
}

final class DealViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDeal()
    }
    
    // MARK: - Private Methods
    private func showAlert(withStatus status: Alert) {
        let alert = UIAlertController(title: status.title, message: status.message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        DispatchQueue.main.async { [unowned self] in
            present(alert, animated: true)
        }
    }
}

// MARK: - Networking
extension DealViewController {
    private func fetchDeal() {
        URLSession.shared.dataTask(with: dealURL) { data, _, error in
            guard let data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let deal = try decoder.decode(Deal.self, from: data)
                print(deal)
                self.showAlert(withStatus: .success)
            } catch {
                print(error.localizedDescription)
                self.showAlert(withStatus: .failed)
            }
        }.resume()
    }
}
