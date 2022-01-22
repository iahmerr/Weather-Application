//
//  APIClient.swift
//  Weather Application
//
//  Created by Ahmer Hassan on 21/01/2022.
//

import Foundation

public protocol ApiService {
    func performRequest<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void)
}

public class APIClient {
    private let session = URLSession(configuration: .default)
    private func fetchFeed(request : URLRequest?, completion:@escaping (Result<Data,AppError>) -> Void) {
        
        guard let url = request?.url else {
            let error = AppError(error: "Not a valid Url")
            completion(.failure(error))
            return
        }
        
        let task = session.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                completion(.success(data))
            } else if let error = error {
                completion(.failure(AppError.init(error: error.localizedDescription)))
            }
        }
        task.resume()
    }
}

extension APIClient:ApiService {
    public func performRequest<T:Codable>(router: URLRequestConvertible, completionHandler: @escaping (Result<T,AppError>) -> Void) {
        
        if !Reachability.isConnectedToNetwork() { completionHandler(.failure(AppError(error: "Network is Busy")))
            return
        }

        self.fetchFeed(request: router.urlRequest()) { result in
            switch result {
            case .success(let data):
                do {
                    let decode = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decode))
                }catch let error {
                    print(error)
                    completionHandler(.failure(AppError(error:error.localizedDescription)))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
