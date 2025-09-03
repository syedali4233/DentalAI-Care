import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fyp_project/components/doctor_side_components/appointments_components.dart';
import 'package:fyp_project/constants/extensions_for_sizedboxed.dart';
import 'package:fyp_project/constants/styles.dart';
import 'package:fyp_project/utils/shimmer.dart';
import 'package:fyp_project/view_model/appointments_provider.dart';
import 'package:provider/provider.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AppointmentsProvider>(context, listen: false)
          .appointmentsFuc();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          'Appointments',
          style: maintext,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            20.toHeight,
            Consumer<AppointmentsProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return ShimmerComponents.listTileShimmer();
                }

                final appo = value.appointments?.appointments;
                if (appo == null || appo.isEmpty) {
                  return const Center(child: Text("No Appointments Found"));
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: appo.length,
                    itemBuilder: (context, index) {
                      final appointment = appo[index];
                      return AppointmentsComponents(
                        ontap: () {},
                        title: appointment.doctorId?.email ?? "Unknown",
                        date: appointment.date?.toIso8601String() ?? "No Date",
                        imagee: "assets/images/doctor.png", // fallback asset
                        read: appointment.status ?? "pending",
                      );
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
