import SwiftUI

// صفحة Today Reminder: قائمة النباتات مع شريط التقدم
struct page3: View {
    // الصفحة تاخذ البيانات من الـ ViewModel
    @Bindable var viewModel: PlantsViewModel

    var body: some View {
        // الزر + فوق القائمة في الزاوية تحت اليمين
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // العنوان والخط اللي تحته
                PageHeader()

                // النص اللي يتغير حسب الإنجاز، في النص وأبيض مثل Sketch
                Text(viewModel.statusText)
                    // حجم نص الحالة مثل Sketch
                    .font(.system(size: 18))
                    // لون النص أبيض
                    .foregroundStyle(Color.white)
                    // النص في نص الشاشة
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal)
                    // المسافة بين الخط تحت العنوان والنص مثل Sketch
                    .padding(.top, 36)

                // شريط التقدم حسب عدد النباتات المنسقية
                ProgressView(value: viewModel.progress)
                    .tint(Color.plantGreen)
                    // نسمك الشريط
                    .scaleEffect(x: 1, y: 2.2)
                    // الشريط أضيق من الشاشة شوي مثل Sketch
                    .padding(.horizontal, 28)
                    // المسافة بين النص والشريط مثل Sketch (15)
                    .padding(.top, 15)
                    // المسافة بين شريط التقدم وأول نبتة مثل Sketch (56 بعد التصغير للجوال، منها 22 من مسافة الصف نفسه)
                    .padding(.bottom, 32)

                // قائمة النباتات
                List {
                    ForEach(viewModel.plants) { plant in
                        PlantRow(
                            plant: plant,
                            // الضغط على الدائرة يقلب حالة السقي
                            onToggle: { viewModel.toggleDone(plant) },
                            // الضغط على الصف يفتح التعديل
                            onEdit: { viewModel.startEditing(plant) }
                        )
                        // مسافات الصف من الأطراف
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        // الخط الفاصل يبدأ من حافة الشاشة
                        .alignmentGuide(.listRowSeparatorLeading) { _ in 0 }
                        // لون الخط الفاصل
                        .listRowSeparatorTint(Color.dividerGray)
                        .listRowBackground(Color.clear)
                        // السحب على الصف يحذف النبتة
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive) {
                                viewModel.deletePlant(plant)
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                    }
                }
                .listStyle(.plain)
                // نشيل خلفية القائمة الافتراضية
                .scrollContentBackground(.hidden)
            }

            // زر + يفتح شيت إضافة نبتة جديدة
            PlusButton {
                viewModel.startAdding()
            }
        }
        // خلفية الصفحة تتبع الدارك مود
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

// عرض الصفحة في الـ Preview بدون نباتات، اليوزر هو اللي يضيفها
#Preview {
    page3(viewModel: PlantsViewModel())
        .preferredColorScheme(.dark)
}
