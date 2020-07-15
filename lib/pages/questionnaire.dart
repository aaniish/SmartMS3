import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:smart_ms3/pages/navigation/bottom_navigation.dart';
import 'package:smart_ms3/widgets/provider_widget.dart';
import 'package:smart_ms3/pages/bluetooth/mainBluetooth.dart';
import 'package:date_time_format/date_time_format.dart';


const Color redColor = const Color(0xFFfcbbc5);
const Color redColor2 = const Color(0xFFEA425C);

class QuestionPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: redColor2, accentColor: redColorAccent),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => BottomBarNavigation(),
      },
      home: QuestionPage(),
    );
  }
}

class QuestionPage extends StatefulWidget {
  const QuestionPage({Key key}) : super(key: key);
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  var _formKey = GlobalKey<FormState>();

  String genderValue = 'male';
  final gender = ['male', 'female'];
  final medicalHistory = [
    "Asthma",
    "Balance Problems",
    "Bladder or Urinary Infections",
    "Blood in stools",
    "Blood Clots",
    "Cancer ",
    "Chest Pain",
    "Chronic Bronchitis",
    "Cramping in leg while walking",
    "Colitis",
    "Deep Venous Thrombosis",
    "Diabetes",
    "Emphysema",
    "Fainting",
    "Frequent bloody noses or",
    "bleeding gums",
    "Gallstones",
    "Heart Attack",
    "Heart Murmur",
    "Heart Surgery",
    "High Blood Pressure",
    "High Cholesterol",
    "Joint Replacement",
    "Kidney Stones",
    "Osteoporosis",
    "Poor Circulation",
    "Recurrent infections",
    "Shortness of Breath",
    "Slowly healing wounds",
    "Stomach ulcer",
    "NONE OF THE ABOVE"
  ];
  final medicalProblems = [
    "Reaction of NSAID/anti-inflammatory medications (Advil, ibuprofen, Naproxen, Indocin, Celebrex, etc.)",
    "Fever, chills",
    "Recent weight gain, recent weight loss",
    "Changes in vision, sensitivity to light, blurred vision, double vision",
    "Change in hearing, bloody noses, sore throat, cough",
    "Shortness of breath, chest pain, wheezing, coughing of blood",
    "Palpitations, light headedness, dizziness",
    "Loss of appetite, weight loss, pain with swallowing, nausea, vomiting, abdominal pain or bloating, blood in your stools, diarrhea, constipation",
    "Difficulty urinating, pain with urination, blood in your urine",
    "Rashes, insect bites, new skin lesions",
    "NONE OF THE ABOVE"
  ];
  final shoulderSideValues = ["right", "left"];
  final shoulderProblemStart = [
    "Sports Injury",
    "Work Injury",
    "Overuse (running, cycling, swimming)",
    "Work Overuse",
    "Gradually",
    "Spontaneously (for no apparent reason)"
  ];
  final shoulderTreatment = [
    "Medications",
    "Physical therapy",
    "Cortisone Injection",
    "Surgery"
  ];
  final shoulderEquipmentTreatment = ["X-ray", "MRI", "CT scan"];
  final shoulderArea = [
    "Front  ",
    "Outer side (deltoid region)",
    "Back",
    "Upper",
    "Shoulder Blade",
    "Base of neck / trapezius region"
  ];
  final shoulderPain = [
    "Prolonged use",
    "Reaching or using over head",
    "Throwing or hitting a tennis serve",
    "Lifting weights",
    "Pulling on object off a shelf (example: gallon of milk out of refrigerator)",
    "Pulling an object up from the floor (suitcase, etc)",
    "Tucking in a shirt"
  ];
  final symptoms = [
    "Painful popping",
    "Sensation of catching (something getting caught / pinched between the bones)",
    "Coming out of joint",
    "Dead arm",
    "Pain radiating down arm",
    "Numbness in arm",
    "Swelling or discoloration of arm after throwing",
    "NONE OF THE ABOVE"
  ];
  final joint = [
    "Part way (Subluxation, the bones feel like they slip out of place)",
    "All the way (Dislocation)",
    "NONE OF THE ABOVE"
  ];
  final jobDemands = [
    "Manual Labor: including lifting, carrying, pulling, pushing, working with arms over head (eg, mechanic, construction, laborer, etc)",
    "Moderate: regular use of arms but not heavy.",
    "Office environment",
    "Student",
    "Other"
  ];
  final usualJob = [
    "Yes",
    "No, light duty",
    "No, off work due to injury",
    "No, off work for other reasons"
  ];
  final activities = [
    "High intensity sports (football, baseball, basketball, tennis, racquetball, etc)",
    "Moderate intensity sports ( recreational skiing, running, cycling, etc)",
    "Low intensity sports ( walking, golf, etc)",
    "Activities of Daily living"
  ];
  final activitiesReturn = [
    "High intensity sports (football, baseball, basketball, tennis, racquetball, etc)",
    "Moderate intensity sports ( recreational skiing, running, cycling, etc)",
    "Low intensity sports ( walking, golf, etc)",
    "Manual Labor",
    "Desk Job"
        "Activities of Daily living"
  ];
  final weights = [
    "Less than two times per week",
    "Two – three times per week",
    "More than three times per week",
    "Bodybuilder",
    "Don’t lift weights"
  ];
  final injuries = [
    "Rotator Cuff Tear",
    "Impingement",
    'Bursitis',
    'Tendinitis',
    'Frozen Shoulder',
    'Shoulder Arthritis',
    'Shoulder Instability',
    'Shoulder Dislocation',
    'Shoulder Separation'
  ];
  final shoulderSurgeries = [
    "None",
    "Arthroscopy",
    "Labral repair",
    "Tightening of shoulder",
    "Bankart repair / reconstruction",
    "Debridement / cleaning out",
    "Rotator Cuff Repair",
    "Removal of outer portion of clavicle"
  ];
  final yesNo = ["Yes", "No"];
  final pain1 = ["Unbearable", "Severe", "Moderate", "Mild", "None"];
  final pain2 = ["Very Severe", "Severe", "Moderate", "Mild", "None"];
  final painFrequency = [
    "Every day",
    "Several days per week",
    "One day per week",
    "Less than one day per week",
    "Never"
  ];
  final muscles = [
    "Anterior Deltoid",
    "Middle Deltoid",
    "Posterior Deltoid",
    "Upper Trapezius",
    "Middle Trapezius",
    "Lower Trapezius",
    "Serratus Anterior",
    "Teres Minor",
    "Upper Latissinus Doris",
    "Lower Latissinus Doris",
    "Upper Pectoralis Major",
    "Lower Pectoalis Major",
    "Supraspinatus",
    "Infraspinatus",
    "Subscapularis",
    "Rhomboid Major"
  ];
  final dateTime = new DateTime.now();
  var symptomsAns;
  var shoulderProblemStartAns;
  var shoulderTreatmentAns;
  var shoulderEquipmentTreatmentAns;
  var shoulderAreaAns;
  var shoulderPainAns;
  var shoulderSide;
  var medicalHistoryAnswers;
  var currentMedicalProblems;
  var jointAns;
  var jobDemandsAns;
  var usualJobAns;
  var activitiesBeforeAns;
  var activitiesSinceAns;
  var activitiesReturnAns;
  var weightsAns;
  var injuriesAns;
  var shoulderSurgeriesAns;
  String preventedWorkoutAns;
  String currentInjuries;
  var pain1Ans;
  var pain2Ans;
  var painFrequencyAns;

  TextEditingController name = new TextEditingController();
  TextEditingController shoulderProblemBefore = new TextEditingController();
  TextEditingController smoking = new TextEditingController();
  TextEditingController medications = new TextEditingController();
  TextEditingController allergies = new TextEditingController();
  TextEditingController age = new TextEditingController();
  TextEditingController alcohol = new TextEditingController();
  TextEditingController shoulderProblemDate = new TextEditingController();
  TextEditingController sleep = new TextEditingController();
  TextEditingController mri = new TextEditingController();
  TextEditingController handDominance = new TextEditingController();

  DateTime date;
  TextEditingController physician = new TextEditingController();
  TextEditingController lastVisit = new TextEditingController();
  TextEditingController surgeries = new TextEditingController();

  @override
  final databaseReference = Firestore.instance;

  void createRecord() async {
    final uid = await Provider.of(context).auth.getCurrentUID();
    await databaseReference
        .collection("userData")
        .document(uid)
        .collection("userInfo")
        .document("QuestionnaireAnswers")
        .setData({
      'Name': name.text,
      'Date': date,
      'Gender': genderValue,
      'Age': age.text,
      'Who is your primary care physician?': physician.text,
      'When did you last see him/her': lastVisit.text,
      'Have you ever had any of the following (in the past)?':
          medicalHistoryAnswers,
      "Do you currently have any of the following?": currentMedicalProblems,
      "What Medications do you take?": medications.text,
      "Are you allergic to any medications?": allergies.text,
      "Do you smoke?": smoking.text,
      "How much alcohol do you drink?": alcohol.text,
      "What surgeries have you had in the past?": surgeries.text,
      "Which shoulder?": shoulderSide,
      "When did your shoulder problem begin?": shoulderProblemDate.text,
      "How did it start?": shoulderProblemStartAns,
      "What treatment have you had for this shoulder injury?":
          shoulderTreatmentAns,
      "Have you had any of the following for this shoulder injury (Please bring the films to the office with you!):":
          shoulderEquipmentTreatmentAns,
      "Have you had this problem before?": shoulderProblemBefore.text,
      "What part of your shoulder hurts?": shoulderAreaAns,
      "What makes the pain worse?": shoulderPainAns,
      "Does the pain wake you up from sleep?": sleep.text,
      "Do you have any of the following?": symptomsAns,
      "Has the shoulder ever come out of joint": jointAns,
      "Describe your job’s physical demands": jobDemandsAns,
      "Are you working at your usual job": usualJobAns,
      "What were your typical most strenuous recreational activities before your shoulder problem began":
          activitiesBeforeAns,
      "What are your most strenuous recreational activities since your shoulder problem began":
          activitiesSinceAns,
      "What type of activities do you intend to return to after your shoulder problem resolves?":
          activitiesReturnAns,
      "Do you lift weights for exercise/recreation? If so, how many times per week?":
          weightsAns,
      "What did the MRI show": mri.text,
      "What prior injuries have you had to this shoulder?": injuriesAns,
      "What Surgeries have you had on this shoulder?": shoulderSurgeriesAns,
      "Hand dominance": handDominance.text,
      "Have you ever sustained a shoulder injury that prevented you from working or participating in activities of daily living or recreation":
          preventedWorkoutAns,
      "How would you describe the worst pain from your shoulder?": pain1Ans,
      "During the past month, how would you describe the usual pain in your shoulder at rest?":
          pain2Ans,
      "During the past month, how often have you had severe pain in your shoulder?":
          painFrequencyAns,
      "Curent shoulder injury": currentInjuries
    });
  }

  void createMuscleRecords(List<String> muscles) async {
    String theDate =
          DateTimeFormat.format(dateTime, format: DateTimeFormats.american);
    final uid = await Provider.of(context).auth.getCurrentUID();
    for (int i = 0; i < muscles.length; i++) {
      await databaseReference
          .collection("userData")
          .document(uid)
          .collection(muscles[i])
          .add({
            'Data': [0.0],
        'Date': theDate+" account made",
        'Time': 0.0,
        'Muscle Group': muscles[i],
        'Average': 0.0,
            });
    }
  }

  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final double categoryHeight =
        MediaQuery.of(context).size.height * 0.30 - 50;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              color: redColor,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  _AppBar(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                                child: Text(
                              "MUST COMPLETE. If already completed, exit this page",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'HelveticaNeue',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                  textInput(name, "Name", "Full Name"),
                  textInput(age, "Age", "Age"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderDateTimePicker(
                      attribute: "date",
                      inputType: InputType.date,
                      initialValue: DateTime.now(),
                      onChanged: (value) {
                        date = value;
                      },
                      format: DateFormat("yyyy-MM-dd"),
                      decoration: InputDecoration(
                        labelText: "Select date",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: genderValue,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select gender",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: gender.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          genderValue = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Select $gender';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: currentInjuries,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select current injury",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: injuries.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          currentInjuries = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Select injury';
                        }
                        return null;
                      },
                    ),
                  ),
                  textInput(handDominance, "hand dominance", "Hand dominance"),
                  textInput(physician, "Physician",
                      "Who is your primary care physician?"),
                  textInput(lastVisit, "Last Visit",
                      "When did you last see him / her?"),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Past Medical History: Please check the appropriate boxes: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "Have you ever had any of the following (in the past)?",
                        labelStyle: TextStyle(
                          fontSize: 12,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "Have you ever had any of the following (in the past)?",
                      initialValue: [medicalHistoryAnswers],
                      options: getOptions(medicalHistory),
                      onChanged: (value) {
                        medicalHistoryAnswers = value;
                        medicalHistoryAnswers.remove(null);
                      },
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Review of Systems: ",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "Do you currently have any of the following?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Do you currently have any of the following? ",
                      initialValue: [currentMedicalProblems],
                      options: getOptions(medicalProblems),
                      onChanged: (value) {
                        currentMedicalProblems = value;
                        currentMedicalProblems.remove(null);
                      },
                      validators: [FormBuilderValidators.required()],
                    ),
                  ),
                  textInput(medications, "current medications",
                      "What Medications do you take?"),
                  textInput(allergies, "allergies to medications",
                      "Allergic to any medications? If yes, what are they?"),
                  textInput(smoking, "smoking",
                      "Do you smoke? If yes, how many packs per day?"),
                  textInput(
                      alcohol, "alcohol", "How much alcohol do you drink?"),
                  textInput(surgeries, "surgeries",
                      "What surgeries have you had in the past?"),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Shoulder History:",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Which shoulder?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Which shoulder?",
                      initialValue: [shoulderSide],
                      options: getOptions(shoulderSideValues),
                      onChanged: (value) {
                        shoulderSide = value;
                        shoulderSide.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  textInput(
                      shoulderProblemDate,
                      "When did your shoulder problem begin?",
                      "When did your shoulder problem begin?"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "How did it start?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "How did it start?",
                      initialValue: [shoulderProblemStartAns],
                      options: getOptions(shoulderProblemStart),
                      onChanged: (value) {
                        shoulderProblemStartAns = value;
                        shoulderProblemStartAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "What treatment have you had for this shoulder injury?",
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "What treatment have you had for this shoulder injury?",
                      initialValue: [shoulderTreatmentAns],
                      options: getOptions(shoulderTreatment),
                      onChanged: (value) {
                        shoulderTreatmentAns = value;
                        shoulderTreatmentAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "Have you had any of the following for this shoulder injury:",
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "Have you had any of the following for this shoulder injury:",
                      initialValue: [shoulderEquipmentTreatmentAns],
                      options: getOptions(shoulderEquipmentTreatment),
                      onChanged: (value) {
                        shoulderEquipmentTreatmentAns = value;
                        shoulderEquipmentTreatmentAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  textInput(
                      shoulderProblemBefore,
                      "Have you had this problem before?",
                      "Have you had this problem before?"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "What part of your shoulder hurts?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "What part of your shoulder hurts?",
                      initialValue: [shoulderAreaAns],
                      options: getOptions(shoulderArea),
                      onChanged: (value) {
                        shoulderAreaAns = value;
                        shoulderAreaAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "What makes the pain worse?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "What makes the pain worse?",
                      initialValue: [shoulderPainAns],
                      options: getOptions(shoulderPain),
                      onChanged: (value) {
                        shoulderPainAns = value;
                        shoulderPainAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "How would you describe the worst pain from your shoulder?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select level",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "worst pain",
                      initialValue: [pain1Ans],
                      options: getOptions(pain1),
                      onChanged: (value) {
                        pain1Ans = value;
                        pain1Ans.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "During the past month, how would you describe the usual pain in your shoulder at rest",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select level",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "usual pain",
                      initialValue: [pain2Ans],
                      options: getOptions(pain2),
                      onChanged: (value) {
                        pain2Ans = value;
                        pain2Ans.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "During the past month, how often have you had severe pain in your shoulder?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select level",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "frequency pain",
                      initialValue: [painFrequencyAns],
                      options: getOptions(painFrequency),
                      onChanged: (value) {
                        painFrequencyAns = value;
                        painFrequencyAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  textInput(sleep, "Does the pain wake you up from sleep?",
                      "Does the pain wake you up from sleep?"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Do you have any of the following?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Do you have any of the following?",
                      initialValue: [symptomsAns],
                      options: getOptions(symptoms),
                      onChanged: (value) {
                        symptomsAns = value;
                        symptomsAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Has the shoulder ever come out of joint:",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Has the shoulder ever come out of joint:",
                      initialValue: [jointAns],
                      options: getOptions(joint),
                      onChanged: (value) {
                        jointAns = value;
                        jointAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Describe your job’s physical demands:",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Describe your job’s physical demands:",
                      initialValue: [jobDemandsAns],
                      options: getOptions(jobDemands),
                      onChanged: (value) {
                        jobDemandsAns = value;
                        jobDemandsAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Are you working at your usual job",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "Are you working at your usual job",
                      initialValue: [usualJobAns],
                      options: getOptions(usualJob),
                      onChanged: (value) {
                        usualJobAns = value;
                        usualJobAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "What were your typical most strenuous recreational activities before your shoulder problem began:",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select activities",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "recreational activities before",
                      initialValue: [activitiesBeforeAns],
                      options: getOptions(activities),
                      onChanged: (value) {
                        activitiesBeforeAns = value;
                        activitiesBeforeAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "What are your most strenuous recreational activities since your shoulder problem began:",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select activities",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "recreational activities since",
                      initialValue: [activitiesSinceAns],
                      options: getOptions(activities),
                      onChanged: (value) {
                        activitiesSinceAns = value;
                        activitiesSinceAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "What type of activities do you intend to return to after your shoulder problem resolves?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText: "Select activities",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute: "recreational activities after",
                      initialValue: [activitiesReturnAns],
                      options: getOptions(activitiesReturn),
                      onChanged: (value) {
                        activitiesReturnAns = value;
                        activitiesReturnAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Have you ever sustained a shoulder injury that prevented you from working or participating in activities of daily living or recreation",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: DropdownButtonFormField(
                      value: preventedWorkoutAns,
                      icon: Icon(Icons.arrow_downward),
                      decoration: InputDecoration(
                        labelText: "Select yes/no",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      items: yesNo.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      }).toList(),
                      onChanged: (String newValue) {
                        setState(() {
                          preventedWorkoutAns = newValue;
                        });
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Select yes/no';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "Do you lift weights for exercise/recreation? If so, how many times per week?",
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "Do you lift weights for exercise/recreation? If so, how many times per week?",
                      initialValue: [weightsAns],
                      options: getOptions(weights),
                      onChanged: (value) {
                        weightsAns = value;
                        weightsAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "Have you had an MRI of this shoulder since this problem began?",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'HelveticaNeue',
                        ),
                      )),
                  textInput(mri, "If so, what did the MRI show",
                      "If so, what did the MRI show"),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "What prior injuries have you had to this shoulder?",
                        labelStyle: TextStyle(
                          fontSize: 13,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "What prior injuries have you had to this shoulder?",
                      initialValue: [injuriesAns],
                      options: getOptions(injuries),
                      onChanged: (value) {
                        injuriesAns = value;
                        injuriesAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FormBuilderCheckboxList(
                      decoration: InputDecoration(
                        labelText:
                            "What Surgeries have you had on this shoulder?",
                        labelStyle: TextStyle(
                          fontSize: 15,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      attribute:
                          "What Surgeries have you had on this shoulder?",
                      initialValue: [shoulderSurgeriesAns],
                      options: getOptions(shoulderSurgeries),
                      onChanged: (value) {
                        shoulderSurgeriesAns = value;
                        shoulderSurgeriesAns.remove(null);
                      },
                      validators: [
                        FormBuilderValidators.required(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                        color: Colors.white,
                        onPressed: () {
                          if (!_formKey.currentState.validate()) {
                            return;
                          }

                          _formKey.currentState.save();
                          createRecord();
                          createMuscleRecords(muscles);
                          Navigator.of(context).pushNamed('/home');
                        },
                        child: Text(
                          "Submit",
                          style: TextStyle(
                              fontFamily: 'HelveticaNeue',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget dropDown(List<String> values, String dropState, String purpose) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: DropdownButtonFormField(
        value: dropState,
        icon: Icon(Icons.arrow_downward),
        decoration: InputDecoration(
          labelText: "Select $purpose",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        items: values.map((String value) {
          return new DropdownMenuItem<String>(
            value: value,
            child: new Text(value),
          );
        }).toList(),
        onChanged: (String newValue) {
          setState(() {
            dropState = newValue;
          });
        },
        validator: (value) {
          if (value.isEmpty) {
            return 'Select $purpose';
          }
          return null;
        },
      ),
    );
  }

  Widget multiSelect(List<String> answers, List<String> options,
      String dropState, String purpose) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: FormBuilderCheckboxList(
        decoration: InputDecoration(
          labelText: purpose,
          labelStyle: TextStyle(
            fontSize: 10,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        attribute: purpose,
        initialValue: [dropState],
        options: getOptions(options),
        onChanged: (value) {
          answers = value.cast<String>();
        },
      ),
    );
  }

  List<FormBuilderFieldOption> getOptions(List<String> options) {
    List<FormBuilderFieldOption> x = [];
    for (int i = 0; i < options.length; i++) {
      x.add(new FormBuilderFieldOption(value: options[i]));
    }
    return x;
  }

  Widget textInput(answer, String purpose, String hint) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: TextFormField(
        validator: (String value) {
          if (value.isEmpty) {
            return 'Please enter $purpose';
          }
        },
        controller: answer,
        decoration: InputDecoration(
          labelText: purpose,
          hintText: hint,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Questionnaire",
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'HelveticaNeue',
                fontSize: 30,
                fontWeight: FontWeight.bold),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed('/home');
            },
          ),
        ],
      ),
    );
  }
}
