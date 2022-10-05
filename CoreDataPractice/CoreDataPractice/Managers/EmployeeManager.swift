//
//  File.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 05/10/2022.
//

import Foundation

struct EmployeeManager {
    
    private let _employeeDataRepository = EmployeeDataRepository()
    
    func createEmployee(employee: EmployeeModel) {
        _employeeDataRepository.create(employee: employee)
    }
    
    func fetchEmployee() -> [EmployeeModel]? {
        return _employeeDataRepository.getAll()
    }
    
    func fetchEmployee(byIndentifier id: UUID) -> EmployeeModel? {
        return _employeeDataRepository.get(byIndentifier: id)
    }
    
    func udpateEmployee(employee: EmployeeModel) -> Bool {
        return _employeeDataRepository.udpate(employee: employee)
    }
    
    func deleteEmployee(id: UUID) -> Bool {
        return _employeeDataRepository.delete(id: id)
    }
    
    
}
