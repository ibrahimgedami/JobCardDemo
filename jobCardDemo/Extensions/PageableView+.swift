//
//  PageableView.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

protocol PageableView: UIScrollViewDelegate where Self: UIViewController {
    var scroll: UIScrollView {get}
    var isBottom: Bool {get}
    var pageablePresenter: PageablePresenter {get}
    func didEndScrolling()
}

extension PageableView {
    var isBottom: Bool {
      return (scroll.contentOffset.y + scroll.frame.height) >= scroll.contentSize.height
    }
        
    
    func didEndScrolling() {
        guard isBottom && !pageablePresenter.isFetching && pageablePresenter.lastPage > pageablePresenter.currentPage else {return}
        pageablePresenter.paginate()
    }

}
protocol ChatableView: UIScrollViewDelegate where Self: UIViewController {
    var scroll: UIScrollView {get}
    var isTop: Bool {get}
    var pageablePresenter: PageablePresenter {get}
    func didEndScrolling()
}

extension ChatableView {
    var isTop: Bool {
      return scroll.contentOffset.y <= 0.0
    }
        
    
    func didEndScrolling() {
        guard isTop && !pageablePresenter.isFetching && pageablePresenter.lastPage > pageablePresenter.currentPage else {return}
        pageablePresenter.paginate()
    }

}



