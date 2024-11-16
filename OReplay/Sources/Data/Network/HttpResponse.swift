import Foundation

final class HttpResponse: HttpResponseContract {
    
    enum StatusCodes: Int {
        case ok = 200
        case badRequest = 400
    }
    
    let code: Int
    let rawData: Data?
    
    // MARK: - Initializer
    init(_ code: Int, _ rawData: Data?) {
        self.code = code
        self.rawData = rawData
    }
    
    // MARK: - Public methods
    
    // Verifies that the response returned the specified status code
    func status(_ status: StatusCodes) -> Bool {
        code == status.rawValue
    }
    
    // Verifies that the response returned an status code 200
    func ok() -> Bool {
        status(.ok)
    }
    
    // Returns the response if it has a status code 200, nil otherwise
    func ifOk() -> Self? {
        ok() ? self : nil
    }
    
    // Tries to get the body of the response as a Decodable object
    func `as`<T: Decodable>(_ type: T.Type) -> T? {
        
        guard let rawData else { return nil }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        return try? decoder.decode(type, from: rawData)
        
    }
    
}
