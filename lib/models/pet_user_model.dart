import 'package:flutter/material.dart';
class PetUser {
  String? petType;
  String? petName;
  String? vetName;
  bool? isVaccinated;
  DateTime? lastVisitDate;

  PetUser({
    this.petType,
    this.petName,
    this.vetName,
    this.isVaccinated,
    this.lastVisitDate,

  });
}