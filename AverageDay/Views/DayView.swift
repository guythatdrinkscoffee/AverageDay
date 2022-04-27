//
//  DayView.swift
//  Average Day
//
//  Created by J Manuel Zaragoza on 4/24/22.
//

import Cocoa

class DayView: NSView {
    //MARK: - Properties
    var day: Day?
    var buttonArr: [NSButton] = []
    var moodSelectionHandler: ((Mood) -> Void)?
    //MARK: - UI
    
    private lazy var topTextField : NSTextField = {
        let titleLabelFrame = NSRect(x: 20, y: 44, width: 220, height: 16)
        let titleTextField = NSTextField(frame: titleLabelFrame)
        titleTextField.backgroundColor = .clear
        titleTextField.isBezeled = false
        titleTextField.isEditable = false
        titleTextField.font = NSFont.systemFont(ofSize: 14)
        titleTextField.lineBreakMode = .byTruncatingTail
        titleTextField.stringValue = "How was your day?"
        return titleTextField
    }()
    
    private lazy var buttonStackView : NSStackView = {
        let stackViewFrame = CGRect(x: 20, y: 0, width: 220, height: 40)
        let stackView = NSStackView(frame: stackViewFrame)
        stackView.orientation = .horizontal
        stackView.distribution = .fillEqually
        return  stackView
    }()
    
    //MARK: - Lifestyle
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        configureButtonsInStackView()
        
        //Add the Subviews
        addSubviews(views: topTextField, buttonStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
    
        if let day = day {
          
            let moodButton = buttonArr.first(where: { $0.tag == day.mood.rawValue})
            
            if let moodButton = moodButton {
                moodButton.bezelColor = .systemBlue
            }
        }

    }
    
    
    //MARK: - Selectors
    @objc
    private func handleButtonTap(_ sender: NSButton){
        guard let moodSelected = Mood(rawValue: sender.tag) else { return }
        
        moodSelectionHandler?(moodSelected)
    }
}

extension DayView {
    private func configureButtonsInStackView(){
        let moods = Mood.allCases
        
        for i in 0..<moods.count-1 {
            let string = moods[i].moodText
            let mutableString = NSMutableAttributedString(string: string)
            mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: NSColor.gray, range: NSRange(location: 0, length: (string as NSString).length))
            mutableString.addAttribute(NSAttributedString.Key.font, value: NSFont.systemFont(ofSize: 22), range: NSRange(location: 0, length: (string as NSString).length))
            
            let button = NSButton(frame: NSRect(x: .zero, y: .zero, width: 20, height: 10))
            button.attributedTitle = mutableString
            button.bezelStyle = .regularSquare
            button.state = .off
            button.tag = i
            button.target = self
            button.action = #selector(self.handleButtonTap(_:))
            buttonArr.append(button)
            buttonStackView.addArrangedSubview(button)
        }
    }
    
}

extension NSView {
    func addSubviews(views: NSView...){
        for view in views {
            self.addSubview(view)
        }
    }
}
