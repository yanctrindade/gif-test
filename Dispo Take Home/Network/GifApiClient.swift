import UIKit

public enum Result<Value> {
    case success(Value)
    case failure(Error)
}

class GifAPIClient {
  
    // MARK: - Properties
    private let baseURL = URL(string: "https://api.giphy.com/v1/gifs/")!
    private let session: URLSession
    
    // MARK: - Life Cycle
    public init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    
    // MARK: - Methods
    public func getTrendingGifs(completion: @escaping (_ result: Result<[GifObject]>) -> Void) {
        
        guard let requestURL = URL(string: "trending?api_key=\(Constants.giphyApiKey)&rating=pg", relativeTo: baseURL) else {
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let response = try decoder.decode(APIListResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(response.data))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    public func getGifById(_ id: String, completion: @escaping (_ result: Result<GifObject>) -> Void) {
        
        guard let requestURL = URL(string: "\(id)?api_key=\(Constants.giphyApiKey)", relativeTo: baseURL) else {
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let response = try decoder.decode(APIObjectResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(response.data))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    public func searchGifByText(_ text: String, completion: @escaping (_ result: Result<[GifObject]>) -> Void) {
        
        guard let requestURL = URL(string: "search?api_key=\(Constants.giphyApiKey)&q=\(text)&limit=25&lang=en&rating=pg", relativeTo: baseURL) else {
            return
        }
        
        let request = URLRequest(url: requestURL)
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    
                    let response = try decoder.decode(APIListResponse.self, from: data)
                    
                    DispatchQueue.main.async {
                        completion(.success(response.data))
                    }
                    
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } else if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}
