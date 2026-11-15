import SwiftUI

//هنا  العنوان
struct ReminderRow: View {
    let icon, title: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        HStack(spacing: 10) {
            // حجم الايكونز ولونها رمادي
            Image(systemName: icon).font(.system(size: 15)).foregroundStyle(.secondary).frame(width: 20)
            // حجم خط العنوان
            Text(title).font(.system(size: 16))
            Spacer()
//الليست هنا
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { Text($0) }
            }
            // حجم خط القيمة، وfixedSize عشان ما ينكسر النص على سطرين
            .font(.system(size: 15))
            .fixedSize()
            .labelsHidden().tint(.secondary)
        }
//مسافات الصف من داخل
        .padding(.horizontal, 16).padding(.vertical, 12)
    }
}

// كرت فيه صفين وبينهم خط
struct Card<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) { content }
            .background(Color.fieldBG)
            .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}

// الخط الفاصل بين الصفين داخل الكرت
struct Line: View {
    var body: some View {
        Divider().overlay(Color.white.opacity(0.08)).padding(.horizontal, 16)
    }
}
