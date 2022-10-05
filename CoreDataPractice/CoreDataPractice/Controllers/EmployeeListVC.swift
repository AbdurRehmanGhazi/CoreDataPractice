//
//  ViewController.swift
//  CoreDataPractice
//
//  Created by AbdurRehmanNineSol on 05/10/2022.
//

import UIKit

class EmployeeListVC: UIViewController {

    @IBOutlet weak var tblEmployee: UITableView!
    
    private let employeManager = EmployeeManager()
    private var employees: [EmployeeModel] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshList()
    }
    

    @IBAction func tapCreateButton(_ sender: UIButton) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateEmployeeVC") as! CreateEmployeeVC
        self.navigationController?.pushViewController(vc, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: Notification.Name("a"), object: nil)
    }
    
    @objc func refreshList() {
        employees = employeManager.fetchEmployee()!
        tblEmployee.reloadData()
        NotificationCenter.default.removeObserver(self, name: Notification.Name("a"), object: nil)
    }

}


extension EmployeeListVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableCell else { return UITableViewCell() }
        cell.name.text = employees[indexPath.row].name
        cell.img.image = UIImage(data: employees[indexPath.row].profilePic!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        vc.employee = employees[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshList), name: Notification.Name("a"), object: nil)
    }
}

class TableCell: UITableViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
}

