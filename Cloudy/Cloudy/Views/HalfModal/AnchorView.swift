import SwiftUI

struct ModalAnchorView: View {
    
    @EnvironmentObject var modalManager: ModalManager
    
    var body: some View {
        ModalView(modal: $modalManager.modal)
    }
}
