//
//  SettingInteractor.swift
//  day5
//
//  Created by Doeun Kwon on 2024-09-16.
//

import Foundation

protocol SettingInteractorProtocol: AnyObject {
    
}

class SettingInteractor: SettingInteractorProtocol {
    
    weak var presenter: SettingPresenterProtocol?
    
}
