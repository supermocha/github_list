//
//  ListViewModel.swift
//  POC
//
//  Created by Cheryl Chen on 2020/3/24.
//  Copyright © 2020 Cheryl Chen. All rights reserved.
//

import UIKit
import Alamofire
import RxSwift
import RxCocoa

class ListViewModel: NSObject {

    // MARK: - Publiv Variable
    //var showIndicator: (() -> Void)?
    //var hideIndicator: (() -> Void)?
    //var reloadData: (() -> Void)?
    
    public let isLoading     : PublishSubject<Bool> = PublishSubject()
    public let needReloadData: PublishSubject<Void> = PublishSubject()
    public let items         : PublishSubject<[User]> = PublishSubject()
    public let loader        : PublishSubject<Void> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    /*var numberOfItems: Int {
        return cellViewModels.count
    }
    
    // MARK: - Private Variable
    private var cellViewModels: [User] = [] {
        didSet {
          //reloadData?()
            needReloadData.onNext(())
        }
    }*/
    override init() {
        super.init()
        
        // load data
        loader
            .subscribe(onNext: { self.requestAllUsers() })
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - Public Function
    /*func load() {
        requestAllUsers()
    }*/
    
    /*func getCellViewModel(at indexPath: IndexPath) -> User {
        return cellViewModels[indexPath.row]
    }*/
    
    // MARK: - Request API
    private func requestAllUsers() {
        
        //showIndicator?()
        isLoading.onNext(true)
        
        let url = "https://api.github.com/users"
        let params = ["since": 0, "per_page": 100]
        
        Alamofire.request(url, parameters: params).responseData { [weak self] (data) in
            
            //self?.hideIndicator?()
            self?.isLoading.onNext(false)
    
            switch data.result {
            case .success:
                self?.handleAllUsers(data: data.result.value ?? Data())
            case .failure(let error):
                print("Failed to request AllUsers, error \(error.localizedDescription)")
            }
        }
    }
    
    private func handleAllUsers(data: Data) {
        do {
            let users = try JSONDecoder().decode([User].self, from: data)
            //users.forEach { cellViewModels.append($0) }
            items.onNext(users)
        } catch {
            print("Failed to decode json data, error \(error.localizedDescription)")
        }
    }
}
