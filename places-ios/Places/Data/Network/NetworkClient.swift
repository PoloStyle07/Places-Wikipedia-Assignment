//
//  NetworkClient.swift
//  Places
//
//  Created by Marc Janga on 23/07/2024.
//

import Foundation

enum NetworkError: Error {
    case internalError
    case responseFormatError
    case parseError
    case serverError(code: Int)
    case unknownError
}

protocol NetworkClientProtocol {
    func getRequest<Model: Decodable>(url: URL?) async -> Result<Model, NetworkError>
}

final class NetworkClient: NetworkClientProtocol {
    func getRequest<Model: Decodable>(url: URL?) async -> Result<Model, NetworkError> {

        guard let url = url else {
            return .failure(.internalError)
        }

        do {
            let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
            guard let response = response as? HTTPURLResponse else {
                return .failure(.responseFormatError)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(Model.self, from: data) else {
                    return .failure(.parseError)
                }
                return .success(decodedResponse)
            default:
                return .failure(.serverError(code: response.statusCode))
            }
        }
        catch {
            return .failure(.unknownError)
        }
    }
}
