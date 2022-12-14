//
//  ProfileManager.swift
//  Bankey
//
//  Created by Tomasz Ogrodowski on 14/12/2022.
//

import Foundation

protocol ProfileManagerable: AnyObject {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkingError>) -> Void)
}

enum NetworkingError: Error {
    case serverError
    case decodingError
}

struct Profile: Codable {
    let id: String
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

class ProfileManager: ProfileManagerable  {
    func fetchProfile(forUserId userId: String, completion: @escaping (Result<Profile, NetworkingError>) -> Void) {
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/bankey/profile/\(userId)")!

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    completion(.failure(.serverError))
                    return
                }

                do {
                    let profile = try JSONDecoder().decode(Profile.self, from: data)
                    completion(.success(profile))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
        }.resume()
    }
}
