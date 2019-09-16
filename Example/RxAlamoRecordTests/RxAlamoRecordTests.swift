//
//  RxAlamoRecordTests.swift
//  RxAlamoRecordTests
//
//  Created by Dalton Hinterscher on 8/12/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//
import Action
import RxSwift
import XCTest

class RxAlamoRecordTests: XCTestCase {
    
    private var expectation: XCTestExpectation!
    private var disposeBag: DisposeBag!
    private var post: AlamoRecordRelay<Post?>!
    private var postSubscriptionBlock: ((Post) -> Void)?
    
    private lazy var failureAction: Action<ApplicationError, Swift.Never> = {
        return Action { [weak self] error in
            XCTAssert(false)
            self?.expectation.fulfill()
            return Observable.empty()
        }
    }()
    
    override func setUp() {
        super.setUp()
        expectation = XCTestExpectation(description: "RxAlamoRecord Expectation")
        disposeBag = DisposeBag()
        post = AlamoRecordRelay(value: nil)
        
        post.skip(1)
            .map { $0! }
            .subscribe(onNext: { [weak self] post in
                self?.postSubscriptionBlock?(post)
            }).disposed(by: disposeBag)
    }
    
    func testThatCreateExtensionWorks() {
        
        let parameters: [String: Any] = ["userId": 4,
                                         "title" : "AlamoRecord Title",
                                         "body": "AlamoRecord Body"]
        
        postSubscriptionBlock = { [weak self] post in
            XCTAssert(post.title == parameters["title"] as? String)
            XCTAssert(post.body == parameters["body"] as? String)
            self?.expectation.fulfill()
        }
        
        Post.rx
            .create()
            .withParameters(parameters)
            .execute()
            .bind(to: post, failure: failureAction)
            .disposed(by: disposeBag)
        
        wait()
    }
    
    func testThatFindExtensionWorks() {
        
        postSubscriptionBlock = { [weak self] post in
            XCTAssert(post.title == "sunt aut facere repellat provident occaecati excepturi optio reprehenderit")
            XCTAssert(post.body == "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto")
            self?.expectation.fulfill()
        }
        
        Post.rx
            .find(id: 1)
            .execute()
            .bind(to: post, failure: failureAction)
            .disposed(by: disposeBag)
        
        wait()
    }
    
    func testThatUpdateExtensionWorksOnClass() {
        
        let title = "RxAlamoRecord Title"
        let body = "RxAlamoRecord Body"
        
        postSubscriptionBlock = { [weak self] post in
            XCTAssert(post.title == title)
            XCTAssert(post.body == body)
            self?.expectation.fulfill()
        }
        
        Post.rx
            .update(id: 1)
            .withParameters(["title": title, "body": body])
            .execute()
            .bind(to: post, failure: failureAction)
            .disposed(by: disposeBag)
    }
    
    func testThatUpdateExtensionWorksOnInstance() {
        
        let title = "RxAlamoRecord Title"
        let body = "RxAlamoRecord Body"
        
        postSubscriptionBlock = { [weak self] post in
            XCTAssert(post.title == title)
            XCTAssert(post.body == body)
            self?.expectation.fulfill()
        }
        
        let data = try! JSONEncoder().encode(["id": 1, "userId": 1, "title": "Title placeholder", "body": "Body placeholder"])
        let post = try! JSONDecoder().decode(Post.self, from: data)
        
        post.rx
            .update()
            .withParameters(["title": title, "body": body])
            .execute()
            .bind(to: self.post, failure: failureAction)
            .disposed(by: disposeBag)
    }
    
    func testThatDestroyExtensionWorksOnClass() {
        
        let destroyedAction: Action<Void, Swift.Never> = Action { [weak self] _ in
            self?.expectation.fulfill()
            return Observable.empty()
        }
        
        Post.rx
            .destroy(id: 1)
            .execute()
            .bind(to: destroyedAction, failure: failureAction)
            .disposed(by: disposeBag)
    }
    
    func testThatDestroyExtensionWorksOnInstance() {
        
        let destroyedAction: Action<Void, Swift.Never> = Action { [weak self] _ in
            self?.expectation.fulfill()
            return Observable.empty()
        }
        
        let data = try! JSONEncoder().encode(["id": 1, "userId": 1, "title": "Title placeholder", "body": "Body placeholder"])
        let post = try! JSONDecoder().decode(Post.self, from: data)
        
        post.rx
            .destroy()
            .execute()
            .bind(to: destroyedAction, failure: failureAction)
            .disposed(by: disposeBag)
    }
    
    func testThatDefaultValueExtensionMethodAssignsDefaultValueToPostOnFailure() {
        
        let data = try! JSONEncoder().encode(["id": 1, "userId": 1, "title": "Title placeholder", "body": "Body placeholder"])
        let defaultPost = try! JSONDecoder().decode(Post.self, from: data)
        
        postSubscriptionBlock = { [weak self] post in
            XCTAssert(post.id == 2)
            self?.expectation.fulfill()
        }
        
        Post.rx
            .find(id: 1111)
            .execute()
            .bind(to: post, valueOnFailure: defaultPost)
            .disposed(by: disposeBag)
    }
    
    private func wait() {
        wait(for: [expectation], timeout: 60.0)
    }
    
}

private extension JSONEncoder {
    
    private struct EncodableWrapper: Encodable {
        let wrapped: Encodable
        
        func encode(to encoder: Encoder) throws {
            try self.wrapped.encode(to: encoder)
        }
    }
    
    func encode<Key: Encodable>(_ dictionary: [Key: Encodable]) throws -> Data {
        let wrappedDict = dictionary.mapValues(EncodableWrapper.init(wrapped:))
        return try self.encode(wrappedDict)
    }
}
