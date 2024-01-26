class ToDo{
  String? id;
  String? todoText;
  bool isDone;
  ToDo({
      required this.id,
      required this.todoText,
      this.isDone= false,
});
      static List<ToDo>todoList (){
        return [


        ToDo(id: '01',todoText: 'Phone', isDone: true),
        ToDo(id: '02', todoText: 'evening exercise ',isDone:  true),
          ToDo(id: '03', todoText: 'safai',),
          ToDo(id: '04', todoText: 'khana banana'),
          ToDo(id: '05', todoText: 'Pooja',),
          ToDo(id: '06', todoText: 'Yoga'),
        ];
      }
}