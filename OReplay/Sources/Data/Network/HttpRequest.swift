@preconcurrency import Combine
import Foundation
import Network

@DataActor
final class HTTPRequest: HTTPRequestContract {
    
    enum Method: String, Sendable {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    let url: String
    private var method: Method = .get
    private var headers: [String : String] = [:]
    private var body: Data?
    private var printCurl = UserDefaults.standard.bool(forKey: "printCurl")
    private var printResponse = UserDefaults.standard.bool(forKey: "printLog")
    private var cancellable: AnyCancellable?
    private(set) var urlSession: URLSessionContract = URLSession.shared
    private(set) var networkConexion = false
    
    // MARK: - Initializers
    init(_ path: String) {
        self.url = path
        configureNetworkMonitor()
    }
    
    convenience init(_ path: String, parameters: [String : String]?) {
        self.init("\(path)\(HTTPRequest.getQuery(parameters))")
    }
    
    deinit {
        cancellable?.cancel()
    }
    
    // MARK: - Public methods
    
    // Adds or updates a header of the request
    func header(_ name: String, _ value: String) -> Self {
        headers[name] = value
        return self
    }
    
    // Sets the method of the request
    func method(_ method: Method) -> Self {
        self.method = method
        return self
    }
    
    // Sets the request body
    func body(data: Data?) -> Self {
        body = data
        return self
    }
    
    func connect() async throws -> HTTPResponseContract {
        
        // Bail out at the beginning if the url is not valid
        guard let url = URL(string: url) else {
            throw HTTPError.invalidUrl
        }
        
        // 
        guard networkConexion else {
            throw HTTPError.noNetworkError
        }

        // Return the prepared request
        return try await prepareRequest(url)
        
    }
    
    // MARK: - Private methods
    @DataActor
    private func configureNetworkMonitor() {
        cancellable = NetworkMonitor.shared.$status.sink() { [weak self] status in
            self?.networkConexion = status == .connected
        }
    }
    
    private class func getQuery(_ parameters: [String : String]?) -> String {
        
        guard let parameters = parameters, !parameters.isEmpty else { return "" }
        var queryParameters: [String] = []
        
        for (key, value) in parameters {
            guard let encoded = value.addingPercentEncoding(withAllowedCharacters: .alphanumerics) else { continue }
            queryParameters.append("\(key)=\(encoded)")
        }
        
        return "?" + queryParameters.joined(separator: "&")
        
    }
    
    private func prepareRequest(_ url: URL) async throws -> HTTPResponseContract {
        
        // Create the request with its URL and method
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        // Add the request body
        request.httpBody = body
        
        // Add the headers
        for (name, value) in headers {
            request.setValue(value, forHTTPHeaderField: name)
        }
        
        #if DEBUG
        // Log the curl equivalent command if requested
        if printCurl {
            logCurl()
        }
        
        #endif
        return try await sendRequest(request)
        
    }
    
    private func sendRequest(_ request: URLRequest) async throws -> HTTPResponseContract {
        
        let (data, response) = try await urlSession.data(for: request)
        guard let response = response as? HTTPURLResponse else {
            throw HTTPError.unknownNetworkError
        }
        
        #if DEBUG
        if printResponse == true {
            logResponse(data: data, response: response)
        }
        #endif
        return HTTPResponse(response.statusCode, data)

    }
    
    #if DEBUG
    private func logCurl() {
        
        var components = [ "curl", "'\(url)'", "-X", method.rawValue ]
        
        for (name, value) in headers {
            components.append("-H")
            components.append("'\(name): \(value)'")
        }
        
        if let body = body, let bodyString = String(data: body, encoding: .utf8) {
            components.append("--data")
            components.append("'\(bodyString)'")
        }
        
        let curl = components.joined(separator: " ")
        
        print(curl)
        
    }
    
    private func logResponse(data: Data?, response: HTTPURLResponse) {
        
        var response = "HEADERS: \(response.allHeaderFields)\n\n"
        
        if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) {
            response += "RESPONSE: \(json)\n"
        }
        
        print(response)
        
    }
    #endif
    
}
