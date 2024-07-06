//
//  ApiNetWork.swift
//  mercadolibreChallenge
//
//  Created by Julian Carvajal on 3/07/24.
//

import Foundation

class ApiNetWork{
    
    //Parceamos en un modelo swift desde el json del api
    
    struct Wrapper:Codable{
        let site_id:String
        let results:[Product]
    }
    
    //Identifable nos sirve para representar una lista.
    struct Product:Codable, Identifiable{
        let id:String
        let title:String
        let categoryId:String
        let thumbnail:String
        let domainId: String
        let price: Double
        
        enum CodingKeys: String, CodingKey {
            case domainId = "domain_id"
            case categoryId = "category_id"
            case id, title,thumbnail, price
        }
    }
    
    func getProductByQuery(query:String) async throws -> Wrapper{
        //Toca controlar el signo de admiración !, porque le estamos diciendo que si o si esa url existe y si no?
        //        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?category=\(query)")!
        //        let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(query)%20")!
        
        //        let (data, _) = try await URLSession.shared.data(from: url)
        //
        //        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
        //
        //        return wrapper
        
        guard let url = URL(string: "https://api.mercadolibre.com/sites/MLA/search?q=\(query)%20") else {
            throw NetworkError.urlError
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let wrapper = try JSONDecoder().decode(Wrapper.self, from: data)
            return wrapper
        } catch is URLError {
            throw NetworkError.networkError(description: "Ha ocurrido un error, revisa tu red")
        } catch is DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.unknownError
        }
        
    }
}
