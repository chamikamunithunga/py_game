import random

def provide_hint(number_to_guess):
    if number_to_guess % 2 == 0:
        print("Hint: The number is even.")
    else:
        print("Hint: The number is odd.")

    for i in range(2, 10):
        if number_to_guess % i == 0:
            print(f"Hint: The number is divisible by {i}.")
            break

def save_score(player_name, difficulty, score, attempts):
    with open("scores.txt", "a") as file:
        file.write(f"Player: {player_name}, Difficulty: {difficulty}, Score: {score}, Attempts: {attempts}\n")

def number_guessing_game():
    print("Welcome to the Number Guessing Game with Hints, Scores, and Saving Feature!")

    # Get player's name
    player_name = input("Enter your name: ")

    # Select difficulty
    difficulty = input("Choose a difficulty (Easy, Medium, Hard): ").lower()

    if difficulty == 'easy':
        number_to_guess = random.randint(1, 10)
        max_attempts = None  # Unlimited attempts
        max_score = 50
        print("Difficulty: Easy (Range: 1 to 10, Unlimited attempts)")
    elif difficulty == 'medium':
        number_to_guess = random.randint(1, 50)
        max_attempts = 10
        max_score = 100
        print("Difficulty: Medium (Range: 1 to 50, Max 10 attempts)")
    elif difficulty == 'hard':
        number_to_guess = random.randint(1, 100)
        max_attempts = 5
        max_score = 150
        print("Difficulty: Hard (Range: 1 to 100, Max 5 attempts)")
    else:
        print("Invalid difficulty level. Starting with Easy by default.")
        number_to_guess = random.randint(1, 10)
        max_attempts = None  # Unlimited attempts
        max_score = 50

    # Initialize variables
    attempts = 0
    score = max_score  # Start with the maximum score

    while True:
        try:
            user_guess = int(input("Guess a number: "))
            attempts += 1

            if user_guess < number_to_guess:
                print("Too low! Try again.")
            elif user_guess > number_to_guess:
                print("Too high! Try again.")
            else:
                print(f"Congratulations! You've guessed the correct number in {attempts} attempts.")
                print(f"Your final score is {score} out of {max_score}.")
                
                # Save the score to a file
                save_score(player_name, difficulty, score, attempts)
                
                print("Your score has been saved!")
                break

            # Deduct points for each incorrect guess
            score -= 5

            # Provide a hint after every 3 wrong attempts
            if attempts % 3 == 0:
                provide_hint(number_to_guess)

            # If the game has a max attempts limit
            if max_attempts and attempts >= max_attempts:
                print(f"Sorry, you've reached the maximum number of attempts. The correct number was {number_to_guess}.")
                print(f"Your final score is {score} out of {max_score}.")
                
                # Save the score to a file
                save_score(player_name, difficulty, score, attempts)
                
                print("Your score has been saved!")
                break

        except ValueError:
            print("Please enter a valid number.")

if __name__ == "__main__":
    number_guessing_game()
