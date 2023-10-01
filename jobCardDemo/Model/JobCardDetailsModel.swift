//
//  JobCardDetailsModel.swift
//  SwiftUI_ImageLoader
//
//  Created by Ibrahim Mo Gedami on 9/24/23.
//

import Foundation

struct JobCardDetailsModel: Codable{
    
    let customerName: String?
    let date: String?
    let brand: String?
    let customerMobile: String?
    let jobCardNumber: String?
    let images: [String]?
    let jobCardSerial: String?
    let modelCode: String?
    let purchaseDate: String?
    
    init(customerName: String?, date: String?, brand: String?, customerMobile: String?, jobCardNumber: String?, images: [String]?, jobCardSerial: String?, modelCode: String?, purchaseDate: String?) {
        self.customerName = customerName
        self.date = date
        self.brand = brand
        self.customerMobile = customerMobile
        self.jobCardNumber = jobCardNumber
        self.images = images
        self.jobCardSerial = jobCardSerial
        self.modelCode = modelCode
        self.purchaseDate = purchaseDate
    }
    
    init(model: JobCardDetailsModel) {
        self.customerName = model.customerName
        self.date = model.date
        self.brand = model.brand
        self.customerMobile = model.customerMobile
        self.jobCardNumber = model.jobCardNumber
        self.images = model.images
        self.jobCardSerial = model.jobCardSerial
        self.modelCode = model.modelCode
        self.purchaseDate = model.purchaseDate
    }
        
}
