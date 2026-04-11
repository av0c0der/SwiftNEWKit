import Foundation

enum ChangelogPreviewData {
    static let currentItems: [ReleaseNotes] = [
        ReleaseNotes(
            version: "2.1.0",
            date: Date(timeIntervalSince1970: 1_743_984_000),
            subtitle: "Current release",
            notes: [
                ReleaseNote(
                    icon: "sparkles",
                    iconBackground: "#4F46E5",
                    title: "Sectioned changelog",
                    body: "History entries can now be grouped under optional section headers."
                )
            ]
        ),
        ReleaseNotes(
            version: "2.0.1",
            date: Date(timeIntervalSince1970: 1_741_305_600),
            notes: [
                ReleaseNote(
                    icon: "wrench.and.screwdriver.fill",
                    iconBackground: "#10B981",
                    title: "Layout fixes",
                    body: "Version badges now render inside each section instead of acting as sticky headers."
                )
            ]
        )
    ]

    static let historySections: [ReleaseNotesSection] = [
        ReleaseNotesSection(
            title: "2.0 Kyoto",
            items: [
                currentItems[0],
                currentItems[1],
                ReleaseNotes(
                    version: "2.0.0",
                    date: Date(timeIntervalSince1970: 1_728_086_400),
                    notes: [
                        ReleaseNote(
                            icon: "rectangle.3.group.fill",
                            iconBackground: "#8B5CF6",
                            title: "Shared release layout",
                            subtitle: "Unified presentation",
                            body: "Current and history views now share the same visual system so larger grouped data sets feel cohesive."
                        )
                    ]
                )
            ]
        ),
        ReleaseNotesSection(
            title: "1.0 Lisbon",
            items: [
                ReleaseNotes(
                    version: "1.1.0",
                    date: Date(timeIntervalSince1970: 1_722_643_200),
                    notes: [
                        ReleaseNote(
                            icon: "paintbrush.pointed.fill",
                            iconBackground: "#EC4899",
                            title: "Visual refresh",
                            body: "Older releases can live in their own major-version section."
                        )
                    ]
                ),
                ReleaseNotes(
                    version: "1.0.0",
                    date: Date(timeIntervalSince1970: 1_707_264_000),
                    notes: [
                        ReleaseNote(
                            icon: "shippingbox.fill",
                            iconBackground: "#3B82F6",
                            title: "Composable API",
                            body: "Release notes content can now be supplied directly, making previews and demos much easier to customize."
                        )
                    ]
                )
            ]
        )
    ]

    static let sampleNote = currentItems[0].notes[0]

    // MARK: - RTL (Arabic)

    static let rtlNote = ReleaseNote(
        icon: "sparkles",
        iconBackground: "#007AFF",
        title: "سجل زمني أغنى",
        subtitle: "سجل مُجمّع",
        body: "يعرض العرض التجريبي الآن سجل تغييرات مُجمعًا داخل أقسام للإصدارات الرئيسية بدلًا من قائمة واحدة مسطحة."
    )

    static let rtlCurrentItems: [ReleaseNotes] = [
        ReleaseNotes(
            version: "2.1.0",
            date: Date(timeIntervalSince1970: 1_743_984_000),
            notes: [
                rtlNote,
                ReleaseNote(
                    icon: "slider.horizontal.3",
                    iconBackground: "#34C759",
                    title: "رؤوس أقسام مثبتة",
                    body: "أثناء التمرير، يعرض الرأس المثبت عنوان القسم النشط بدلًا من شارة الإصدار الحالية."
                )
            ]
        )
    ]

    static let rtlHistorySections: [ReleaseNotesSection] = [
        ReleaseNotesSection(
            title: "(2.0) كيوتو",
            items: [
                rtlCurrentItems[0],
                ReleaseNotes(
                    version: "2.0.0",
                    date: Date(timeIntervalSince1970: 1_728_086_400),
                    subtitle: "تحديث رئيسي",
                    notes: [
                        ReleaseNote(
                            icon: "shippingbox.fill",
                            iconBackground: "#5856D6",
                            title: "تخطيط موحد",
                            body: "اعتمد العرض التجريبي نظام تخطيط مشتركًا لأقسام الإصدارات الحالية والتاريخية."
                        )
                    ]
                )
            ]
        ),
        ReleaseNotesSection(
            title: "(1.0) لشبونة",
            items: [
                ReleaseNotes(
                    version: "1.0.0",
                    date: Date(timeIntervalSince1970: 1_707_264_000),
                    subtitle: "تحديث رئيسي",
                    notes: [
                        ReleaseNote(
                            icon: "square.grid.2x2.fill",
                            iconBackground: "#0A84FF",
                            title: "تقسيم المكونات",
                            body: "تم تقسيم عرض ملاحظات الإصدار إلى أجزاء أصغر قابلة لإعادة الاستخدام داخل التطبيق التجريبي."
                        )
                    ]
                )
            ]
        )
    ]
}
