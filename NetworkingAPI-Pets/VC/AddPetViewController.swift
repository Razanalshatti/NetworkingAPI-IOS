//
//  AddPetViewController.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//

import UIKit
import Eureka
import Alamofire

class AddPetViewController: FormViewController {
    
    var pet: Pet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForm()
        // Do any additional setup after loading the view.
    }
    private func setupForm() {
        form +++ Section("Add New Pet")
        <<< TextRow() { row in
            row.title = "Name"
            row.placeholder = "Enter pet name"
            row.tag = "Name"  // Tag used for accessing the row's value
        }.cellSetup { cell, row in
            cell.textField.autocapitalizationType = .words
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        
        <<< IntRow() { row in
            row.title = "Age"
            row.placeholder = "Enter pet age"
            row.tag = "Age"  // Tag used for accessing the row's value
        }.cellSetup { cell, row in
            cell.textField.autocapitalizationType = .words
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }

        <<< ActionSheetRow<String>() { row in
            row.title = "Adoption Status"
            row.selectorTitle = "Choose a status"
            row.options = ["Yes", "No"] // Display "Yes" and "No" options
            row.tag = "Adoption Status"
            row.value = "Choose"
        }.cellSetup { cell, row in
            cell.didSelect().self
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }

        
        <<< ActionSheetRow<String>() { row in
            row.title = "Gender"
            row.selectorTitle = "Choose Gender"
            row.options = ["Male","Female"]
            row.tag = "Gender"
            row.value = "Choose"
        }.cellSetup { cell, row in
            cell.didSelect().self
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }

        <<< URLRow(){ row in
            row.title = "Image Url"
            row.placeholder = "Enter URL"
            row.tag = "ImageURL"
        }.cellSetup { cell, row in
            cell.textField.autocapitalizationType = .words
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
        }.cellUpdate { cell, row in
            if !row.isValid {
                cell.titleLabel?.textColor = .red
            }
        }
        
        form +++ Section("")
        
        <<< ButtonRow() { row in
            row.title = "Add Pet"
        }.onCellSelection{ _ ,_ in self.submitTapped()}
    }
    
    // to display yes or no for adoption status
    func stringToBool(_ str: String) -> Bool?{
            let lowerCased = str.lowercased()
            if lowerCased == "yes"{
                return true
            }else if lowerCased == "no"{
                return false
            }
            else{
                return nil
            }
        }

    
    @objc func submitTapped() {
        
        let nameRow: TextRow? = form.rowBy(tag: "Name")
        let ageRow: IntRow? = form.rowBy(tag: "Age")
        let adoptionRow: ActionSheetRow<String>? = form.rowBy(tag: "Adoption Status")
        let genderRow: ActionSheetRow<String>? = form.rowBy(tag: "Gender")
        let imageUrlRow: URLRow? = form.rowBy(tag: "ImageURL")
        let name = nameRow?.value ?? ""
        let age = ageRow?.value ?? 0
        let adopted = adoptionRow?.value ?? "" // Corrected variable name to adoptionRow
        let gender = genderRow?.value ?? ""
        let imageUrl = imageUrlRow?.value?.absoluteString ?? ""
        let errors = form.validate()
           guard errors.isEmpty else {
               presentAlertWithTitle(title: "Error🚨", message: "Please fill out all fields📝.")
               return
           }
        
        if let adopted = stringToBool(adopted){
            let pet = Pet(name: name, adopted: adopted, image: imageUrl, age: Int(age), gender: gender)
            
            NetworkManager.shared.addPet(pet: pet) { success in
                DispatchQueue.main.async {
                    if success {
                        self.dismiss(animated: true, completion: nil)
                    } else {
                        // Handle submission error
                        print("error")
                    }
                }
            }
        }
    }
    
    private func presentAlertWithTitle(title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .default) { _ in
            completionHandler?()
        })
        self.present(alert, animated: true, completion: nil)
    }
}
