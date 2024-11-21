//
//  NewsListInteractorOutput.swift
//  NewsTest
//
//  Created by Anatoliy Bersenev on 06.11.2024.
//

import Foundation

protocol NewsListInteractorOutput: AnyObject {
    func presentNews(_ models: [NewsDTOProtocol]) 
}
