enum ServiceCode {
  exitPermission('hr.exit.permission'),
  loan('hr.loan'),
  outsideWorking('outside.working'),
  attendanceUpdate('attendance.update'),
  visaRequest('visa.request'),
  productRequest('product.request'),
  carPermission('car.permission'),
  studyRequest('study.request'),
  scrapRequest('scrap.request'),
  startWork('start.work'),
  salaryTransfer('new.salary.transfer'),
  employeeTicketBooking('employee.ticket.booking'),
  idRenewalRequest('id.renewal.request'),
  complaintRequest('complaint.request'),
  trainingRequest('training.request'),
  medicalInsuranceUpgrade('upgrade.medical.insurance'),
  experienceCertificate('experience.certificate'),
  leaveReplace('leave.replace'),
  leave('hr.leave'),
  leaveInterruptionRequest('leave.interruption.request');

  final String code;

  const ServiceCode(this.code);

  static ServiceCode? fromCode(String? value) {
    final code = value?.toLowerCase().trim();
    if (code == null || code.isEmpty) return null;

    for (final serviceCode in ServiceCode.values) {
      if (serviceCode.code == code) return serviceCode;
    }
    return null;
  }
}
