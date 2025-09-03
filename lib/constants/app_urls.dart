class Constants {
  // base url
  static const baseUrl = 'https://teeth-detetction-backend.onrender.com';

// auth end points

  static const signupUrl = '/api/user/signup';
  static const loginUrl = '/api/user/login';
  static const userUrl = '/api/user/getuserInfo';
  static const changePasswordUrl = '/api/user/change-password';
  static const deleteUrl = '/api/user/delete';
  static const ediyUrl = '/api/user/update-bio';
  static const getspecificUrl = '/api/patient/doctor/';
  static const getDoctorsUrl = '/api/patient/doctors';
  static const bookAppointmentUrl = '/api/patient/book-appointment/';
  static const getAppointmentsUrl = '/api/doctor/appoinments';
  static const notificationUrl = '/api/notification/notifications';
  static const acceptUrl = '/api/doctor/appointment/';
  static const rejectUrl = '/api/doctor/reject/';
  static const uploadUrl = '/user/upload-image';
  static const sendmsgUrl = '/api/chat/send';
  static const getconUrl = '/api/chat/conversations';
  static const gethistoryUrl = '/api/chat/history/';
  static const apppointsUrl = '/api/patient/all-appoinments';
}
