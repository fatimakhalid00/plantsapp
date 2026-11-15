import SwiftUI

// عنوان My Plants مع الخط اللي تحته (يتكرر في الصفحات الثلاث)
struct PageHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            // العنوان
            HStack {
                Text("My Plants 🌱")
                    // حجم عنوان الصفحة
                    .font(.system(size: 28, weight: .bold))
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 12)
            // الخط تحت العنوان
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal)
        }
    }
}

// زر + الدائري اللي تحت اليمين
struct PlusButton: View {
    // الكود اللي يشتغل لما نضغط الزر
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.white)
                .frame(width: 50, height: 50)
                // تأثير الزجاج (Liquid Glass) بلون أخضر، وinteractive يخليه يتجاوب لما نضغطه
                .glassEffect(.regular.tint(Color.plantGreen).interactive(), in: .circle)
        }
        // مسافة الزر من حافة الشاشة
        .padding(24)
    }
}

// صف النبتة الواحدة في القائمة
struct PlantRow: View {
    // النبتة اللي نعرضها
    let plant: Plant
    // الكود اللي يشتغل لما نضغط الدائرة
    let onToggle: () -> Void
    // الكود اللي يشتغل لما نضغط على الصف (يفتح التعديل)
    let onEdit: () -> Void

    var body: some View {
        // VStack يحط الغرفة فوق، وتحتها الدائرة مع اسم النبتة
        VStack(alignment: .leading, spacing: 3) {
            // الغرفة فوق الاسم (المسافة اليسار عشان تصير فوق الاسم مباشرة)
            Label("in \(plant.room)", systemImage: "location")
                .font(.system(size: 11))
                .foregroundStyle(Color.mutedGray)
                .padding(.leading, 32)
            // الدائرة جنب الاسم والكبسولات
            HStack(alignment: .top, spacing: 12) {
                // دائرة الإنجاز
                Button(action: onToggle) {
                    if plant.isDone {
                        // لما تنعلّم: دائرة خضراء فاتحة وفيها علامة صح غامقة (مثل Sketch)
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(Color.black, Color.doneGreen)
                    } else {
                        // قبل التعليم: دائرة فاضية رمادية
                        Image(systemName: "circle")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.mutedGray)
                    }
                }
                .buttonStyle(.plain)
                // اسم النبتة وتحته الكبسولات
                VStack(alignment: .leading, spacing: 6) {
                    // اسم النبتة
                    Text(plant.name)
                        .font(.system(size: 19, weight: .medium))
                        .foregroundStyle(Color.primary)
                    // كبسولة الإضاءة كلها صفراء باهتة، وكبسولة الماء كلها زرقاء فاتحة
                    HStack(spacing: 6) {
                        tag(plant.light, "sun.max", Color.sunYellow)
                        tag(plant.waterAmount, "drop", Color.waterBlue)
                    }
                }
                Spacer()
            }
        }
        .padding(.vertical, 6)
        // الصف كله يبهت لما النبتة تنعلّم
        .opacity(plant.isDone ? 0.5 : 1)
        // عشان الضغط يشتغل على الصف كله
        .contentShape(Rectangle())
        .onTapGesture(perform: onEdit)
    }

    // شكل الكبسولة الصغيرة، الأيقونة والنص بنفس اللون
    func tag(_ text: String, _ icon: String, _ color: Color) -> some View {
        HStack(spacing: 4) {
            // الأيقونة بلون الكبسولة
            Image(systemName: icon)
                .font(.system(size: 10))
            // النص بنفس لون الأيقونة
            Text(text)
                .font(.system(size: 11))
        }
        // نفس اللون للأيقونة والنص مع بعض
        .foregroundStyle(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(Color.tagBG, in: Capsule())
    }
}
