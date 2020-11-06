//
//  NewWorkoutPopup.swift
//  WRKOUT
//
//  Created by Alex Voigt on 06.11.20.
//

import SwiftUI

struct NewWorkoutPopup: UIViewControllerRepresentable {
    @Binding var textString: String
    @Binding var showAlert: Bool
    
    var title: String
    var message: String
    var overview: OverviewView
    
    // Make sure that, this fuction returns UIViewController, instead of UIAlertController.
    // Because UIAlertController gets presented on UIViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<NewWorkoutPopup>) -> UIViewController {
         return UIViewController() // Container on which UIAlertContoller presents
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NewWorkoutPopup>) {
        // Make sure that Alert instance exist after View's body get re-rendered
        guard context.coordinator.alert == nil else { return }

        if self.showAlert {

            // Create UIAlertController instance that is gonna present on UIViewController
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert

            // Adds UITextField & make sure that coordinator is delegate to UITextField.
            alert.addTextField { textField in
                textField.placeholder = "Enter workout name"
                textField.text = self.textString            // setting initial value
                textField.delegate = context.coordinator    // using coordinator as delegate
            }

            // As usual adding actions
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: "") , style: .destructive) { _ in

                // On dismiss, SiwftUI view's two-way binding variable must be update (setting false) means, remove Alert's View from UI
                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })

            alert.addAction(UIAlertAction(title: NSLocalizedString("Save", comment: ""), style: .default) { _ in
                // On submit action, get texts from TextField & set it on SwiftUI View's two-way binding varaible `textString` so that View receives enter response.
                if let textField = alert.textFields?.first, let text = textField.text {
                    overview.saveNewWorkout(workoutName: text)
                    self.textString = text
                }

                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })

            // Most important, must be dispatched on Main thread,
            // Curious? then remove `DispatchQueue.main.async` & find out yourself, Dont be lazy
            DispatchQueue.main.async { // must be async !!
                uiViewController.present(alert, animated: true, completion: {
                    self.showAlert = false  // hide holder after alert dismiss
                    context.coordinator.alert = nil
                })

            }
        }
    }
    
    func makeCoordinator() -> NewWorkoutPopup.Coordinator {
      Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
      
      // Holds reference of UIAlertController, so that when `body` of view gets re-rendered so that Alert should not disappear
      var alert: UIAlertController?
      
      // Holds back reference to SwiftUI's View
      var control: NewWorkoutPopup
      
      init(_ control: NewWorkoutPopup) {
          self.control = control
      }
      
      func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
          if let text = textField.text as NSString? {
              self.control.textString = text.replacingCharacters(in: range, with: string)
          } else {
              self.control.textString = ""
          }
          return true
      }
    }
}
