//
//  DetailVC.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 05/10/2022.
//

import UIKit

class DetailVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imgProfilePicture: UIImageView!
    @IBOutlet weak var txtEmployeeName: UITextField!
    @IBOutlet weak var txtEmployeeEmailId: UITextField!

    var employee: EmployeeModel!
    private var employeeManager = EmployeeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillSetUp()
        // Do any additional setup after loading the view.
    }

    func viewWillSetUp()
    {
        imgProfilePicture.image = UIImage(data: employee.profilePic!)
        txtEmployeeName.text = employee.name
        txtEmployeeEmailId.text = employee.email
    }
  
    func getProfileImage() -> UIImage? {
        let homeSymbolConfiguration = UIImage.SymbolConfiguration(pointSize: 55, weight: .black)
        let homeImage = UIImage(systemName: "person.circle.fill", withConfiguration: homeSymbolConfiguration)
        return homeImage
    }
    
    @IBAction func updateButtonTapped(_ sender: Any) {
        
        if getProfileImage() != imgProfilePicture.image && !txtEmployeeName.text!.isEmpty && !txtEmployeeEmailId.text!.isEmpty {
            
            let employee = EmployeeModel(name: txtEmployeeName.text, email: txtEmployeeEmailId.text, profilePic: imgProfilePicture.image!.pngData(), id: employee.id)
            
            if employeeManager.udpateEmployee(employee: employee) {
                NotificationCenter.default.post(name: Notification.Name("a"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
            else {
                print("error updating an employee")
            }
        } else {
            print("First Complete...")
        }
    }

    // MARK: Delete button action
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        if employeeManager.deleteEmployee(id: employee.id) {
            NotificationCenter.default.post(name: Notification.Name("a"), object: nil)
            self.navigationController?.popViewController(animated: true)
        }
        else {
            print("error deleting an employee")
        }
    }

    // MARK: Select image tap gesture action
    @IBAction func selectImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .savedPhotosAlbum
        picker.delegate = self
        present(picker, animated: true)
    }

    // MARK: Private functions
    private func displayAlert(alertMessage:String)
    {
        let alert = UIAlertController(title: "Alert", message: alertMessage, preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }

    private func displayErrorAlert()
    {
        let errorAlert = UIAlertController(title: "Alert", message: "Something went wrong, please try again later", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        errorAlert.addAction(okAction)
        self.present(errorAlert, animated: true)
    }
    
}
