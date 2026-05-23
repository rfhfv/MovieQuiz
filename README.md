# MovieQuiz App

An interactive iOS quiz app that tests your knowledge of movies from the IMDb Top-250 list.  
The app presents 10 questions per round about movie ratings, provides instant visual feedback, and tracks detailed statistics to help you beat your own records.

[API IMDb](https://tv-api.com/api#Top250Movies-header)

[Figma mockup](https://www.figma.com/design/wjLUZUID3eizsbYd616EUD/YP-Quiz)

## Screenshots

<img width="1300" height="782" alt="Image" src="https://github.com/user-attachments/assets/e73ebc9d-332b-48ae-a1e0-32f51f12ca7e" />

## Features

- **Registration Screen:** Users must enter valid data before starting the quiz. The username is cached locally using `UserDefaults`.
- **Quiz Logic:** Each round consists of 10 questions. A typical question: "Is this movie's rating higher than 6?" (based on IMDb's 10-point scale).
- **True/False Answers:** Only one correct answer per question.
- **Instant Visual Feedback:** After answering, the photo frame border changes color (green for correct, red for incorrect) to provide immediate feedback.
- **Automatic Question Flow:** The next question appears automatically 1 second after an answer is selected.
- **Statistics Tracking:** After each round, an alert shows:
    - Current round result (e.g., 8/10 correct)
    - Total number of quizzes played
    - Record (best round result with date and time)
    - Average accuracy across all played quizzes
- **Play Again:** Users can start a new round directly from the final alert.
- **Error Handling:** If data loading fails, an alert with a retry button is shown to repeat the network request.

## Tech Stack

- **UIKit** for all interface elements
- **UserDefaults** for caching user data and quiz statistics
- **URLSession** for networking
- **REST API** integration (IMDb API)
- **MVP** architecture
- **Unit Tests** for business logic
- **Splash Screen** on app launch

## Architecture

The project follows the **MVP (Model-View-Presenter)** architecture pattern:

- **Model:** Data structures for questions, user profile, and quiz statistics.
- **View:** UIKit-based views and ViewControllers. Displays data and passes user actions to the Presenter.
- **Presenter:** Contains all business logic. Handles question flow, answer validation, statistics calculation, and data formatting. Isolated from UIKit, making it easy to test.

## Testing

The project includes **Unit Tests** that cover the Presenter's business logic:

- Question loading and validation
- Answer processing and score calculation
- Statistics update logic (best result, accuracy percentage)
- Quiz flow state management
- Network error handling

Tests use mocked services to isolate the Presenter and ensure reliable, repeatable results.

## Key Implementation Details

- **Splash Screen:** A launch screen is shown while the app is starting up.
- **Registration Validation:** Input is validated before allowing the user to proceed to the main quiz screen.
- **UserDefaults Caching:** The entered username is saved locally using `UserDefaults`, so it persists between app launches.
- **Question Flow:** After an answer is selected, a 1-second timer automatically triggers the next question. The UI is blocked during this short delay to prevent multiple answers.
- **Visual Feedback:** The photo frame border color changes instantly based on the answer's correctness, providing a clear user experience.
- **Statistics Calculation:** The app calculates and stores:
    - Total number of played quizzes
    - Best round result with timestamp
    - Average accuracy percentage across all rounds
- **Error Handling:** Network failures are caught, and a user-friendly alert with a retry option is displayed.

## Installation

- git clone https://github.com/rfhfv/MovieQuiz.git
- cd MovieQuiz
- open MovieQuiz.xcodeproj
