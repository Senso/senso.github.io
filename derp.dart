import 'dart:html';
import 'dart:async';

//Map employees = new Map();
double Money = 0.0;

var office = {
  'funds': Money,
  'employees': [],
  'departments': new Map(),
  'upgrades': []
};

var prices = {
  'employee': 100.0
};

void main() {
  //Counter main_counter = new Counter(10, "#t1");
  
  // Setup the "buttons" and their callbacks
  
//  querySelector("#dude_action")
//      ..onClick.listen(main_counter.start_counter);
  
  querySelector("#new_dude")
        ..onClick.listen(new_employee);
  
  querySelector("#make_money")
        ..onClick.listen(make_money);
  
  main_loop();
}

void main_loop() {
  // Calculate the employee production/revenues/costs
  
  
  
  // Update the display with the current funds
  update_money(true);
}

void new_employee(MouseEvent event) {
  if (office['funds'] >= prices['employee']) {
    office['funds'] -= prices['employee'];
    update_money(false);
    
    //Employee new_emp = new Employee();
    //new_emp.name = 'Toto';
    
    // probably need a deepcopy here?
    office['employees'].add(new Employee());
    
    // Show it
    querySelector("#employees_num").text = office['employees'].length.toString();
  }
  
  
  //var empdiv = querySelector("#employees");
  //var nspan = new Element.span();
  //nspan.text = "New employee etc.";
  //var brr = new Element.tag('br');
  //empdiv.append(brr);
  //empdiv.append(nspan);
}

class Employee {
  String name;
}

void make_money(MouseEvent event) {
  office['funds'] += 100.0;
  update_money(false);
}

void update_money(bool future) {
  querySelector("#current_funds").text = office['funds'].toString();
  
  // We're adding back this command to the event queue forever
  if (future) {
    new Future.delayed(const Duration(seconds:1), () {
      update_money(true);
    });
  }
}

// Find a way to pass a callback or something
class Counter {
  Stopwatch watch;
  var elem;
  int duration;
  Timer period;
  Timer total;
  Duration step;
  Duration end;
  
  Counter(int duration, var elem) {
    this.duration = duration;
    this.elem = elem;
    this.watch = new Stopwatch();
    step = new Duration(seconds:1);
    end = new Duration(seconds:duration);
  }
  
  void create_timers() {
    // 1-second tick that refreshes the display
    period = new Timer.periodic(step, handle_tick);
    // total time, fires up callback when done
    total = new Timer.periodic(end, handle_end);
  }

  void start_counter(MouseEvent event) {
    if (!watch.isRunning) {
      create_timers();
      watch.start();
    }
  }
  
  void handle_end(Timer derp) {
    watch.stop();
    watch.reset();
    period.cancel();
    total.cancel();
    
    var temp = int.parse(querySelector("#level").text);
    temp = temp + 1;
    querySelector("#level").text = temp.toString();
    querySelector(elem).text = '';
  }
  
  void handle_tick(Timer derp) {
    var time_left = this.duration - watch.elapsed.inSeconds;
    querySelector(elem).text = time_left.toString();
  }

}