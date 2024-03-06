//
//  ViewController.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//

import UIKit
import Alamofire

class PetTableViewController: UITableViewController , AddPetDelegate{
    
    var pets: [Pet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pets"
        // Do any additional setup after loading the view.
        fetchPetsData()
        setupNavigationBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    // count the numbers of the cells
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    // cell for  row at
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath)
        
        // variable
        let pet = pets[indexPath.row]
        cell.textLabel?.text = pet.name

            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailPetController()
        detailVC.pet = pets[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let petToDelete = pets[indexPath.row]  // Get the book to delete
            NetworkManager.shared.deletePet(petID: petToDelete.id ?? 0) { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        // Remove the book from the data source
                        self?.pets.remove(at: indexPath.row)

                        // Delete the table view row
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    } else {
                        self?.showDeleteErrorAlert()
                    }
                }
            }
        }
    }
    func didAddPet() {
        fetchPetsData()
    }
    
    func showDeleteErrorAlert() {
        let alert = UIAlertController(title: "Error", message: "Can't delete pet", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func setupNavigationBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "info"),
            style: .plain,
            target: self,
            action: #selector(infoTapped)
            )
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "plus"),
            style: .plain,
            target: self,
            action: #selector(addPetTapped)
            )


    }
    
    @objc func infoTapped() {
        let instructionVC = AppInfoViewController()
        instructionVC.modalPresentationStyle = .popover
        self.present(instructionVC, animated: true)
     
    }
    
    @objc func addPetTapped(){
        
        let addPetVC = AddPetViewController()
        addPetVC.modalPresentationStyle = .formSheet
        self.present(addPetVC,animated: true)
    }

}

// MARK: extension for networking
extension PetTableViewController{
    
    func fetchPetsData(){
        
        NetworkManager.shared.fetchpets { fetchedPets in
            DispatchQueue.main.async {
                self.pets = fetchedPets ?? []
                self.tableView.reloadData() // update
            }
        }
    }
}



