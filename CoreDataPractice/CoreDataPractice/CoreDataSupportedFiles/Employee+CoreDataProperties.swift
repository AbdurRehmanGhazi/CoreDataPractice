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

}

extension Employee : Identifiable {

}
