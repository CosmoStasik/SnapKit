//
//  ViewController.swift
//  SnapKitLayout
//
//  Created by Stanislav Sobolevsky on 1.09.22.
//

import UIKit
import SnapKit

protocol FirstViewDelegate : AnyObject {
    func textFieldReturnTapped(_ textField: UITextField)
}

class FirstView : UIView, UITextFieldDelegate{
    
    weak var delegate: FirstViewDelegate?
    
    let horizontalStackView = UIStackView()
    let image = UIImageView(image: UIImage(named: "h"))
    let firstVelticalStackView = UIStackView()
    let secondVelticalStackView = UIStackView()
    let labelFirst = UILabel()
    let labelMiddle = UILabel()
    let labelLast = UILabel()
    let textFldFirst = UITextField()
    let textFldMiddle = UITextField()
    let textFldLast = UITextField()
    
    func addSubvies(){
        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.addArrangedSubview(image)
        horizontalStackView.addArrangedSubview(firstVelticalStackView)
        firstVelticalStackView.axis = .vertical
        firstVelticalStackView.distribution = .fillEqually
        horizontalStackView.addArrangedSubview(secondVelticalStackView)
        secondVelticalStackView.axis = .vertical
        secondVelticalStackView.distribution = .fillEqually
      // secondVelticalStackView.spacing = 7
        horizontalStackView.spacing = 7
        
        firstVelticalStackView.addArrangedSubview(labelFirst)
        firstVelticalStackView.addArrangedSubview(labelMiddle)
        firstVelticalStackView.addArrangedSubview(labelLast)
        labelFirst.text = "First"
        labelMiddle.text = "Middle"
        labelLast.text = "Last"
        secondVelticalStackView.addArrangedSubview(textFldFirst)
        textFldFirst.borderStyle = .roundedRect
        textFldFirst.placeholder = "Enter First Name"
        secondVelticalStackView.addArrangedSubview(textFldMiddle)
        textFldMiddle.borderStyle = .roundedRect
        textFldMiddle.placeholder = "Enter Middle Name"
        secondVelticalStackView.addArrangedSubview(textFldLast)
        textFldLast.borderStyle = .roundedRect
        textFldLast.placeholder = "Enter Last Name"
        
        horizontalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.bottom.equalTo(image)
        
        }
        image.snp.makeConstraints { make in
           //make.width.equalTo(image.snp.width)
            make.width.equalTo(image.frame.width * 0.15 )
            make.height.equalTo(image.frame.width * 0.15)
        }
//        secondVelticalStackView.snp.makeConstraints { make in
//            make.width.equalTo(firstVelticalStackView.frame.width)
        
            
 //       }
           
         func textFieldDidEndEditing(_ textField: UITextField) {
            delegate?.textFieldReturnTapped(textField)
        }
        
//
    }
}
class SecondView: UIView, UITextViewDelegate{
    
    let textView = UITextView()
    
    func addSubviews(){
        addSubview(textView)
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .none
        textView.text = "Notes..."
        textView.isScrollEnabled = false
        textView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
    
}
    
}
protocol ThirdViewDelegate : AnyObject {
    func tapped(_ button:UIButton)
}

class ThirdView: UIView{
    weak var delegate: ThirdViewDelegate?
    
    let horizontalStackView = UIStackView()
    let buttonSave = UIButton()
    let buttonCancel = UIButton()
    let buttonClear = UIButton()
    
    func addSubviews(){
        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fillEqually
        horizontalStackView.spacing = 15
        
        horizontalStackView.addArrangedSubview(buttonSave)
        horizontalStackView.addArrangedSubview(buttonCancel)
        horizontalStackView.addArrangedSubview(buttonClear)
        
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.setTitleColor(.link, for: .normal)
        buttonSave.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonCancel.setTitle("Cancel", for: .normal)
        buttonCancel.setTitleColor(.link, for: .normal)
        buttonCancel.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        buttonClear.setTitle("Clear", for: .normal)
        buttonClear.setTitleColor(.link, for: .normal)
        buttonClear.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        
        horizontalStackView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    @objc func buttonTapped(_ button:UIButton){
        delegate?.tapped(button)
    }
}



class ViewController: UIViewController {
    
    let firstView = FirstView()
    let secondView = SecondView()
    let third = ThirdView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstView.delegate = self
        third.delegate = self
        
        self.view.addSubview(firstView)
        self.view.addSubview(secondView)
        self.view.addSubview(third)
        
        firstView.addSubvies()
        secondView.backgroundColor = .lightGray
       secondView.addSubviews()
        third.addSubviews()
        firstView.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(15)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.top).inset(50)
        }
        third.snp.makeConstraints { make in
            make.left.equalTo(view.snp.left).inset(15)
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-40)
        }
        secondView.snp.makeConstraints { make in
            make.top.equalTo(firstView).inset(110)
            make.centerX.equalTo(view.snp.centerX)
            make.left.equalTo(view.snp.left).inset(15)
            make.bottom.equalTo(third).inset(60)
        }
    }
}

    
    extension ViewController: FirstViewDelegate{
        func textFieldReturnTapped(_ textField: UITextField) {
            secondView.textView.text = "Delegate Text Field"
        }
}

extension ViewController : ThirdViewDelegate{
    func tapped(_ button: UIButton) {
        secondView.textView.text.append("hey hey, button press!!")
    }
    
    
}

