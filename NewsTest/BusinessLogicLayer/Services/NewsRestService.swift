//
//  NewsRestService.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 11.11.2024.
//

import Foundation

protocol NewsRestServiceProtocol {
    func getNewsFromRSS(
        sources: [NewsSourceDtoProtocol],
        complition: @escaping (Result<[NewsDTOProtocol], Error>
        ) -> Void )

}

final class NewsRestService: NewsRestServiceProtocol {
    
    private let newsParser: RSSNewsParserProtocol

    private let session = URLSession.shared

    private let dispatchGroup = DispatchGroup()
    
    init(newsParser: RSSNewsParserProtocol) {
        self.newsParser = newsParser
    }
    
    func getNewsFromRSS(
        sources: [NewsSourceDtoProtocol],
        complition: @escaping (Result<[NewsDTOProtocol], Error>) -> Void
    )  {
        var resultModels: Array<NewsDTOProtocol> = []
        var error: Error? = nil
        for source in sources {
            dispatchGroup.enter()
            guard let url = URL(string: source.sourceUrlString) else {
                debugPrint("Network error: \(RequestError.urlCastError(url: source.sourceUrlString))")
                error = RequestError.urlCastError(url: source.sourceUrlString)
                dispatchGroup.leave()
                return
            }
            session.dataTask(with: url) { [weak self] (data, response, error)  in
                guard let data, let self, error == nil else {
                    debugPrint("Network error: \(error ?? RequestError.networkUnexpectedError)")
                    self?.dispatchGroup.leave()
                    return
                }
                var parserModels: [NewsRestModel] = self.newsParser.parse(data: data)
                let newsModels = parserModels.map { element in
                    var newElement = element
                    newElement.source = source.sourceUrlString
                    return newElement
                }
                resultModels.append(contentsOf: newsModels)
                self.dispatchGroup.leave()
            }.resume()

        }

        dispatchGroup.notify(queue: .main) {
            if resultModels.count != 0 {
                complition(.success(resultModels))
            } else {
                complition(.failure(error ?? RequestError.networkUnexpectedError))
            }
        }
    }
}

enum RequestError: Error {
    case urlCastError(url: String)
    case networkUnexpectedError
}
