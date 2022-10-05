//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 04/10/2022.
//

import UIKit

class CreateEmployeeVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmployeeEmailId: UITextField!
    
    private let employeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        createEmployee()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        imgProfilePicture.image = getProfileImage()
//        let id = UUID()
//        employeeManager.createEmployee(employee: EmployeeModel(name: "Ali", email: "ali@gmail.com", profilePic: UIImage.init(named: "img")?.pngData(), id: id))
//        print("employee created")


//        let emp = employeeManager.udpateEmployee(employee: EmployeeModel(name: "Ali Khan", email: "alikhan@gmial.com", profilePic: UIImage.init(named: "img")?.pngData(), id: UUID(uuidString: "7164C9C4-473E-4F19-85A1-41DF5CEA8653")!))
        
        
//        let employees = employeeManager.fetchEmployee(byIndentifier: UUID(uuidString: "7164C9C4-473E-4F19-85A1-41DF5CEA8653")!)
//        print(employees)
        
//        let employe = employeeManager.deleteEmployee(id: UUID(uuidString: "98C8306E-CCFE-40EF-9892-10D73D3E6C97")!)
//        print(employe)
        
        
//        let employees = employeeManager.fetchEmployee()
//        print(employees?.count)
//        employees?.forEach({ emps in
//            print(emps)
//        })
        
    }
    
   
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: Image picker delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[.originalImage] as? UIImage
        self.imgProfilePicture.image = img

        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createEmployee(_ sender: UIButton) {
        if getProfileImage() != imgProfilePicture.image && !txtEmployeeName.text!.isEmpty && !txtEmployeeEmailId.text!.isEmpty {
            
            let employee = EmployeeModel(name: txtEmployeeName.text, email: txtEmployeeEmailId.text, profilePic: imgProfilePicture.image!.pngData(), id: UUID())
            employeeManager.createEmployee(employee: employee)
            NotificationCenter.default.post(name: Notification.Name("a"), object: nil)
            self.navigationController?.popViewController(animated: true)
        } else {
            print("First Complete...")
        }
    }

    func getProfileImage() -> UIImage? {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let homeImage = UIImage(systemName: "person.circle.fill", withConfiguration: homeSymbolConfiguration)
        return homeImage
    }
}

