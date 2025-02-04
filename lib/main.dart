import 'package:agenda/DS/components/list/list_view_model.dart';
import 'package:agenda/DS/components/list/list_widget.dart';
import 'package:flutter/material.dart';

class Student {
  final String name;
  final String school;
  final int grade;
  final String phone;

  Student(
      {required this.name,
      required this.school,
      required this.grade,
      required this.phone});
}

void main() {
  List<Student> students = [
    Student(name: "Lucas", school: "Escola A", grade: 5, phone: "7777-7777"),
    Student(name: "Mariana", school: "Escola B", grade: 7, phone: "6666-6666"),
  ];

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ListWidget(
      viewModel: ListViewModel<Student>(
        title: "Lista de Alunos",
        size: ListSize.large,
        color: ListColor.blue,
        items: students,
        visibleColumns: [
          "Nome",
          "Escola",
          "Série"
        ], // Definir quais colunas aparecem
        dataExtractor: {
          "Nome": (student) => student.name,
          "Escola": (student) => student.school,
          "Série": (student) => student.grade.toString(),
          "Telefone": (student) => student.phone,
        },
        layout: ListLayout.side,
      ),
    ),
  ));
}
