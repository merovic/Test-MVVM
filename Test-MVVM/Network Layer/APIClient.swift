//
//  APIClient.swift
//  swiftui-mvvm
//
//  Created by Apple on 28/09/2021.
//

import Alamofire

class APIClient{
    
    @discardableResult
    static func performDecodableRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T,Error>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable(decoder: decoder){
                
                (response: DataResponse<T>) in
                
                completion(response.result)
                
            }
    }
    
    
    @discardableResult
    static func performStringRequest(route:APIRouter, completion: @escaping (Result<String, Error>)->Void) -> DataRequest {
        return AF.request(route)
            .responseString(encoding: String.Encoding.utf8) {
                
                (response) in
                
                completion(response.result)
                
            }
    }
    
}

