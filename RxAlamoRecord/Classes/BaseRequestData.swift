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

public class BaseRequestData<Url: AlamoRecordURL, ARError: AlamoRecordError> {

    internal var parameters: Parameters?
    internal var encoding: ParameterEncoding = URLEncoding.default
    internal var headers: HTTPHeaders?
    
    /**
        Appends parameters onto the request.
        - parameter parameters: The parameters.
     */
    public func withParameters(_ parameters: Parameters?) -> Self {
        self.parameters = parameters
        return self
    }
    
    /**
        Appends encoding onto the request.
        - parameter encoding: The parameter encoding.
     */
    public func withEncoding(_ encoding: ParameterEncoding) -> Self {
        self.encoding = encoding
        return self
    }
    
    /**
        Appends headers onto the request.
        - parameter headers: The HTTP headers.
     */
    public func withHeaders(_ headers: HTTPHeaders?) -> Self {
        self.headers = headers
        return self
    }
}
