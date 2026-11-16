import SwiftUI

// عنوان My Plants مع الخط اللي تحته (يتكرر في الصفحات الثلاث)
struct PageHeader: View {
    var body: some View {
        VStack(spacing: 0) {
            // العنوان
            HStack {
                Text("My Plants 🌱")
                    // حجم عنوان الصفحة مثل Sketch
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.primary)
                Spacer()
            }
            .padding(.horizontal)
            // مسافة من فوق عشان العنوان ينزل مثل Sketch
            .padding(.top, 16)
            // مسافة بين العنوان والخط
            .padding(.bottom, 19)
            // الخط تحت العنوان
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
                .padding(.horizontal)
        }
    }
}

// زر + الدائري اللي تحت اليمين بحجم Sketch (44) بعد التصغير للجوال
struct PlusButton: View {
    // الكود اللي يشتغل لما نضغط الزر
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: "plus")
                // حجم علامة + داخل الزر
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
                // حجم الزر
                .frame(width: 41, height: 41)
        }
        .buttonStyle(.plain)
        // الزجاج البارز بلون Sketch الأخضر
        .glassCircle(Color.plantGreen)
        // مسافة الزر من اليمين ومن تحت مثل Sketch
        .padding(.trailing, 28)
        .padding(.bottom, 4)
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
        // الدائرة على اليسار، وبجنبها عمود فيه الغرفة والاسم والكبسولات
        HStack(alignment: .top, spacing: 23) {
            // دائرة الإنجاز
            Button(action: onToggle) {
                if plant.isDone {
                    // لما تنعلّم: دائرة خضراء فاتحة وفيها علامة صح غامقة (مثل Sketch)
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(Color(red: 24/255, green: 24/255, blue: 29/255), Color.doneGreen)
                } else {
                    // قبل التعليم: دائرة فاضية رمادية
                    Image(systemName: "circle")
                        .font(.system(size: 22))
                        .foregroundStyle(Color.mutedGray)
                }
            }
            .buttonStyle(.plain)
            // الدائرة قريبة من الحافة، وننزلها عشان تكون بمستوى الاسم مثل Sketch
            .padding(.leading, 5)
            .padding(.top, 30)
            // العمود: الغرفة فوق، الاسم في النص، الكبسولات تحت
            VStack(alignment: .leading, spacing: 0) {
                // الغرفة: سهم اللوكيشن ونص الغرفة بنفس الحجم
                HStack(spacing: 6) {
                    // سهم اللوكيشن
                    Image(systemName: "location")
                        .font(.system(size: 13, weight: .regular))
                    // اسم الغرفة
                    Text("in \(plant.room)")
                        .font(.system(size: 13, weight: .regular))
                }
                .foregroundStyle(Color.mutedGray)
                // اسم النبتة بوزن عادي مثل Sketch
                Text(plant.name)
                    .font(.system(size: 24, weight: .regular))
                    .foregroundStyle(Color.primary)
                    .padding(.top, 6)
                // كبسولة الإضاءة صفراء باهتة، وكبسولة الماء زرقاء فاتحة
                HStack(spacing: 12) {
                    tag(plant.light, "sun.max", Color.sunYellow)
                    tag(plant.waterAmount, "drop", Color.waterBlue)
                }
                .padding(.top, 8)
            }
            Spacer()
        }
        // مسافة من فوق بين الخط الفاصل والغرفة مثل Sketch
        .padding(.top, 22)
        // مسافة تحت الكبسولات
        .padding(.bottom, 10)
        // الصف كله يبهت لما النبتة تنعلّم
        .opacity(plant.isDone ? 0.5 : 1)
        // عشان الضغط يشتغل على الصف كله
        .contentShape(Rectangle())
        .onTapGesture(perform: onEdit)
    }

    // شكل الكبسولة الصغيرة، الأيقونة والنص بنفس اللون
    func tag(_ text: String, _ icon: String, _ color: Color) -> some View {
        HStack(spacing: 5) {
            // الأيقونة بلون الكبسولة
            Image(systemName: icon)
                .font(.system(size: 13, weight: .regular))
            // النص بنفس لون الأيقونة
            Text(text)
                .font(.system(size: 13, weight: .regular))
        }
        // نفس اللون للأيقونة والنص مع بعض
        .foregroundStyle(color)
        .padding(.horizontal, 9)
        .padding(.vertical, 3)
        .background(Color.tagBG, in: Capsule())
    }
}
