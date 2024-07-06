//
//  AppError.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 6/07/24.
//

import Foundation

enum NetworkError: Error {
    case urlError
    case decodingError
    case networkError(description: String)
    case unknownError

    var localizedDescription: String {
        switch self {
        case .urlError:
            return "URL Invalida"
        case .decodingError:
            return "Hemos detectado un error en la url"
        case .networkError(let description):
            return description
        case .unknownError:
            return "An unknown error occurred. Please try again."
        }
    }
}

func handleError(_ error: NetworkError) {
    // Aquí puedes usar os_log u otro sistema de logging
    print("Error occurred: \(error.localizedDescription)")
}
