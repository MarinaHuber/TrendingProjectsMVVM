//
//  DataViewModel.swift
//  TrendingProjectsMVVM
//
//  Created by Marina Huber on 9/19/20.
//  Copyright © 2020 Marina Huber. All rights reserved.
//

import  UIKit

class DataViewModel {
    
    var datas: [Repository] = [Repository]()
    var reloadTableView: (()->())?
    var showError: (()->())?
    var showLoading: (()->())?
    var hideLoading: (()->())?
    
    private var cellViewModels: [DataListCellViewModel] = [DataListCellViewModel]() {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func getData(){
        showLoading?()
        APIService.shared.getTrendingReposToday { [weak self] result in
            guard self != nil else { return }
            self?.hideLoading?()
            switch result {
                case .success(let repo):
                    self?.createCell(datas: repo)
                    self?.reloadTableView?()
                
                case .failure:
                    self?.showError?()
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> DataListCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(datas: [Repository]){
        self.datas = datas
        var vms = [DataListCellViewModel]()
        for data in datas {
            vms.append(DataListCellViewModel(titleText: data.name ?? "", subTitleText: data.description, starCount: data.stars))
        }
        cellViewModels = vms
    }
}

struct DataListCellViewModel {
    let titleText: String
    let subTitleText: String
    let starCount: Int
}
