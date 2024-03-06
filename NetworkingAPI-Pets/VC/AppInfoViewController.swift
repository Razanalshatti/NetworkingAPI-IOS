//
//  AppInfoViewController.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//

import UIKit

class AppInfoViewController: UIViewController {
    
    let AppLabel = UILabel()
    let infoLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        subview()
        setupUI()
        textStyle()
        AutoLayout()
        
        // Do any additional setup after loading the view.
      
    }
    
    func subview(){
        view.addSubview(AppLabel)
        view.addSubview(infoLabel)
    }
    
    func setupUI(){
        AppLabel.text = "My Pet App 📲"
        AppLabel.textColor = .black
        AppLabel.font = UIFont(name: "Times New Roman", size: 16)

        //AppLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        
        infoLabel.font = UIFont(name: "Times New Roman", size: 16)
        infoLabel.text = "The Pets app is like a fun game where you can learn all about different pets🐈🦮.\n It tells you their names, if they're boys or girl 👧🏻👦🏻 ,\n how old they are, and if they've found a family👨‍👩‍👧‍👦. \n And the best part? It shows cool pictures of all the pets🖼️! \n It's like having your own pet adventure right on your phone📱, \n and it's super easy to use! "
        infoLabel.textColor = .black
        
   }
    func textStyle(){
        let text = "The Pets app is like a fun game where you can learn all about different pets🐈🦮. It tells you their names, if they're boys or girl 👧🏻👦🏻 , how old they are, and if they've found a family👨‍👩‍👧‍👦. And the best part? It shows cool pictures of all the pets🖼️! It's like having your own pet adventure right on your phone📱, and it's super easy to use! "

        // Define the paragraph style with line spacing
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 8 // Adjust the line spacing as needed

        // Apply the paragraph style to the attributed string
        let attributedString = NSAttributedString(string: text, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])

        // Set the attributed text with adjusted line spacing
        infoLabel.attributedText = attributedString

        // Set the number of lines to 0 to allow wrapping
        infoLabel.numberOfLines = 0
    }
    
    func AutoLayout(){
        AppLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalToSuperview()
        }
        infoLabel.snp.makeConstraints { make in
            make.top.equalTo(AppLabel.snp.bottom).offset(80)
                make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
                make.trailing.equalTo(view.safeAreaLayoutGuide).offset(-20)

        }
    }


}
