/*
 
 The MIT License (MIT)
 Copyright (c) 2018 Dalton Hinterscher
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"),
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR
 ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH
 THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 
 */

import Alamofire
import AlamoRecord

public class RequestManagerRequestData<Url: AlamoRecordURL,
    ARError: AlamoRecordError,
    IDType: Codable>: BaseRequestData<Url, ARError> {

    internal typealias Data = (requestManager: RequestManager<Url, ARError, IDType>,
        method: Alamofire.HTTPMethod,
        url: Url,
        parameters: Parameters?,
        encoding: ParameterEncoding,
        headers: HTTPHeaders?,
        keyPath: String?,
        emptyBody: Bool)
    
    internal var data: Data {
        return (requestManager, method, url, parameters, encoding, headers, keyPath, emptyBody)
    }
    
    internal let requestManager: RequestManager<Url, ARError, IDType>
    internal let method: Alamofire.HTTPMethod
    internal let url: Url
    internal var keyPath: String?
    internal var emptyBody: Bool = false
    
    init(requestManager: RequestManager<Url, ARError, IDType>, method: Alamofire.HTTPMethod, url: Url) {
        self.requestManager = requestManager
        self.method = method
        self.url = url
        super.init()
    }
    
    public func withKeyPath(_ keyPath: String?) -> Self {
        self.keyPath = keyPath
        return self
    }
    
    public func withEmptyBody(_ emptyBody: Bool) -> Self {
        self.emptyBody = emptyBody
        return self
    }

}
