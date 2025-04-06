import Foundation

extension String {
    var toData: Data {
        Data(self.utf8)
    }
}
