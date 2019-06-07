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

import AlamoRecord
import RxSwift

public extension Reactive {
    
    /**
       Creates request data for the AlamoRecordObject.all() request that is to be executed.
     */
    static func all<Url, ARError, IDType>() -> AllRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return AllRequestData()
    }
    
    /**
     Creates request data for the AlamoRecordObject.find(id: Any) request that is to be executed.
     */
    static func find<Url, ARError, IDType>(id: IDType) -> FindRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return FindRequestData(id: id)
    }
    
    /**
        Creates request data for the AlamoRecordObject.create() request that is to be executed.
     */
    static func create<Url, ARError, IDType>() -> CreateRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return CreateRequestData()
    }
    
    /**
        Creates request data for the AlamoRecordObject.update(id: Any) request that is to be executed.
     */
    static func update<Url, ARError, IDType>(id: IDType) -> UpdateRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return UpdateRequestData(id: id, type: Base.self)
    }
    
    /**
        Creates request data for the alamoRecordObject.update(id: Any) request that is to be executed.
     */
    func update<Url, ARError, IDType>() -> UpdateRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return UpdateRequestData(id: base.id, type: Base.self)
    }
    
    /**
        Creates request data for the AlamoRecordObject.destroy(id: Any) request that is to be executed.
     */
    static func destroy<Url, ARError, IDType>(id: IDType) -> DestroyRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return DestroyRequestData(id: id, type: Base.self)
    }
    
    /**
        Creates request data for the alamoRecordObject.destroy(id: Any) request that is to be executed.
     */
    func destroy<Url, ARError, IDType>() -> DestroyRequestData<Url, ARError, IDType, Base> where Base: AlamoRecordObject<Url, ARError, IDType> {
        return DestroyRequestData(id: base.id, type: Base.self)
    }

}
