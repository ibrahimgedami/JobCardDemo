//
//  MainViewController.swift
//  jobCardDemo
//
//  Created by Ibrahim Mo Gedami on 9/27/23.
//

import UIKit
import SwiftUI

@available(iOS 16.0, *)
class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func pushToSwiftUI(_ sender: UIButton) {
        //            let jobCardData = jobCardOrders?.first
        //            let modelData = JobCardDetailsModel(customerName: "\(jobCardData?.customer?.firstName ?? "")" + "\(jobCardData?.customer?.lastName ?? "")", date: jobCardData?.date ?? "", brand: jobCardData?.brand?.name ?? "", customerMobile: jobCardData?.customer?.fullPhoneNumber ?? "", jobCardNumber: jobCardData?.oldJobCardNo ?? "", images: [], jobCardSerial: jobCardData?.serialNo ?? "", modelCode: jobCardData?.producCode ?? "", purchaseDate: jobCardData?.purchaseDate ?? "")
        let modelData = JobCardDetailsModel(
            customerName: "Mohammed",
            date: "01/04/2023",
            brand: "Rolex",
            customerMobile: "05675544",
            jobCardNumber: "38679",
            images: ["https://www.shutterstock.com/shutterstock/photos/2185205475/display_1500/stock-photo-metro-railway-among-among-glass-skyscrapers-in-dubai-traffic-on-street-in-dubai-museum-of-the-2185205475.jpg",
                     "https://images.unsplash.com/photo-1518684079-3c830dcef090?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZHViYWl8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60",
                     "https://media.istockphoto.com/id/1374757033/photo/hot-air-ballooning-over-the-desert.jpg?s=2048x2048&w=is&k=20&c=rGO141sscdKyf_pvHmE5wzniVGH5FPqF8SiQC28j5sM=",
                     "https://media.istockphoto.com/id/1081116544/photo/jumeirah-mosque-in-dubai-in-the-united-arab-emirates.jpg?s=2048x2048&w=is&k=20&c=YhXFf65i4FHmT0Mo2enMwr9-ey_d7rHdMP27ZnVMG_0="],
            jobCardSerial: "13443243",
            modelCode: "033994-RG-50",
            purchaseDate: "01/04/2023"
        )
        let swiftUIView = AppConfiguration.jobCardDetail(model: modelData)
        let hostingController = UIHostingController(rootView: swiftUIView.view)
        present(hostingController, animated: true, completion: nil)
    }
}
