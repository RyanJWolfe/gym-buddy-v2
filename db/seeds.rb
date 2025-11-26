# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create common exercises
exercises = [
  # Chest
  { name: "Assisted Dip", category: "Chest", equipment_type: "Machine", description: "A compound exercise that works the chest, shoulders, and triceps with assistance." },
  { name: "Band-Assisted Bench Press", category: "Chest", equipment_type: "Resistance Band", description: "A variation of the bench press with band assistance." },
  { name: "Bar Dip", category: "Chest", equipment_type: "Bodyweight", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Bench Press", category: "Chest", equipment_type: "Barbell", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Bench Press Against Band", category: "Chest", equipment_type: "Resistance Band", description: "A variation of the bench press with band resistance." },
  { name: "Board Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press that limits range of motion." },
  { name: "Cable Chest Press", category: "Chest", equipment_type: "Cable", description: "A compound exercise that works the chest with constant tension." },
  { name: "Close-Grip Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press that emphasizes the triceps." },
  { name: "Close-Grip Feet-Up Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press with feet elevated." },
  { name: "Decline Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press that emphasizes the lower chest." },
  { name: "Decline Push-Up", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up that emphasizes the lower chest." },
  { name: "Dumbbell Chest Fly", category: "Chest", equipment_type: "Dumbbell", description: "An isolation exercise that targets the chest muscles." },
  { name: "Dumbbell Chest Press", category: "Chest", equipment_type: "Dumbbell", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Dumbbell Decline Chest Press", category: "Chest", equipment_type: "Dumbbell", description: "A variation of the chest press that emphasizes the lower chest." },
  { name: "Dumbbell Floor Press", category: "Chest", equipment_type: "Dumbbell", description: "A variation of the chest press performed on the floor." },
  { name: "Dumbbell Pullover", category: "Chest", equipment_type: "Dumbbell", description: "An exercise that works the chest and lats." },
  { name: "Feet-Up Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press with feet elevated." },
  { name: "Floor Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press performed on the floor." },
  { name: "Incline Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press that emphasizes the upper chest." },
  { name: "Incline Dumbbell Press", category: "Chest", equipment_type: "Dumbbell", description: "A variation of the chest press that emphasizes the upper chest." },
  { name: "Incline Push-Up", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up that emphasizes the upper chest." },
  { name: "Kettlebell Floor Press", category: "Chest", equipment_type: "Kettlebell", description: "A variation of the chest press performed on the floor." },
  { name: "Kneeling Incline Push-Up", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up performed on knees." },
  { name: "Kneeling Push-Up", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up performed on knees." },
  { name: "Machine Chest Fly", category: "Chest", equipment_type: "Machine", description: "An isolation exercise that targets the chest muscles." },
  { name: "Machine Chest Press", category: "Chest", equipment_type: "Machine", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Pec Deck", category: "Chest", equipment_type: "Machine", description: "An isolation exercise that targets the chest muscles." },
  { name: "Pin Bench Press", category: "Chest", equipment_type: "Barbell", description: "A variation of the bench press with pins for safety." },
  { name: "Push-Up", category: "Chest", equipment_type: "Bodyweight", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Push-Up Against Wall", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up performed against a wall." },
  { name: "Push-Ups With Feet in Rings", category: "Chest", equipment_type: "Bodyweight", description: "A variation of the push-up with feet in rings." },
  { name: "Resistance Band Chest Fly", category: "Chest", equipment_type: "Resistance Band", description: "An isolation exercise that targets the chest muscles." },
  { name: "Ring Dip", category: "Chest", equipment_type: "Bodyweight", description: "A compound exercise that works the chest, shoulders, and triceps." },
  { name: "Smith Machine Bench Press", category: "Chest", equipment_type: "Machine", description: "A variation of the bench press using a Smith machine." },
  { name: "Smith Machine Incline Bench Press", category: "Chest", equipment_type: "Machine", description: "A variation of the incline bench press using a Smith machine." },
  { name: "Smith Machine Reverse Grip Bench Press", category: "Chest", equipment_type: "Machine", description: "A variation of the bench press with reverse grip." },
  { name: "Standing Cable Chest Fly", category: "Chest", equipment_type: "Cable", description: "An isolation exercise that targets the chest muscles." },
  { name: "Standing Resistance Band Chest Fly", category: "Chest", equipment_type: "Resistance Band", description: "An isolation exercise that targets the chest muscles." },

  # Shoulder
  { name: "Arnold Press", category: "Shoulder", equipment_type: "Dumbbell", description: "A variation of the shoulder press that emphasizes the anterior deltoids." },
  { name: "Band External Shoulder Rotation", category: "Shoulder", equipment_type: "Resistance Band", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Band Internal Shoulder Rotation", category: "Shoulder", equipment_type: "Resistance Band", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Band Pull-Apart", category: "Shoulder", equipment_type: "Resistance Band", description: "An exercise that targets the rear deltoids and upper back." },
  { name: "Barbell Front Raise", category: "Shoulder", equipment_type: "Barbell", description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Barbell Rear Delt Row", category: "Shoulder", equipment_type: "Barbell", description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Barbell Upright Row", category: "Shoulder", equipment_type: "Barbell", description: "A compound exercise that works the shoulders and traps." },
  { name: "Behind the Neck Press", category: "Shoulder", equipment_type: "Barbell", description: "A variation of the overhead press performed behind the neck." },
  { name: "Cable Internal Shoulder Rotation", category: "Shoulder", equipment_type: "Cable", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Cable Lateral Raise", category: "Shoulder", equipment_type: "Cable", description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Cable Rear Delt Row", category: "Shoulder", equipment_type: "Cable", description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Cuban Press", category: "Shoulder", equipment_type: "Dumbbell", description: "A complex movement that works the shoulders and rotator cuff." },
  { name: "Dumbbell Front Raise", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Dumbbell Horizontal Internal Shoulder Rotation", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Dumbbell Horizontal External Shoulder Rotation", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Dumbbell Lateral Raise", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Dumbbell Rear Delt Row", category: "Shoulder", equipment_type: "Dumbbell", description: "A compound exercise that works the rear deltoids and upper back." },
  { name: "Dumbbell Shoulder Press", category: "Shoulder", equipment_type: "Dumbbell", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Face Pull", category: "Shoulder", equipment_type: "Cable", description: "An exercise that targets the rear deltoids and upper back." },
  { name: "Front Hold", category: "Shoulder", equipment_type: "Bodyweight", description: "An isometric exercise that works the shoulders." },
  { name: "Handstand Push-Up", category: "Shoulder", equipment_type: "Bodyweight", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Landmine Press", category: "Shoulder", equipment_type: "Barbell", description: "A variation of the shoulder press using a landmine." },
  { name: "Lying Dumbbell External Shoulder Rotation", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Lying Dumbbell Internal Shoulder Rotation", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the rotator cuff." },
  { name: "Machine Lateral Raise", category: "Shoulder", equipment_type: "Machine", description: "An isolation exercise that targets the lateral deltoids." },
  { name: "Machine Shoulder Press", category: "Shoulder", equipment_type: "Machine", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Monkey Row", category: "Shoulder", equipment_type: "Bodyweight", description: "A compound exercise that works the shoulders and back." },
  { name: "One-Arm Landmine Press", category: "Shoulder", equipment_type: "Barbell", description: "A unilateral variation of the landmine press." },
  { name: "Overhead Press", category: "Shoulder", equipment_type: "Barbell", description: "A compound exercise that works the shoulders and triceps." },
  { name: "Plate Front Raise", category: "Shoulder", equipment_type: "Bodyweight", description: "An isolation exercise that targets the anterior deltoids." },
  { name: "Power Jerk", category: "Shoulder", equipment_type: "Barbell", description: "A dynamic overhead pressing movement." },
  { name: "Push Press", category: "Shoulder", equipment_type: "Barbell", description: "A dynamic overhead pressing movement." },
  { name: "Reverse Cable Flyes", category: "Shoulder", equipment_type: "Cable", description: "An isolation exercise that targets the rear deltoids." },
  { name: "Reverse Dumbbell Flyes", category: "Shoulder", equipment_type: "Dumbbell", description: "An isolation exercise that targets the rear deltoids." },
  { name: "Reverse Machine Fly", category: "Shoulder", equipment_type: "Machine", description: "An isolation exercise that targets the rear deltoids." },
  { name: "Seated Dumbbell Shoulder Press", category: "Shoulder", equipment_type: "Dumbbell", description: "A variation of the shoulder press performed seated." },
  { name: "Seated Barbell Overhead Press", category: "Shoulder", equipment_type: "Barbell", description: "A variation of the overhead press performed seated." },
  { name: "Seated Smith Machine Shoulder Press", category: "Shoulder", equipment_type: "Machine", description: "A variation of the shoulder press using a Smith machine." },
  { name: "Snatch Grip Behind the Neck Press", category: "Shoulder", equipment_type: "Barbell", description: "A variation of the overhead press with snatch grip." },
  { name: "Squat Jerk", category: "Shoulder", equipment_type: "Barbell", description: "A dynamic overhead pressing movement." },
  { name: "Split Jerk", category: "Shoulder", equipment_type: "Barbell", description: "A dynamic overhead pressing movement." },

  # Biceps
  { name: "Barbell Curl", category: "Biceps", equipment_type: "Barbell", description: "An isolation exercise that targets the biceps." },
  { name: "Barbell Preacher Curl", category: "Biceps", equipment_type: "Barbell", description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Bayesian Curl", category: "Biceps", equipment_type: "Dumbbell", description: "A variation of the bicep curl that emphasizes the brachialis." },
  { name: "Bodyweight Curl", category: "Biceps", equipment_type: "Bodyweight", description: "A bodyweight variation of the bicep curl." },
  { name: "Cable Crossover Bicep Curl", category: "Biceps", equipment_type: "Cable", description: "An isolation exercise that targets the biceps with cables." },
  { name: "Cable Curl With Bar", category: "Biceps", equipment_type: "Cable", description: "An isolation exercise that targets the biceps with a bar attachment." },
  { name: "Cable Curl With Rope", category: "Biceps", equipment_type: "Cable", description: "An isolation exercise that targets the biceps with a rope attachment." },
  { name: "Concentration Curl", category: "Biceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Drag Curl", category: "Biceps", equipment_type: "Barbell", description: "A variation of the bicep curl that emphasizes the upper biceps." },
  { name: "Dumbbell Curl", category: "Biceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the biceps." },
  { name: "Dumbbell Preacher Curl", category: "Biceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the biceps with strict form." },
  { name: "Hammer Curl", category: "Biceps", equipment_type: "Dumbbell", description: "A variation of the bicep curl that emphasizes the brachialis." },
  { name: "Incline Dumbbell Curl", category: "Biceps", equipment_type: "Dumbbell", description: "A variation of the bicep curl that emphasizes the long head of the biceps." },
  { name: "Machine Bicep Curl", category: "Biceps", equipment_type: "Machine", description: "An isolation exercise that targets the biceps." },
  { name: "Resistance Band Curl", category: "Biceps", equipment_type: "Resistance Band", description: "An isolation exercise that targets the biceps." },
  { name: "Spider Curl", category: "Biceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the biceps with strict form." },

  # Triceps
  { name: "Barbell Standing Triceps Extension", category: "Triceps", equipment_type: "Barbell", description: "An isolation exercise that targets the triceps." },
  { name: "Barbell Incline Triceps Extension", category: "Triceps", equipment_type: "Barbell", description: "A variation of the triceps extension performed on an incline." },
  { name: "Barbell Lying Triceps Extension", category: "Triceps", equipment_type: "Barbell", description: "An isolation exercise that targets the triceps." },
  { name: "Bench Dip", category: "Triceps", equipment_type: "Bodyweight", description: "A compound exercise that works the triceps and chest." },
  { name: "Crossbody Cable Triceps Extension", category: "Triceps", equipment_type: "Cable", description: "An isolation exercise that targets the triceps." },
  { name: "Close-Grip Push-Up", category: "Triceps", equipment_type: "Bodyweight", description: "A compound exercise that emphasizes the triceps." },
  { name: "Dumbbell Lying Triceps Extension", category: "Triceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the triceps." },
  { name: "Dumbbell Standing Triceps Extension", category: "Triceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the triceps." },
  { name: "Overhead Cable Triceps Extension", category: "Triceps", equipment_type: "Cable", description: "An isolation exercise that targets the long head of the triceps." },
  { name: "Tate Press", category: "Triceps", equipment_type: "Dumbbell", description: "An isolation exercise that targets the triceps." },
  { name: "Tricep Bodyweight Extension", category: "Triceps", equipment_type: "Bodyweight", description: "A bodyweight variation of the triceps extension." },
  { name: "Tricep Pushdown With Bar", category: "Triceps", equipment_type: "Cable", description: "An isolation exercise that targets the triceps with a bar attachment." },
  { name: "Tricep Pushdown With Rope", category: "Triceps", equipment_type: "Cable", description: "An isolation exercise that targets the triceps with a rope attachment." },

  # Legs
  { name: "Barbell Front Squat", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the quadriceps and core." },
  { name: "Barbell Hack Squat", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the quadriceps." },
  { name: "Barbell Lunge", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Barbell Romanian Deadlift", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the hamstrings and glutes." },
  { name: "Barbell Squat", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the quadriceps, hamstrings, and glutes." },
  { name: "Bodyweight Squat", category: "Legs", equipment_type: "Bodyweight", description: "A compound exercise that targets the lower body." },
  { name: "Bulgarian Split Squat", category: "Legs", equipment_type: "Dumbbell", description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Calf Raise", category: "Legs", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },
  { name: "Dumbbell Lunge", category: "Legs", equipment_type: "Dumbbell", description: "A compound exercise that targets the quadriceps and glutes." },
  { name: "Dumbbell Romanian Deadlift", category: "Legs", equipment_type: "Dumbbell", description: "A compound exercise that targets the hamstrings and glutes." },
  { name: "Dumbbell Squat", category: "Legs", equipment_type: "Dumbbell", description: "A compound exercise that targets the lower body." },
  { name: "Hip Thrust", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Leg Extension", category: "Legs", equipment_type: "Machine", description: "An isolation exercise that targets the quadriceps." },
  { name: "Leg Press", category: "Legs", equipment_type: "Machine", description: "A compound exercise that targets the lower body." },
  { name: "Romanian Deadlift", category: "Legs", equipment_type: "Barbell", description: "A compound exercise that targets the hamstrings and glutes." },
  { name: "Seated Calf Raise", category: "Legs", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },

  # Back
  { name: "Barbell Bent Over Row", category: "Back", equipment_type: "Barbell", description: "A compound exercise that targets the upper back and lats." },
  { name: "Barbell Deadlift", category: "Back", equipment_type: "Barbell", description: "A compound exercise that targets the entire back and posterior chain." },
  { name: "Barbell Good Morning", category: "Back", equipment_type: "Barbell", description: "A compound exercise that targets the lower back and hamstrings." },
  { name: "Barbell Row", category: "Back", equipment_type: "Barbell", description: "A compound exercise that targets the upper back and lats." },
  { name: "Cable Face Pull", category: "Back", equipment_type: "Cable", description: "An isolation exercise that targets the rear deltoids and upper back." },
  { name: "Cable Lat Pulldown", category: "Back", equipment_type: "Cable", description: "A compound exercise that targets the lats." },
  { name: "Cable Row", category: "Back", equipment_type: "Cable", description: "A compound exercise that targets the upper back and lats." },
  { name: "Chin-Up", category: "Back", equipment_type: "Bodyweight", description: "A compound exercise that targets the lats and biceps." },
  { name: "Dumbbell Bent Over Row", category: "Back", equipment_type: "Dumbbell", description: "A compound exercise that targets the upper back and lats." },
  { name: "Dumbbell Row", category: "Back", equipment_type: "Dumbbell", description: "A compound exercise that targets the upper back and lats." },
  { name: "Inverted Row", category: "Back", equipment_type: "Bodyweight", description: "A compound exercise that targets the upper back and lats." },
  { name: "Lat Pulldown", category: "Back", equipment_type: "Machine", description: "A compound exercise that targets the lats." },
  { name: "Pull-Up", category: "Back", equipment_type: "Bodyweight", description: "A compound exercise that targets the lats and upper back." },
  { name: "Seated Cable Row", category: "Back", equipment_type: "Cable", description: "A compound exercise that targets the upper back and lats." },
  { name: "T-Bar Row", category: "Back", equipment_type: "Barbell", description: "A compound exercise that targets the upper back and lats." },

  # Glute
  { name: "Barbell Hip Thrust", category: "Glute", equipment_type: "Barbell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Barbell Romanian Deadlift", category: "Glute", equipment_type: "Barbell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Cable Pull Through", category: "Glute", equipment_type: "Cable", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Dumbbell Romanian Deadlift", category: "Glute", equipment_type: "Dumbbell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Glute Bridge", category: "Glute", equipment_type: "Bodyweight", description: "An isolation exercise that targets the glutes." },
  { name: "Hip Abduction", category: "Glute", equipment_type: "Machine", description: "An isolation exercise that targets the gluteus medius." },
  { name: "Hip Extension", category: "Glute", equipment_type: "Machine", description: "An isolation exercise that targets the glutes." },
  { name: "Kettlebell Swing", category: "Glute", equipment_type: "Kettlebell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Lateral Band Walk", category: "Glute", equipment_type: "Resistance Band", description: "An isolation exercise that targets the gluteus medius." },
  { name: "Romanian Deadlift", category: "Glute", equipment_type: "Barbell", description: "A compound exercise that targets the glutes and hamstrings." },
  { name: "Single-Leg Glute Bridge", category: "Glute", equipment_type: "Bodyweight", description: "An isolation exercise that targets the glutes." },
  { name: "Step-Up", category: "Glute", equipment_type: "Dumbbell", description: "A compound exercise that targets the glutes and quadriceps." },

  # Abs
  { name: "Ab Wheel Rollout", category: "Abs", equipment_type: "Ab Wheel", description: "A compound exercise that targets the core." },
  { name: "Cable Woodchop", category: "Abs", equipment_type: "Cable", description: "A compound exercise that targets the obliques." },
  { name: "Crunch", category: "Abs", equipment_type: "Bodyweight", description: "An isolation exercise that targets the rectus abdominis." },
  { name: "Dumbbell Side Bend", category: "Abs", equipment_type: "Dumbbell", description: "An isolation exercise that targets the obliques." },
  { name: "Hanging Leg Raise", category: "Abs", equipment_type: "Bodyweight", description: "A compound exercise that targets the lower abs." },
  { name: "Knee Raise", category: "Abs", equipment_type: "Bodyweight", description: "A compound exercise that targets the lower abs." },
  { name: "Plank", category: "Abs", equipment_type: "Bodyweight", description: "An isometric exercise that targets the core." },
  { name: "Russian Twist", category: "Abs", equipment_type: "Dumbbell", description: "A compound exercise that targets the obliques." },
  { name: "Side Plank", category: "Abs", equipment_type: "Bodyweight", description: "An isometric exercise that targets the obliques." },
  { name: "Sit-Up", category: "Abs", equipment_type: "Bodyweight", description: "A compound exercise that targets the rectus abdominis." },
  { name: "Toe Touch", category: "Abs", equipment_type: "Bodyweight", description: "A compound exercise that targets the rectus abdominis." },
  { name: "V-Up", category: "Abs", equipment_type: "Bodyweight", description: "A compound exercise that targets the rectus abdominis." },

  # Calves
  { name: "Calf Raise", category: "Calves", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },
  { name: "Donkey Calf Raise", category: "Calves", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },
  { name: "Jump Rope", category: "Calves", equipment_type: "Jump Rope", description: "A compound exercise that targets the calves and cardiovascular system." },
  { name: "Seated Calf Raise", category: "Calves", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },
  { name: "Standing Calf Raise", category: "Calves", equipment_type: "Machine", description: "An isolation exercise that targets the calves." },

  # Forearm Flexors
  { name: "Barbell Wrist Curl", category: "Forearm Flexors", equipment_type: "Barbell", description: "An isolation exercise that targets the forearm flexors." },
  { name: "Dumbbell Wrist Curl", category: "Forearm Flexors", equipment_type: "Dumbbell", description: "An isolation exercise that targets the forearm flexors." },
  { name: "Farmer's Walk", category: "Forearm Flexors", equipment_type: "Dumbbell", description: "A compound exercise that targets the forearm flexors and grip strength." },
  { name: "Plate Pinch", category: "Forearm Flexors", equipment_type: "Weight Plate", description: "An isolation exercise that targets the forearm flexors and grip strength." },
  { name: "Towel Pull-Up", category: "Forearm Flexors", equipment_type: "Bodyweight", description: "A compound exercise that targets the forearm flexors and grip strength." },

  # Forearm Extensors
  { name: "Barbell Reverse Wrist Curl", category: "Forearm Extensors", equipment_type: "Barbell", description: "An isolation exercise that targets the forearm extensors." },
  { name: "Dumbbell Reverse Wrist Curl", category: "Forearm Extensors", equipment_type: "Dumbbell", description: "An isolation exercise that targets the forearm extensors." },
  { name: "Finger Extension", category: "Forearm Extensors", equipment_type: "Resistance Band", description: "An isolation exercise that targets the forearm extensors." },
  { name: "Reverse Grip Barbell Curl", category: "Forearm Extensors", equipment_type: "Barbell", description: "A compound exercise that targets the forearm extensors and biceps." },
  { name: "Reverse Grip Dumbbell Curl", category: "Forearm Extensors", equipment_type: "Dumbbell", description: "A compound exercise that targets the forearm extensors and biceps." },

  # Cardio Training
  { name: "Burpee", category: "Cardio Training", equipment_type: "Bodyweight", description: "A compound exercise that targets the entire body and cardiovascular system." },
  { name: "High-Intensity Interval Training (HIIT)", category: "Cardio Training", equipment_type: "Bodyweight", description: "A form of cardiovascular exercise that alternates between high-intensity and low-intensity periods." },
  { name: "Jump Rope", category: "Cardio Training", equipment_type: "Jump Rope", description: "A compound exercise that targets the cardiovascular system and coordination." },
  { name: "Mountain Climber", category: "Cardio Training", equipment_type: "Bodyweight", description: "A compound exercise that targets the core and cardiovascular system." },
  { name: "Running", category: "Cardio Training", equipment_type: "Bodyweight", description: "A compound exercise that targets the cardiovascular system and lower body." },
  { name: "Sprint", category: "Cardio Training", equipment_type: "Bodyweight", description: "A high-intensity compound exercise that targets the cardiovascular system and lower body." },
  { name: "Swimming", category: "Cardio Training", equipment_type: "Bodyweight", description: "A compound exercise that targets the entire body and cardiovascular system." },
  { name: "Tabata", category: "Cardio Training", equipment_type: "Bodyweight", description: "A form of high-intensity interval training that alternates between 20 seconds of work and 10 seconds of rest." }
]

puts "Creating exercises..."
exercises.each do |exercise_data|
  Exercise.find_or_create_by!(name: exercise_data[:name]) do |exercise|
    exercise.category = exercise_data[:category]
    exercise.equipment_type = exercise_data[:equipment_type]
    exercise.description = exercise_data[:description]
  end
end

puts "Created #{Exercise.count} exercises"

# Demo seeds are now run explicitly via the rake task `db:seed:demo`.
# This file no longer auto-loads demo data so `bin/rails db:seed` is safe to run
# without creating demo workouts. To run demo seeds:
#
#   RAILS_ENV=development bin/rails db:seed:demo
#
puts "Seed completed successfully!"
