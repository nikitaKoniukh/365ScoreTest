//
//  FutureGameViewModel.swift
//  365ScoreTest
//
//  Created by Nikita Koniukh on 03/09/2021.
//

import Foundation

class FutureGameViewModel: NSObject {
    private var employeeService: APIServiceProtocol

    init(employeeService: APIServiceProtocol = APIService()) {
        self.employeeService = employeeService
    }
    
    func getChampionship() {
        employeeService.fetcChampionship { result in
            switch result {
            case .success(let champ):
                self.fetchData(champ: champ)
                break
            default: break
            }
            
        }
    }
    
}
