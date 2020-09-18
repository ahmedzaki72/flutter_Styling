// Card(
// child: Row(
// children: <Widget>[
// Container(
// child: Text(
// '\$${transaction[index].amount.toStringAsFixed(2)}',
// style: TextStyle(
// fontWeight: FontWeight.bold,
// fontSize: 20.0,
// color: Theme.of(context).primaryColor,
// ),
// ),
// margin: EdgeInsets.symmetric(
// vertical: 10.0,
// horizontal: 10.0,
// ),
// decoration: BoxDecoration(
// border: Border.all(
// color: Theme.of(context).primaryColor,
// width: 2.0,
// )),
// padding: EdgeInsets.all(10.0),
// ),
// Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Text(
// transaction[index].title,
// style: TextStyle(
// fontSize: 16.0,
// fontWeight: FontWeight.bold,
// ),
// ),
// Text(
// DateFormat.yMMMd().format(transaction[index].date),
// style: TextStyle(
// color: Colors.grey,
// ),
// ),
// ],
// ),
// ],
// ),
// );