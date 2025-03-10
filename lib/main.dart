import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: PetDetailsPage()));
}

class PetDetailsPage extends StatefulWidget {
  @override
  _PetDetailsPageState createState() => _PetDetailsPageState();
}

class _PetDetailsPageState extends State<PetDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _clearFields() {
    _nameController.clear();
    _breedController.clear();
    _weightController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pet Details'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Pet Name'),
            ),
            TextField(
              controller: _breedController,
              decoration: InputDecoration(labelText: 'Breed'),
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            AddAppointmentPage(onComplete: _clearFields),
                  ),
                );
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

class AddAppointmentPage extends StatefulWidget {
  final VoidCallback onComplete;
  AddAppointmentPage({required this.onComplete});

  @override
  _AddAppointmentPageState createState() => _AddAppointmentPageState();
}

class _AddAppointmentPageState extends State<AddAppointmentPage> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  List<Map<String, String>> appointments = [];

  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _timeController.text = "${picked.hour}:${picked.minute}";
      });
    }
  }

  void _saveAppointment(BuildContext context) {
    if (_dateController.text.isNotEmpty && _timeController.text.isNotEmpty) {
      appointments.add({
        'date': _dateController.text,
        'time': _timeController.text,
        'notes': _notesController.text,
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (context) => AppointmentPage(
                appointments: appointments,
                onComplete: widget.onComplete,
              ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Appointment'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Select Date'),
              readOnly: true,
              onTap: _selectDate,
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Select Time'),
              readOnly: true,
              onTap: _selectTime,
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(labelText: 'Additional Notes'),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _saveAppointment(context),
              child: Text('Save Appointment'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}

class AppointmentPage extends StatelessWidget {
  final List<Map<String, String>> appointments;
  final VoidCallback onComplete;

  AppointmentPage({required this.appointments, required this.onComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointments'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Appointment History',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: appointments.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange,
                        child: Text('A', style: TextStyle(color: Colors.white)),
                      ),
                      title: Text('Appointment ${index + 1}'),
                      subtitle: Text(
                        'Date: ${appointments[index]['date']}, Time: ${appointments[index]['time']}',
                      ),
                      trailing: Icon(Icons.check_box, color: Colors.orange),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onComplete();
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Text('Done'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            ),
          ],
        ),
      ),
    );
  }
}
