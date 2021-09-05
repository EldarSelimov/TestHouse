//
//  NetworkDataFetcher.swift
//  TestForMobileHouse
//
//  Created by Eldar on 04.09.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkManger = NetworkManager.shared
    
    func fetchImages(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkManger.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Fail ==== \(jsonError)")
            return nil
        }
    }
    
}
