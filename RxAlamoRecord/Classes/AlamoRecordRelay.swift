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

import RxSwift

public final class AlamoRecordRelay<Element>: ObservableType {
    public typealias E = Element
    
    private let _subject: BehaviorSubject<Element>
    
    /// Accepts `event` and emits it to subscribers
    public func accept(_ event: Element) {
        _subject.onNext(event)
    }
    
    /// Current value of behavior subject
    public var value: Element {
        // this try! is ok because subject can't error out or be disposed
        return try! _subject.value()
    }
    
    /// Initializes behavior relay with initial value.
    public init(value: Element) {
        _subject = BehaviorSubject(value: value)
    }
    
    /// Subscribes observer
    public func subscribe<O: ObserverType>(_ observer: O) -> Disposable where O.E == E {
        return _subject.subscribe(observer)
    }
    
    /// - returns: Canonical interface for push style sequence
    public func asObservable() -> Observable<Element> {
        return _subject.asObservable()
    }
}
