import SwiftUI

//هنا  العنوان
struct ReminderRow: View {
    let icon, title: String
    let options: [String]
    @Binding var selection: String

    var body: some View {
        HStack(spacing: 6) {
            // حجم الايكونز ولونها أبيض مثل Sketch
            Image(systemName: icon).font(.system(size: 18)).foregroundStyle(Color.white).frame(width: 24)
            // حجم خط العنوان
            Text(title).font(.system(size: 17))
            Spacer()
//الليست هنا
            Picker(title, selection: $selection) {
                ForEach(options, id: \.self) { Text($0) }
            }
            // حجم خط القيمة، وfixedSize عشان ما ينكسر النص على سطرين
            .font(.system(size: 16))
            .fixedSize()
            // لون القيمة والسهم رمادي 8E8E93 مثل Sketch
            .labelsHidden().tint(Color.valueGray)
        }
//مسافات الصف من داخل
        .padding(.horizontal, 18)
        // ارتفاع الصف الواحد مثل Sketch
        .frame(height: 44)
    }
}

// كرت فيه صفين وبينهم خط
struct Card<Content: View>: View {
    @ViewBuilder let content: Content

    var body: some View {
        VStack(spacing: 0) { content }
            .background(Color.fieldBG)
            // زوايا الكرت مثل Sketch
            .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}

// الخط الفاصل بين الصفين داخل الكرت
struct Line: View {
    var body: some View {
        // لون الخط 414144 ومسافته من اليسار أكبر من اليمين مثل Sketch
        Divider().overlay(Color.dividerGray).padding(.leading, 15).padding(.trailing, 7)
    }
}

// شكل الزجاج البارز (Prominent) الدائري، نستخدمه في أزرار ✕ و✓ و+
extension View {
    func glassCircle(_ color: Color) -> some View {
        self
            // تأثير الزجاج (Liquid Glass) بلون الزر، وinteractive يخليه يتجاوب لما نضغطه
            .glassEffect(.regular.tint(color).interactive(), in: .circle)
            // حافة لامعة خفيفة مثل Sketch
            .overlay(
                Circle().strokeBorder(
                    LinearGradient(colors: [Color.white.opacity(0.4), Color.white.opacity(0.05)],
                                   startPoint: .top, endPoint: .bottom),
                    lineWidth: 1
                )
            )
    }
}

// الزر الدائري (للإغلاق وللتأكيد) بحجم Sketch (44) بعد التصغير للجوال
struct CircleButton: View {
    // اسم الأيقونة
    let icon: String
    // لون الزر
    let color: Color
    // الكود اللي يشتغل لما نضغط الزر
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                // حجم الأيقونة داخل الزر
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                // حجم الزر
                .frame(width: 41, height: 41)
        }
        .buttonStyle(.plain)
        .glassCircle(color)
    }
}
