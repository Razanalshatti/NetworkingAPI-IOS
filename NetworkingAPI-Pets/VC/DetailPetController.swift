//
//  DetailPetController.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//



import UIKit
import SnapKit
import Kingfisher

class DetailPetController: UIViewController {
    
    var pet: Pet?
    
    // UI Components
    let petNameLabel = UILabel()
    let petAgeLabel = UILabel()
    let petIDLabel = UILabel()
    let petAdoptedLabel = UILabel()
    let petGenderLabel = UILabel()
    let imageView = UIImageView()
    let infoContainerView = UIView()
    let titleLabel = UILabel()
    let lineView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Pet Details"
        setupUI()
        setupViews()
        setupLayout()
        configureWithPet()
    }
    
    // func for url image
    func setupUI() {
        let url = URL(string: pet?.image ?? "")
        imageView.kf.setImage(with: url)
    }
    
    //func for subiews
    func setupViews() {
        view.backgroundColor = .white
        
        petNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.text = "Pet Information"
        lineView.backgroundColor = .black
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor.black.cgColor
                
        
        view.addSubview(imageView)
        view.addSubview(infoContainerView)
        infoContainerView.addSubview(titleLabel)
        infoContainerView.addSubview(lineView)
        infoContainerView.addSubview(petNameLabel)
        infoContainerView.addSubview(petAgeLabel)
        infoContainerView.addSubview(petIDLabel)
        infoContainerView.addSubview(petAdoptedLabel)
        infoContainerView.addSubview(petGenderLabel)
        infoContainerView.backgroundColor = .secondarySystemBackground
        infoContainerView.layer.cornerRadius = 20
        infoContainerView.clipsToBounds = true
        infoContainerView.layer.borderWidth = 1
        infoContainerView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // func for constraints
    func setupLayout() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            //make.leading.trailing.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().offset(-10)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
        
        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(-50)
            make.centerX.bottom.equalToSuperview()
            make.width.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-70)
        }
        
        titleLabel.snp.makeConstraints { make in
                    make.top.equalTo(infoContainerView.snp.top).offset(10)
                    make.leading.trailing.equalToSuperview().inset(20)
                }
                
                lineView.snp.makeConstraints { make in
                    make.top.equalTo(titleLabel.snp.bottom).offset(5)
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(0.25)
                }
                
                petNameLabel.snp.makeConstraints { make in
                    make.centerX.equalTo(infoContainerView)
                    make.top.equalTo(lineView.snp.bottom).offset(20)
                }
                
                petAgeLabel.snp.makeConstraints { make in
                    make.centerX.equalTo(infoContainerView)
                    make.top.equalTo(petNameLabel.snp.bottom).offset(8)
                }
                
                petIDLabel.snp.makeConstraints { make in
                    make.centerX.equalTo(infoContainerView)
                    make.top.equalTo(petAgeLabel.snp.bottom).offset(8)
                }
                
                petAdoptedLabel.snp.makeConstraints { make in
                    make.centerX.equalTo(infoContainerView)
                    make.top.equalTo(petIDLabel.snp.bottom).offset(8)
                }
                
                petGenderLabel.snp.makeConstraints { make in
                    make.centerX.equalTo(infoContainerView)
                    make.top.equalTo(petAdoptedLabel.snp.bottom).offset(8)
                    make.bottom.equalToSuperview().inset(16)
                }
            }
            
    
    // func for pet info
    func configureWithPet() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        
        petNameLabel.text =  "Pet Name : \(pet?.name ?? "")"
        petGenderLabel.text = "Pet Gender : \(pet?.gender ?? "")"
        petAgeLabel.text = "Pet Age : \(pet?.age ?? 0)"
        petIDLabel.text = "Pet ID : \(pet?.id ?? 0)"
        
        if let pet = pet, pet.adopted {
            petAdoptedLabel.text = "Adoption Status: Adopted"
        } else {
            petAdoptedLabel.text = "Adoption Status: Not Adopted"
        }
    }
}
