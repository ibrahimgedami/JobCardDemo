//
//  PageablePresenter.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import Foundation

protocol PageablePresenter {
    var currentPage: Int {get}
    var lastPage: Int {get}
    var isFetching: Bool { get set}
    func paginate()
}
