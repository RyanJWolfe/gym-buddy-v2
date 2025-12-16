# db/seeds/exercises.rb

# frozen_string_literal: true

CHEST = "chest"
SHOULDERS = "shoulders"
REAR_DELTS = "rear delts"
TRICEPS = "triceps"
LATS = "lats"
LOWER_BACK = "lower back"
UPPER_BACK = "upper back"
BICEPS = "biceps"
FOREARMS = "forearms"
TRAPS = "traps"
QUADRICEPS = "quadriceps"
HAMSTRINGS = "hamstrings"
GLUTES = "glutes"
CALVES = "calves"
ABDUCTORS = "abductors"
ADDUCTORS = "adductors"
NECK = "neck"
ABDOMINALS = "abdominals"
OTHER = "other"


# rubocop:disable Layout/LineLength
EXERCISES = [
  # Chest
  { name: "Assisted Dip", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :machine, description: "A compound exercise that works the chest, shoulders, and triceps with assistance." },
  { name: "Band-Assisted Bench Press", categories: [ CHEST ], equipment_type: :resistance_band, description: "A variation of the bench press with band assistance." },
  { name: "Bar Dip", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Bench Press", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :barbell, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Bench Press Against Band", categories: [ CHEST ], equipment_type: :resistance_band, description: "A variation of the bench press with band resistance." },
  { name: "Board Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press that limits range of motion." },
  { name: "Cable Chest Press", categories: [ CHEST ], equipment_type: :cable, description: "A compound exercise that works the chest with constant tension." },
  { name: "Close-Grip Bench Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press that emphasizes the triceps." },
  { name: "Close-Grip Feet-Up Bench Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press with feet elevated." },
  { name: "Decline Bench Press", categories: [ CHEST ], equipment_type: :barbell, description: "A variation of the bench press that emphasizes the lower chest." },
  { name: "Decline Push-Up", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A variation of the push-up that emphasizes the lower chest." },
  { name: "Dumbbell Chest Fly", categories: [ CHEST ], equipment_type: :dumbbell, description: "An isolation exercise that targets the chest muscles." },
  { name: "Dumbbell Chest Press", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :dumbbell, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Dumbbell Decline Chest Press", categories: [ CHEST ], equipment_type: :dumbbell, description: "A variation of the chest press that emphasizes the lower chest." },
  { name: "Dumbbell Floor Press", categories: [ CHEST, TRICEPS ], equipment_type: :dumbbell, description: "A variation of the chest press performed on the floor." },
  { name: "Dumbbell Pullover", categories: [ CHEST, BACK ], equipment_type: :dumbbell, description: "An exercise that works the chest and lats." },
  { name: "Feet-Up Bench Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press with feet elevated." },
  { name: "Floor Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press performed on the floor." },
  { name: "Incline Bench Press", categories: [ CHEST, SHOULDERS ], equipment_type: :barbell, description: "A variation of the bench press that emphasizes the upper chest." },
  { name: "Incline Dumbbell Press", categories: [ CHEST, SHOULDERS ], equipment_type: :dumbbell, description: "A variation of the chest press that emphasizes the upper chest." },
  { name: "Incline Push-Up", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A variation of the push-up that emphasizes the upper chest." },
  { name: "Kettlebell Floor Press", categories: [ CHEST, TRICEPS ], equipment_type: :kettlebell, description: "A variation of the chest press performed on the floor." },
  { name: "Kneeling Incline Push-Up", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A variation of the push-up performed on knees." },
  { name: "Kneeling Push-Up", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A variation of the push-up performed on knees." },
  { name: "Machine Chest Fly", categories: [ CHEST ], equipment_type: :machine, description: "An isolation exercise that targets the chest muscles." },
  { name: "Machine Chest Press", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :machine, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Pec Deck", categories: [ CHEST ], equipment_type: :machine, description: "An isolation exercise that targets the chest muscles." },
  { name: "Pin Bench Press", categories: [ CHEST, TRICEPS ], equipment_type: :barbell, description: "A variation of the bench press with pins for safety." },
  { name: "Push-Up", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Push-Up Against Wall", categories: [ CHEST, SHOULDERS ], equipment_type: :bodyweight, description: "A variation of the push-up performed against a wall." },
  { name: "Push-Ups With Feet in Rings", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A variation of the push-up with feet in rings." },
  { name: "Resistance Band Chest Fly", categories: [ CHEST ], equipment_type: :resistance_band, description: "An isolation exercise that targets the chest muscles." },
  { name: "Ring Dip", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Smith Machine Bench Press", categories: [ CHEST, SHOULDERS, TRICEPS ], equipment_type: :machine, description: "A variation of the bench press using a Smith machine." },
  { name: "Smith Machine Incline Bench Press", categories: [ CHEST, SHOULDERS ], equipment_type: :machine, description: "A variation of the incline bench press using a Smith machine." },
  { name: "Smith Machine Reverse Grip Bench Press", categories: [ CHEST, TRICEPS ], equipment_type: :machine, description: "A variation of the bench press with reverse grip." },
  { name: "Standing Cable Chest Fly", categories: [ CHEST ], equipment_type: :cable, description: "An isolation exercise that targets the chest muscles." },
  { name: "Standing Resistance Band Chest Fly", categories: [ CHEST ], equipment_type: :resistance_band, description: "An isolation exercise that targets the chest muscles." },

  # Shoulder
  { name: "Arnold Press", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "A variation of the shoulder press that emphasizes the anterior deltoids." },
  { name: "Band External Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :resistance_band, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Band Internal Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :resistance_band, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Band Pull-Apart", categories: [ SHOULDERS, BACK ], equipment_type: :resistance_band, description: "An exercise that targets the rear deltoids and upper back." },
  { name: "Barbell Front Raise", categories: [ SHOULDERS ], equipment_type: :barbell, description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Barbell Rear Delt Row", categories: [ SHOULDERS, BACK ], equipment_type: :barbell, description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Barbell Upright Row", categories: [ SHOULDERS, BACK ], equipment_type: :barbell, description: "A compound exercise that works the shoulders and traps." },
  { name: "Behind the Neck Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :barbell, description: "A variation of the overhead press performed behind the neck." },
  { name: "Cable Internal Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :cable, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Cable Lateral Raise", categories: [ SHOULDERS ], equipment_type: :cable, description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Cable Rear Delt Row", categories: [ SHOULDERS, BACK ], equipment_type: :cable, description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Cuban Press", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "A complex movement that works the shoulders and rotator cuff." },
  { name: "Dumbbell Front Raise", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Dumbbell Horizontal Internal Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Dumbbell Horizontal External Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Dumbbell Lateral Raise", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Dumbbell Rear Delt Row", categories: [ SHOULDERS, BACK ], equipment_type: :dumbbell, description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Dumbbell Shoulder Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :dumbbell, description: "A compound exercise that works the shoulders and triceps." },
  { name: "Face Pull", categories: [ SHOULDERS, BACK ], equipment_type: :cable, description: "An exercise that targets the rear deltoids and upper back." },
  { name: "Front Hold", categories: [ SHOULDERS, ABDOMINALS ], equipment_type: :bodyweight, description: "An isometric exercise that works the shoulders." },
  { name: "Handstand Push-Up", categories: [ SHOULDERS, TRICEPS ], equipment_type: :bodyweight, description: "A compound exercise that works the shoulders and triceps." },
  { name: "Landmine Press", categories: [ SHOULDERS, CHEST ], equipment_type: :barbell, description: "A variation of the shoulder press using a landmine." },
  { name: "Lying Dumbbell External Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Lying Dumbbell Internal Shoulder Rotation", categories: [ SHOULDERS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the rotator cuff." },
  { name: "Machine Lateral Raise", categories: [ SHOULDERS ], equipment_type: :machine, description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Machine Shoulder Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :machine, description: "A compound exercise that works the shoulders and triceps." },
  { name: "Monkey Row", categories: [ SHOULDERS, BACK ], equipment_type: :bodyweight, description: "A compound exercise that works the shoulders and back." },
  { name: "One-Arm Landmine Press", categories: [ SHOULDERS, CHEST ], equipment_type: :barbell, description: "A unilateral variation of the landmine press." },
  { name: "Overhead Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :barbell, description: "A compound exercise that works the shoulders and triceps." },
  { name: "Plate Front Raise", categories: [ SHOULDERS ], equipment_type: :bodyweight, description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Power Jerk", categories: [ SHOULDERS, LEGS ], equipment_type: :barbell, description: "A dynamic overhead pressing movement." },
  { name: "Push Press", categories: [ SHOULDERS, LEGS ], equipment_type: :barbell, description: "A dynamic overhead pressing movement." },
  { name: "Reverse Cable Flyes", categories: [ SHOULDERS, BACK ], equipment_type: :cable, description: "An isolation exercise that targets the rear deltoids." },
  { name: "Reverse Dumbbell Flyes", categories: [ SHOULDERS, BACK ], equipment_type: :dumbbell, description: "An isolation exercise that targets the rear deltoids." },
  { name: "Reverse Machine Fly", categories: [ SHOULDERS, BACK ], equipment_type: :machine, description: "An isolation exercise that targets the rear deltoids." },
  { name: "Seated Dumbbell Shoulder Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :dumbbell, description: "A variation of the shoulder press performed seated." },
  { name: "Seated Barbell Overhead Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :barbell, description: "A variation of the overhead press performed seated." },
  { name: "Seated Smith Machine Shoulder Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :machine, description: "A variation of the shoulder press using a Smith machine." },
  { name: "Snatch Grip Behind the Neck Press", categories: [ SHOULDERS, TRICEPS ], equipment_type: :barbell, description: "A variation of the overhead press with snatch grip." },
  { name: "Squat Jerk", categories: [ SHOULDERS, LEGS ], equipment_type: :barbell, description: "A dynamic overhead pressing movement." },
  { name: "Split Jerk", categories: [ SHOULDERS, LEGS ], equipment_type: :barbell, description: "A dynamic overhead pressing movement." },

  # Biceps
  { name: "Barbell Curl", categories: [ BICEPS ], equipment_type: :barbell, description: "An isolation exercise that targets the biceps." },
  { name: "Barbell Preacher Curl", categories: [ BICEPS ], equipment_type: :barbell, description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Bayesian Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "A variation of the bicep curl that emphasizes the brachialis." },
  { name: "Bodyweight Curl", categories: [ BICEPS ], equipment_type: :bodyweight, description: "A bodyweight variation of the bicep curl." },
  { name: "Cable Crossover Bicep Curl", categories: [ BICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the biceps with cables." },
  { name: "Cable Curl With Bar", categories: [ BICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the biceps with a bar attachment." },
  { name: "Cable Curl With Rope", categories: [ BICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the biceps with a rope attachment." },
  { name: "Concentration Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Drag Curl", categories: [ BICEPS ], equipment_type: :barbell, description: "A variation of the bicep curl that emphasizes the upper biceps." },
  { name: "Dumbbell Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the biceps." },
  { name: "Dumbbell Preacher Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Hammer Curl", categories: [ BICEPS, FOREARMS ], equipment_type: :dumbbell, description: "A variation of the bicep curl that emphasizes the brachialis." },
  { name: "Incline Dumbbell Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "A variation of the bicep curl that emphasizes the long head of the biceps." },
  { name: "Machine Bicep Curl", categories: [ BICEPS ], equipment_type: :machine, description: "An isolation exercise that targets the biceps." },
  { name: "Resistance Band Curl", categories: [ BICEPS ], equipment_type: :resistance_band, description: "An isolation exercise that targets the biceps." },
  { name: "Spider Curl", categories: [ BICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the biceps with strict form." },

  # Triceps
  { name: "Barbell Standing Triceps Extension", categories: [ TRICEPS ], equipment_type: :barbell, description: "An isolation exercise that targets the triceps." },
  { name: "Barbell Incline Triceps Extension", categories: [ TRICEPS ], equipment_type: :barbell, description: "A variation of the triceps extension performed on an incline." },
  { name: "Barbell Lying Triceps Extension", categories: [ TRICEPS ], equipment_type: :barbell, description: "An isolation exercise that targets the triceps." },
  { name: "Bench Dip", categories: [ TRICEPS, CHEST, SHOULDERS ], equipment_type: :bodyweight, description: "A compound exercise that works the triceps and chest." },
  { name: "Crossbody Cable Triceps Extension", categories: [ TRICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the triceps." },
  { name: "Close-Grip Push-Up", categories: [ TRICEPS, CHEST, SHOULDERS ], equipment_type: :bodyweight, description: "A compound exercise that emphasizes the triceps." },
  { name: "Dumbbell Lying Triceps Extension", categories: [ TRICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the triceps." },
  { name: "Dumbbell Standing Triceps Extension", categories: [ TRICEPS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the triceps." },
  { name: "Overhead Cable Triceps Extension", categories: [ TRICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the long head of the triceps." },
  { name: "Tate Press", categories: [ TRICEPS, CHEST ], equipment_type: :dumbbell, description: "An isolation exercise that targets the triceps." },
  { name: "Tricep Bodyweight Extension", categories: [ TRICEPS ], equipment_type: :bodyweight, description: "A bodyweight variation of the triceps extension." },
  { name: "Tricep Pushdown With Bar", categories: [ TRICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the triceps with a bar attachment." },
  { name: "Tricep Pushdown With Rope", categories: [ TRICEPS ], equipment_type: :cable, description: "An isolation exercise that targets the triceps with a rope attachment." },

  # Legs
  { name: "Barbell Front Squat", categories: [ LEGS, ABDOMINALS ], equipment_type: :barbell, description: "A compound exercise that targets the quadriceps and core." },
  { name: "Barbell Hack Squat", categories: [ LEGS ], equipment_type: :barbell, description: "A compound exercise that targets the quadriceps." },
  { name: "Barbell Lunge", categories: [ LEGS, GLUTES ], equipment_type: :barbell, description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Barbell Squat", categories: [ LEGS, GLUTES, BACK ], equipment_type: :barbell, description: "A compound exercise that targets the quadriceps, hamstrings, and glutes." },
  { name: "Bodyweight Squat", categories: [ LEGS, GLUTES ], equipment_type: :bodyweight, description: "A compound exercise that targets the lower body." },
  { name: "Bulgarian Split Squat", categories: [ LEGS, GLUTES ], equipment_type: :dumbbell, description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Dumbbell Lunge", categories: [ LEGS, GLUTES ], equipment_type: :dumbbell, description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Dumbbell Squat", categories: [ LEGS, GLUTES ], equipment_type: :dumbbell, description: "A compound exercise that targets the lower body." },
  { name: "Hip Thrust", categories: [ LEGS, GLUTES ], equipment_type: :barbell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Leg Extension", categories: [ LEGS ], equipment_type: :machine, description: "An isolation exercise that targets the quadriceps." },
  { name: "Leg Press", categories: [ LEGS, GLUTES ], equipment_type: :machine, description: "A compound exercise that targets the lower body." },

  # Back
  { name: "Barbell Bent Over Row", categories: [ BACK ], equipment_type: :barbell, description: "A compound exercise that targets the upper back and lats." },
  { name: "Barbell Deadlift", categories: [ BACK, LEGS, GLUTES ], equipment_type: :barbell, description: "A compound exercise that targets the entire back and posterior chain." },
  { name: "Barbell Good Morning", categories: [ BACK, LEGS, GLUTES ], equipment_type: :barbell, description: "A compound exercise that targets the lower back and hamstrings." },
  { name: "Barbell Row", categories: [ BACK ], equipment_type: :barbell, description: "A compound exercise that targets the upper back and lats." },
  { name: "Cable Face Pull", categories: [ BACK, SHOULDERS ], equipment_type: :cable, description: "An isolation exercise that targets the rear deltoids and upper back." },
  { name: "Cable Lat Pulldown", categories: [ BACK ], equipment_type: :cable, description: "A compound exercise that targets the lats." },
  { name: "Cable Row", categories: [ BACK ], equipment_type: :cable, description: "A compound exercise that targets the upper back and lats." },
  { name: "Chin-Up", categories: [ BACK, BICEPS ], equipment_type: :bodyweight, description: "A compound exercise that targets the lats and biceps." },
  { name: "Dumbbell Bent Over Row", categories: [ BACK ], equipment_type: :dumbbell, description: "A compound exercise that targets the upper back and lats." },
  { name: "Dumbbell Row", categories: [ BACK ], equipment_type: :dumbbell, description: "A compound exercise that targets the upper back and lats." },
  { name: "Inverted Row", categories: [ BACK, BICEPS ], equipment_type: :bodyweight, description: "A compound exercise that targets the upper back and lats." },
  { name: "Lat Pulldown", categories: [ BACK ], equipment_type: :machine, description: "A compound exercise that targets the lats." },
  { name: "Pull-Up", categories: [ BACK, BICEPS ], equipment_type: :bodyweight, description: "A compound exercise that targets the lats and upper back." },
  { name: "Seated Cable Row", categories: [ BACK ], equipment_type: :cable, description: "A compound exercise that targets the upper back and lats." },
  { name: "T-Bar Row", categories: [ BACK ], equipment_type: :barbell, description: "A compound exercise that targets the upper back and lats." },

  # Glute
  { name: "Barbell Hip Thrust", categories: [ GLUTES, LEGS ], equipment_type: :barbell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Barbell Romanian Deadlift", categories: [ GLUTES, LEGS, BACK ], equipment_type: :barbell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Cable Pull Through", categories: [ GLUTES, LEGS ], equipment_type: :cable, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Dumbbell Romanian Deadlift", categories: [ GLUTES, LEGS, BACK ], equipment_type: :dumbbell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Glute Bridge", categories: [ GLUTES ], equipment_type: :bodyweight, description: "An isolation exercise that targets the glutes." },
  { name: "Hip Abduction", categories: [ GLUTES ], equipment_type: :machine, description: "An isolation exercise that targets the gluteus medius." },
  { name: "Hip Extension", categories: [ GLUTES ], equipment_type: :machine, description: "An isolation exercise that targets the glutes." },
  { name: "Kettlebell Swing", categories: [ GLUTES, LEGS, BACK, "Cardio Training" ], equipment_type: :kettlebell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Lateral Band Walk", categories: [ GLUTES ], equipment_type: :resistance_band, description: "An isolation exercise that targets the gluteus medius." },
  { name: "Romanian Deadlift", categories: [ GLUTES, LEGS, BACK ], equipment_type: :barbell, description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Single-Leg Glute Bridge", categories: [ GLUTES ], equipment_type: :bodyweight, description: "An isolation exercise that targets the glutes." },
  { name: "Step-Up", categories: [ GLUTES, LEGS ], equipment_type: :dumbbell, description: "A compound exercise that targets the glutes and quadriceps." },

  # Abs
  { name: "Ab Wheel Rollout", categories: [ ABDOMINALS ], equipment_type: :other, description: "A compound exercise that targets the core." },
  { name: "Cable Woodchop", categories: [ ABDOMINALS ], equipment_type: :cable, description: "A compound exercise that targets the obliques." },
  { name: "Crunch", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "An isolation exercise that targets the rectus abdominis." },
  { name: "Dumbbell Side Bend", categories: [ ABDOMINALS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the obliques." },
  { name: "Hanging Leg Raise", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the lower abs." },
  { name: "Knee Raise", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the lower abs." },
  { name: "Plank", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "An isometric exercise that targets the core." },
  { name: "Russian Twist", categories: [ ABDOMINALS ], equipment_type: :dumbbell, description: "A compound exercise that targets the obliques." },
  { name: "Side Plank", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "An isometric exercise that targets the obliques." },
  { name: "Sit-Up", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the rectus abdominis." },
  { name: "Toe Touch", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the rectus abdominis." },
  { name: "V-Up", categories: [ ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the rectus abdominis." },

  # Calves
  { name: "Calf Raise", categories: [ "Calves", LEGS ], equipment_type: :machine, description: "An isolation exercise that targets the calves." },
  { name: "Donkey Calf Raise", categories: [ "Calves", LEGS ], equipment_type: :machine, description: "An isolation exercise that targets the calves." },
  { name: "Seated Calf Raise", categories: [ "Calves", LEGS ], equipment_type: :machine, description: "An isolation exercise that targets the calves." },
  { name: "Standing Calf Raise", categories: [ "Calves", LEGS ], equipment_type: :machine, description: "An isolation exercise that targets the calves." },

  # Forearm Flexors
  { name: "Barbell Wrist Curl", categories: [ "Forearm Flexors" ], equipment_type: :barbell, description: "An isolation exercise that targets the forearm flexors." },
  { name: "Dumbbell Wrist Curl", categories: [ "Forearm Flexors" ], equipment_type: :dumbbell, description: "An isolation exercise that targets the forearm flexors." },
  { name: "Farmer's Walk", categories: [ "Forearm Flexors", BACK, ABDOMINALS ], equipment_type: :dumbbell, description: "A compound exercise that targets the forearm flexors and grip strength." },
  { name: "Plate Pinch", categories: [ "Forearm Flexors" ], equipment_type: :plate, description: "An isolation exercise that targets the forearm flexors and grip strength." },
  { name: "Towel Pull-Up", categories: [ "Forearm Flexors", BACK, BICEPS ], equipment_type: :bodyweight, description: "A compound exercise that targets the forearm flexors and grip strength." },

  # Forearm Extensors
  { name: "Barbell Reverse Wrist Curl", categories: [ FOREARMS ], equipment_type: :barbell, description: "An isolation exercise that targets the forearm extensors." },
  { name: "Dumbbell Reverse Wrist Curl", categories: [ FOREARMS ], equipment_type: :dumbbell, description: "An isolation exercise that targets the forearm extensors." },
  { name: "Finger Extension", categories: [ FOREARMS ], equipment_type: :resistance_band, description: "An isolation exercise that targets the forearm extensors." },
  { name: "Reverse Grip Barbell Curl", categories: [ FOREARMS, BICEPS ], equipment_type: :barbell, description: "A compound exercise that targets the forearm extensors and biceps." },
  { name: "Reverse Grip Dumbbell Curl", categories: [ FOREARMS, BICEPS ], equipment_type: :dumbbell, description: "A compound exercise that targets the forearm extensors and biceps." },

  # Cardio Training
  { name: "Burpee", categories: [ "Cardio Training", LEGS, CHEST, SHOULDERS ], equipment_type: :bodyweight, description: "A compound exercise that targets the entire body and cardiovascular system." },
  { name: "High-Intensity Interval Training (HIIT)", categories: [ "Cardio Training" ], equipment_type: :bodyweight, description: "A form of cardiovascular exercise that alternates between high-intensity and low-intensity periods." },
  { name: :other, categories: [ "Cardio Training", "Calves" ], equipment_type: :other, description: "A compound exercise that targets the cardiovascular system and coordination." },
  { name: "Mountain Climber", categories: [ "Cardio Training", ABDOMINALS ], equipment_type: :bodyweight, description: "A compound exercise that targets the core and cardiovascular system." },
  { name: "Running", categories: [ "Cardio Training", LEGS ], equipment_type: :bodyweight, description: "A compound exercise that targets the cardiovascular system and lower body." },
  { name: "Sprint", categories: [ "Cardio Training", LEGS ], equipment_type: :bodyweight, description: "A high-intensity compound exercise that targets the cardiovascular system and lower body." },
  { name: "Swimming", categories: [ "Cardio Training", BACK, SHOULDERS, CHEST ], equipment_type: :bodyweight, description: "A compound exercise that targets the entire body and cardiovascular system." },
  { name: "Tabata", categories: [ "Cardio Training" ], equipment_type: :bodyweight, description: "A form of high-intensity interval training that alternates between 20 seconds of work and 10 seconds of rest." }
].freeze
# rubocop:enable Layout/LineLength
