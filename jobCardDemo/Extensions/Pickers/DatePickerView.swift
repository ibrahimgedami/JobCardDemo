//
//  DatePickerView.swift
//  Base Project MVP
//
//  Created by Mohamed Akl on 03/04/2022.
//  Copyright © 2022 Mohamed Akl. All rights reserved.
//

import UIKit

fileprivate var dateType : UIDatePicker.Mode = .date

extension UITextField {
    
    func date(type: UIDatePicker.Mode, isNow: Bool = true, didSelectData: (() -> ())? = nil) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = type
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if (isNow && type == .date) || (isNow && type == .dateAndTime){
            let now = Date()
            datePicker.minimumDate = now
        }
    
        dateType  = type
        self.inputView = datePicker
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: nil, action: #selector(tapCancel))
        cancel.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        let barButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(tapDone))
        barButton.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        datePicker.addTarget(self, action: #selector(valueChangeDate), for: .valueChanged)
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.MainBlack
        self.inputAccessoryView = toolBar
    }
    
    func dateHijri(isNow: Bool = false) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .date
        datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
        self.inputView = datePicker

        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        if isNow{
            let now = Date()
            datePicker.maximumDate = now
        }
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(tapDoneHijri))
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        datePicker.addTarget(self, action: #selector(valueChangeDateHijri), for: .valueChanged)
        toolBar.isTranslucent = false
        toolBar.barTintColor = UIColor.MainWhite
        //mainPurpleColor
        //mainBlackLabel
        self.inputAccessoryView = toolBar
    }
    func dateYears(year: String) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "Cancel".localized, style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "Done".localized, style: .plain, target: self, action: #selector(tapDone))
        toolBar.setItems([cancel, flexible, barButton], animated: false)
        datePicker.addTarget(self, action: #selector(valueChangeDate), for: .valueChanged)
        toolBar.isTranslucent = false
//        toolBar.barTintColor = UIColor.MainDarkYellow
        self.inputAccessoryView = toolBar
    }
    
    @objc fileprivate func tapCancel() {
        self.resignFirstResponder()
    }
    
    @objc fileprivate func tapDone() {
        setDate()
        self.resignFirstResponder()
    }
    
    @objc fileprivate func valueChangeDate(){
        setDate()
    }
    
    @objc fileprivate func tapDoneHijri() {
        setDateHijri()
        self.resignFirstResponder()
    }
    
    @objc fileprivate func valueChangeDateHijri() {
        setDateHijri()
    }
    
    fileprivate func setDateHijri() {
        if let datePicker = self.inputView as? UIDatePicker {
            datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
            let dateFormatter = DateFormatter()
            datePicker.calendar = Calendar(identifier: .islamicUmmAlQura)
            //             dateformatter.locale = Locale(identifier: "en")
            dateFormatter.locale = Locale.init(identifier: "en_SA")
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            self.text = dateFormatter.string(from: datePicker.date)
        }
    }
    
    fileprivate  func setDate() {
        if let datePicker = self.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en")
            switch dateType {
            case .time:
                dateFormatter.dateFormat = "HH:mm"
                self.text = dateFormatter.string(from: datePicker.date)
            case .date:
                dateFormatter.dateFormat = "yyyy-MM-dd"
                self.text = dateFormatter.string(from: datePicker.date)
            case .dateAndTime:
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//"EEEE, MMM d HH:mm a"
                self.text = dateFormatter.string(from: datePicker.date)
            case .countDownTimer:
                print("ds")
            @unknown default:
                fatalError()
            }
        }
    }
}

extension DateFormatter {
    func years<R: RandomAccessCollection>(_ range: R) -> [String] where R.Iterator.Element == Int {
        setLocalizedDateFormatFromTemplate("yyyy")
        var comps = DateComponents(month: 1, day: 1)
        var res = [String]()
        for y in range {
            comps.year = y
            if let date = calendar.date(from: comps) {
                res.append(string(from: date))
            }
        }
        return res
    }
}

extension Date {
    
    func longDate() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
    
    func stringDate() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ddMMMyyyyHHmmss"
        return dateFormatter.string(from: self)
    }
    
    func time() ->String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: self)
    }
    
    func interval(ofComponent comp: Calendar.Component, to date: Date )->Float {
        let currentCalendar = Calendar.current
        guard let end = currentCalendar.ordinality(of: comp, in: .era, for: date) else {return 0}
        guard let start = currentCalendar.ordinality(of: comp, in: .era, for: self) else {return 0}
        return Float(end - start)
    }
}
