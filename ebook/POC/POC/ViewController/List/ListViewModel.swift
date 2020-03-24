//
//  ListViewModel.swift
//  POC
//
//  Created by Cheryl Chen on 2020/3/24.
//  Copyright © 2020 Cheryl Chen. All rights reserved.
//

import UIKit
import Alamofire

class ListViewModel: NSObject {

    var showIndicator: (() -> Void)?
    var hideIndicator: (() -> Void)?
    var reloadData: (() -> Void)?
    
    var cellViewModels: [User.Output] = []
    
    override init() {
        super.init()
        requestAllUsers()
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> User.Output {
        return cellViewModels[indexPath.row]
    }
    
    private func requestAllUsers() {
        showIndicator?()
        let params: Parameters = ["since": 0, "per_page": 100]
        Alamofire.request("https://api.github.com/users", parameters: params).responseJSON { [weak self] (response) in
            self?.hideIndicator?()
            switch response.result {
            case .success:
                self?.handleAllUsers(response: response)
            case .failure(let error):
                print("Failed to request AllUsers, error \(error.localizedDescription)")
            }
        }
    }
    
    private func handleAllUsers(response: DataResponse<Any>) {
        if let jsonArray = response.result.value as? [[String: Any]] {
            for json in jsonArray {
                let user = User.Output(login: json["login"] as? String ?? "",
                                       avatarURL: json["avatar_url"] as? String ?? "",
                                       siteAdmin: json["site_admin"] as? Bool ?? false)
                cellViewModels.append(user)
            }
            reloadData?()
        }
    }
}
