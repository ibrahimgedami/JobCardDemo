//
//  JobCardDetailViewModel.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 9/26/23.
//

import Foundation

protocol JobCardDetailViewModelProtocol: AnyObject {
    var getJobCardDetails: JobCardDetailsModel { get }
}

class JobCardDetailViewModel {
    
    let model: JobCardDetailsModel
    
    init(model: JobCardDetailsModel) {
        self.model = model
    }
    
}

extension JobCardDetailViewModel: JobCardDetailViewModelProtocol {
    
    var getJobCardDetails: JobCardDetailsModel {
        return model
    }
    
}
