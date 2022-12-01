//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Viktor on 01.12.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()

    private func createURLRequest(for endpoint: Endpoint) -> URLRequest? {
        var urlComponents = URLComponents(string: endpoint.baseURL)
        urlComponents?.path = endpoint.path
        urlComponents?.queryItems = endpoint.queryItem
        guard let url = urlComponents?.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        return urlRequest
    }

    func fetchData<T:Decodable>(for endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        guard let request = createURLRequest(for: endpoint) else { return }
        urlSession(request: request) { (result: Result<Data, Error>) in
            switch result {
            case .success(let data):
                let json = JSONDecoder()
                json.dateDecodingStrategy = .secondsSince1970
                do {
                    let decodedData = try json.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchImageContent(for endpoint: Endpoint, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let request = createURLRequest(for: endpoint) else { return }
        urlSession(request: request, completion: completion)
    }

    private func urlSession (request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200...299:
                    guard let data = data else { return }
                    completion(.success(data))
                default:
                    guard let error = error else { return }
                    completion(.failure(error))
                }
            }
            guard let error = error else { return }
            completion(.failure(error))
        }
        .resume()
    }
}

