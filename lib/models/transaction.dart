class Transaction {
  int amount;
  DateTime date;
  String title;
  TransactionType type;

  Transaction(
      {required this.amount,
      required this.title,
      required this.type,
      required this.date});

  static List<Transaction> tList = [
    Transaction(
        amount: 10000,
        title: "Depot",
        type: TransactionType.deposit,
        date: DateTime.now()),
    Transaction(
        amount: 35000,
        title: "Retrait",
        type: TransactionType.withdraw,
        date: DateTime.now()),
    Transaction(
        amount: 50000,
        title: "Modou Ndiaye 777777777",
        type: TransactionType.transferS,
        date: DateTime.now()),
    Transaction(
        amount: 100000,
        title: "Mbaye Kebe 787777777",
        type: TransactionType.transferE,
        date: DateTime.now()),
    Transaction(
        amount: 5000,
        title: "Canal +",
        type: TransactionType.operation,
        date: DateTime.now()),
  ];
}

enum TransactionType { deposit, withdraw, operation, transferE, transferS }
