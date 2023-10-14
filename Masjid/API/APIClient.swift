//
//  APIClient.swift
//  Masjid
//
//  Created by Bawer Bajelori on 3/29/23.
//

import Foundation
extension API {
    class Client{
        static let shared = Client()
        private let encoder = JSONEncoder()
        private let decoder = JSONDecoder()
        func fetch<Request, Response> (
            _ endpoint: Types.EndPoint,
            method: Types.Method,
            body: Request? = nil,
            then callback:((Result<Response, Types.Error>)->Void)? = nil
        ) where Request:  Encodable, Response: Decodable{
            var urlRequest = URLRequest(url: endpoint.url)
            urlRequest.httpMethod = method.rawValue
            if let body = body{
                do{
                    urlRequest.httpBody = try encoder.encode(body)
                } catch{
                    callback?(.failure(.internal(reason: "could not encode body")))
                    return
                }
            }
            let dataTask = URLSession.shared
                .dataTask(with: urlRequest) {data, response, error in
                    if let error = error{
                        print("fetch error: \(error)")
                        callback?(.failure(.generic(reason: "could not fetch  data: \(error.localizedDescription)")))
                        
                    } else{
                        if let data = data {
                            do{
                                let result = try self.decoder.decode(Response.self, from: data)
                                callback?(.success(result))
                            } catch {
                                callback?(.failure(.generic(reason: "could not decode data: \(error.localizedDescription)")))
                            }
                        }
                    }
                }
            dataTask.resume()
            
        }
        func get<Response>(_ endpoint: Types.EndPoint, then  callback: ((Result<Response, Types.Error>)->Void)? = nil
        ) where Response: Decodable{
            let body: Types.Request.Empty?=nil
            fetch(endpoint, method: .get, body: body){ result in
                callback?(result)
            }
        }
        
        
    }
    
}
