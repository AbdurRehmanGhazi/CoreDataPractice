//
//  Employee+CoreDataProperties.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 04/10/2022.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var profilePic: Data?
    
    func convertToEmployeeModel() -> EmployeeModel {
        return EmployeeModel(name: self.name, email: self.email, profilePic: self.profilePic, id: self.id!)
    }

}

extension Employee : Identifiable {

}
