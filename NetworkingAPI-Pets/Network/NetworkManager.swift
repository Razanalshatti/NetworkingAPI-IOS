//
//  NetworkManager.swift
//  NetworkingAPI-Pets
//
//  Created by Razan alshatti on 04/03/2024.
//

import Foundation
import Alamofire

class NetworkManager{
    
    private let baseURL = "https://coded-pets-api-crud.eapi.joincoded.com/pets"
    
    // MARK: Singleton
    static let shared = NetworkManager()
    weak var addPetDelegate: AddPetDelegate?
    
    // delivery passing data
    func fetchpets(completion: @escaping([Pet]?) -> Void ){
        
        AF.request(baseURL).responseDecodable(of: [Pet].self) { response in
            
            switch response.result {
            case .success(let pets):
                completion(pets)
            case .failure(let pets):
                completion(nil)
            }
        }
    }
    
    
    func addPet(pet: Pet, completion: @escaping (Bool) -> Void) {
        AF.request(baseURL, method: .post, parameters: pet, encoder: JSONParameterEncoder.default).response { response in
            switch response.result {
                case .success:
                self.addPetDelegate?.didAddPet()
                    completion(true)
                case .failure(let error):
                    print(error)
                    completion(false)
            }
        }
    }
    
    func deletePet(petID: Int, completion: @escaping (Bool) -> Void) {
        AF.request("\(baseURL)/\(petID)", method: .delete).response { response in
            switch response.result {
            case .success:
                completion(true)
            case .failure(let error):
                print("Error occurred while deleting pet: \(error.localizedDescription)")
                completion(false)
            }
        }
    }
}


