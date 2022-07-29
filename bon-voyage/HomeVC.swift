//
//  ViewController.swift
//  bon-voyage
//
//  Created by DVKSH on 29.06.22.
//

import UIKit
import FirebaseAuth

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var vacations = [Vacation]()
    var selectedVacation: Vacation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Vacation Packages"
        vacations = demoData
        
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Auth.auth().addStateDidChangeListener { auth, user in
            // If there is user logged in, stay here on homeVC
            // else, take them to the login page
            
            if user == nil {
                let loginVC = LoginRegisterVC()
                loginVC.modalPresentationStyle = .fullScreen
                self.present(loginVC, animated: true)
            } else {
                UserManager.instance.getCurrentUser {
                    print(UserManager.instance.user?.email)
                }
            }
            
        }
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.contentInset.top = 8
        tableView.register(UINib(nibName: CellId.VacationCell, bundle: nil), forCellReuseIdentifier: CellId.VacationCell)
    }
    
    @IBAction func userIconClecked(_ sender: Any) {
        let userSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let logout = UIAlertAction(title:"Logout", style: .default) { action in
            // Logout
            do {
                try Auth.auth().signOut()
            }
            catch {
                debugPrint(error.localizedDescription)
            }
            
        }
        
        let manageCards = UIAlertAction(title: "Manage Credit Cards", style: .default) { action in
            
        }
        
        let manageBanks = UIAlertAction(title: "Manage Bank Account", style: .default) { action in
            
        }
        
        let close = UIAlertAction(title: "Close", style: .cancel)
        
        userSheet.addAction(manageCards)
        userSheet.addAction(manageBanks)
        userSheet.addAction(logout)
        userSheet.addAction(close)
        
        present(userSheet, animated: true)
        
        
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vacations.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.VacationCell, for: indexPath) as! VacationCell
        cell.configureCell(vacation: vacations[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedVacation = vacations[indexPath.row]
        performSegue(withIdentifier: SegueId.ToVacationDetails, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! VacationDetailsVC
        destination.vacation = selectedVacation
    }
}



