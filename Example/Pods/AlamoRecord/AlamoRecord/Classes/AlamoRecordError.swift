/*
 
 The MIT License (MIT)
 Copyright (c) 2017 Tunespeak
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */
import Foundation

open class AlamoRecordError: Error {
    
    /// The error of the failed request
    public let error: Error?
    
    // The HTTP Status Code of the request as an enum
    public let statusCode: HTTPStatusCode
    
    required public init(error: Error, statusCode: Int?) {
        self.error = error
        self.statusCode = HTTPStatusCode(rawValue: statusCode ?? -1) ?? .unknown
    }
    
    public required init(from decoder: Decoder) throws {
        error = nil
        statusCode = .unknown
    }

}

extension AlamoRecordError: Codable {
    open func encode(to encoder: Encoder) throws {}
}

extension AlamoRecordError: CustomStringConvertible {
    
    open var description: String {
        guard let error = error else {
            return "❗️ [AlamoRecordError] No description could be found for this error."
        }
        return "❗️ [AlamoRecordError] \(error.localizedDescription)"
    }
}
