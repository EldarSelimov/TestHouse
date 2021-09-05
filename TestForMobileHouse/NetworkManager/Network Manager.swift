//
//  Network Manager.swift
//  TestForMobileHouse
//
//  Created by Eldar on 03.09.2021.
//

import Foundation

class NetworkManager {
    
    static var shared = NetworkManager()
    
    private init() {}
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parameters = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.url(params: parameters)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "get"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
        
    }
    
    private func prepareHeader() -> [String: String]? {
        var headers = [String: String]()
        headers["Authorization"] = "Client-ID JuRONS90uZkNY7EhKI4dfA9AiOkm6P_Dg7ZCh14iftI"
        
        return headers
    }
    
    private func prepareParametrs(searchTerm: String?) -> [String: String] {
        var parameters = [String: String]()
        parameters["query"] = searchTerm
        parameters["page"] = String(2)
        parameters["per_page"] = String(60)
        return parameters
    }
    
    private func url(params: [String: String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1 )}
        return components.url!
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
            
        }
    }
}
