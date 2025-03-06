import 'package:flutter/material.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final List<Map<String, dynamic>> _dashboardItems = [
    {
      'title': 'الطلبات',
      'count': '48',
      'icon': Icons.shopping_cart,
      'color': Colors.blue,
    },
    {
      'title': 'المبيعات',
      'count': '₪14,325',
      'icon': Icons.monetization_on,
      'color': Colors.green,
    },
    {
      'title': 'العملاء',
      'count': '254',
      'icon': Icons.people,
      'color': Colors.amber,
    },
    {
      'title': 'التقييمات',
      'count': '4.5',
      'icon': Icons.star,
      'color': Colors.purple,
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'title': 'طلب جديد #1082',
      'time': 'منذ 5 دقائق',
      'icon': Icons.shopping_bag,
      'color': Colors.blue,
    },
    {
      'title': 'تقييم جديد',
      'time': 'منذ 20 دقيقة',
      'icon': Icons.star,
      'color': Colors.amber,
    },
    {
      'title': 'تسجيل عميل جديد',
      'time': 'منذ ساعة',
      'icon': Icons.person_add,
      'color': Colors.purple,
    },
    {
      'title': 'تحديث القائمة',
      'time': 'منذ 3 ساعات',
      'icon': Icons.restaurant_menu,
      'color': Colors.green,
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 750;
    final isTablet = screenWidth >= 750 && screenWidth < 1200;
    final isDesktop = screenWidth >= 1200;

    return Scaffold(
      appBar:
          isMobile
              ? AppBar(
                title: const Text(
                  'لوحة التحكم',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                elevation: 0,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.notifications),
                    onPressed: () {
                      // Handle notifications
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      // Handle settings
                    },
                  ),
                ],
              )
              : null,
      drawer: isMobile ? _buildDrawer(context) : null,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Row(
          children: [
            if (!isMobile) _laptopDrawer(context),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(const Duration(seconds: 1));
                },
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildWelcomeSection(isMobile, isTablet, isDesktop),
                      const SizedBox(height: 24),
                      _buildDashboardCards(isMobile, isTablet, isDesktop),
                      const SizedBox(height: 24),
                      _buildRecentActivitySection(
                        isMobile,
                        isTablet,
                        isDesktop,
                      ),
                      const SizedBox(height: 24),
                      _buildQuickActionsSection(isMobile, isTablet, isDesktop),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeSection(bool isMobile, bool isTablet, bool isDesktop) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: isMobile ? 30 : 40,
            backgroundColor: Theme.of(context).primaryColor,
            child: const Text(
              'أح',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'مرحبًا، أحمد',
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'نتمنى لك يومًا سعيدًا',
                  style: TextStyle(
                    fontSize: isMobile ? 16 : 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/scanner');
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text('الملف الشخصي'),
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCards(bool isMobile, bool isTablet, bool isDesktop) {
    final crossAxisCount = isMobile ? 2 : (isTablet ? 3 : 4);

    // Maintain a fixed aspect ratio that works well across devices
    final childAspectRatio = isMobile ? 1.0 : (isTablet ? 1.1 : 1.2);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: _dashboardItems.length,
      itemBuilder: (context, index) {
        final item = _dashboardItems[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: item['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(item['icon'], color: item['color'], size: 28),
                    ),
                    const Spacer(),
                    Icon(Icons.more_vert, color: Colors.grey[600]),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  item['count'],
                  style: TextStyle(
                    fontSize: isMobile ? 22 : 24,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 1,
                ),
                const SizedBox(height: 4),
                Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.grey[600],
                  ),
                  overflow: TextOverflow.ellipsis, // Prevent text overflow
                  maxLines: 2, // Allow up to 2 lines for the title
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRecentActivitySection(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'النشاطات الأخيرة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: () {
                // View all activities
              },
              child: Text(
                'عرض الكل',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _recentActivities.length,
          itemBuilder: (context, index) {
            final activity = _recentActivities[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: activity['color'].withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(activity['icon'], color: activity['color']),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activity['title'],
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activity['time'],
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_left, color: Colors.grey[400]),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionsSection(
    bool isMobile,
    bool isTablet,
    bool isDesktop,
  ) {
    final List<Map<String, dynamic>> quickActions = [
      {'title': 'إضافة وجبة', 'icon': Icons.add_box, 'color': Colors.blue},
      {
        'title': 'إدارة القائمة',
        'icon': Icons.restaurant_menu,
        'color': Colors.amber,
      },
      {'title': 'إضافة عرض', 'icon': Icons.discount, 'color': Colors.green},
      {'title': 'تقارير', 'icon': Icons.bar_chart, 'color': Colors.red},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'إجراءات سريعة',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:
              quickActions.map((action) {
                return InkWell(
                  onTap: () {
                    // Handle quick action tap
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: action['color'].withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          action['icon'],
                          color: action['color'],
                          size: 24,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        action['title'],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }).toList(),
        ),
      ],
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      'أح',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'أحمد محمد',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'مدير النظام',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'لوحة التحكم',
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'العملاء',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.restaurant_menu,
              title: 'القائمة',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.shopping_cart,
              title: 'الطلبات',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.receipt_long,
              title: 'الفواتير',
              onTap: () {},
            ),
            const Divider(),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'الإعدادات',
              onTap: () {},
            ),
            _buildDrawerItem(icon: Icons.help, title: 'المساعدة', onTap: () {}),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'تسجيل الخروج',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _laptopDrawer(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: 250,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Text(
                      'أح',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'أحمد محمد',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text('مدير النظام', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            _buildDrawerItem(
              icon: Icons.dashboard,
              title: 'لوحة التحكم',
              isSelected: true,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            _buildDrawerItem(
              icon: Icons.people,
              title: 'العملاء',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.restaurant_menu,
              title: 'القائمة',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.shopping_cart,
              title: 'الطلبات',
              onTap: () {},
            ),
            _buildDrawerItem(
              icon: Icons.receipt_long,
              title: 'الفواتير',
              onTap: () {},
            ),
            const Divider(),
            _buildDrawerItem(
              icon: Icons.settings,
              title: 'الإعدادات',
              onTap: () {},
            ),
            _buildDrawerItem(icon: Icons.help, title: 'المساعدة', onTap: () {}),
            _buildDrawerItem(
              icon: Icons.logout,
              title: 'تسجيل الخروج',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    bool isSelected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey[600],
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey[800],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      onTap: onTap,
      selected: isSelected,
      selectedTileColor: Theme.of(context).primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
    );
  }
}
