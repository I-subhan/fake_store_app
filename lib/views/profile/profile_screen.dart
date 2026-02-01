import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/utils/token_storage.dart';
import '../../viewmodels/profile_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  static const primary = Color(0xFF4F46E5);
  static const bg = Color(0xFFF6F7FB);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileCubit>().load(1);
    });
  }


  Future<void> _handleLogout(BuildContext context) async {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              CircleAvatar(
                radius: 28,
                backgroundColor: colors.error.withOpacity(.12),
                child: Icon(
                  Icons.logout_rounded,
                  color: colors.error,
                  size: 26,
                ),
              ),

              const SizedBox(height: 20),


              Text(
                "Logout",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),


              Text(
                "Are you sure you want to logout from your account?",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),

              const SizedBox(height: 28),


              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.error,
                        foregroundColor: colors.onError,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text("Logout"),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );

    if (ok == true) {
      await TokenStorage.clear();
      if (mounted) Navigator.pushReplacementNamed(context, "/");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primary,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "My Profile",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _handleLogout(context),
          )
        ],
      ),
      body: BlocBuilder<ProfileCubit, dynamic>(
        builder: (context, user) {
          if (user == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: primary,
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _profileHeader(user),
              const SizedBox(height: 24),
              _accountInfo(user),
              const SizedBox(height: 24),
              _menuSection(),
            ],
          );
        },
      ),
    );
  }


  Widget _profileHeader(dynamic user) {
    final name = _getUserName(user);
    final email = _getUserEmail(user);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 50,
            backgroundColor: primary,
            child: Text(
              name.isNotEmpty ? name[0].toUpperCase() : "U",
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),


          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),


          Text(
            email,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }


  Widget _accountInfo(dynamic user) {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: Text(
              "Account Information",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          _infoRow(Icons.person_outline, "Name", _getUserName(user)),
          const Divider(),
          _infoRow(Icons.email_outlined, "Email", _getUserEmail(user)),
          const Divider(),
          _infoRow(Icons.phone_outlined, "Phone", _getUserPhone(user)),
          const Divider(),
          _infoRow(Icons.location_on_outlined, "Address", _getUserAddress(user)),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: primary, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget _menuSection() {
    return _card(
      child: Column(
        children: [
          _menuItem(Icons.edit_outlined, "Edit Profile"),
        ],
      ),
    );
  }

  Widget _menuItem(IconData icon, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Edit profile coming soon'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
    );
  }


  Widget _card({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: child,
    );
  }


  String _getUserName(dynamic u) {
    try {
      if (u?.name != null && u.name.toString().isNotEmpty) {
        return u.name.toString();
      }
    } catch (_) {}
    return "User Name";
  }

  String _getUserEmail(dynamic u) {
    try {
      if (u?.email != null && u.email.toString().isNotEmpty) {
        return u.email.toString();
      }
    } catch (_) {}
    return "email@example.com";
  }

  String _getUserPhone(dynamic u) {
    try {
      if (u?.phone != null && u.phone.toString().isNotEmpty) {
        return u.phone.toString();
      }
    } catch (_) {}
    return "Not available";
  }

  String _getUserAddress(dynamic u) {
    try {
      final a = u?.address;
      if (a == null) return "Not available";

      final street = a.street?.toString() ?? "";
      final city = a.city?.toString() ?? "";
      final zip = a.zipcode?.toString() ?? "";

      final parts = [street, city, zip].where((e) => e.isNotEmpty).toList();

      return parts.isEmpty ? "Not available" : parts.join(", ");
    } catch (_) {
      return "Not available";
    }
  }
}