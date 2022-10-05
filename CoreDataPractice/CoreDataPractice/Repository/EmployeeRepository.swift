//
//  EmployeeRepository.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 04/10/2022.
//

import Foundation
import CoreData

protocol EmployeeRepository {
    
    func create(employee: EmployeeModel)
    func getAll() -> [EmployeeModel]?
    func get(byIndentifier id: UUID) -> EmployeeModel?
    func udpate(employee: EmployeeModel) -> Bool
    func delete(id: UUID) -> Bool
}

struct EmployeeDataRepository: EmployeeRepository {
    
    func create(employee: EmployeeModel) {
        let cdEmployee = Employee(context: PersistentStorage.shared.context)
        cdEmployee.name = employee.name
        cdEmployee.id = employee.id
        cdEmployee.email = employee.email
        cdEmployee.profilePic = employee.profilePic
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [EmployeeModel]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: Employee.self)
        
        var employees: [EmployeeModel] = []
        result?.forEach { eachEmployee in
            employees.append(eachEmployee.convertToEmployeeModel())
        }
        
        return employees
    }
    
    func get(byIndentifier id: UUID) -> EmployeeModel? {
        
        let result = getEmployee(byIdentifier: id)
        guard result != nil else { return nil}
        return result?.convertToEmployeeModel()
    }
    
    func udpate(employee: EmployeeModel) -> Bool {
    
        let updateEmployee = getEmployee(byIdentifier: employee.id)
        guard updateEmployee != nil else { return false}
        
        updateEmployee?.name = employee.name
        updateEmployee?.email = employee.email
        updateEmployee?.profilePic = employee.profilePic
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
       
        let deleteEmployee = getEmployee(byIdentifier: id)
        guard deleteEmployee != nil else { return false}
        
        PersistentStorage.shared.context.delete(deleteEmployee!)
        PersistentStorage.shared.saveContext()
          
        return true
    }
    
    func getEmployee(byIdentifier id: UUID) -> Employee? {
        
        let fetchResults = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id=%@", id as CVarArg)
        fetchResults.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchResults).first
            
            guard result != nil else { return nil}
            return result
        } catch let error {
            debugPrint(error)
        }
        return nil
    }
}
