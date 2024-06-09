# UI-Automate-Saucedemo

## Automation Project for Saucedemo.com using Robot Framework and Selenium

### Description

This repository contains a comprehensive automation suite designed to validate the functionalities of the [Saucedemo](https://www.saucedemo.com/) website. Utilizing the powerful combination of the Robot Framework and Selenium library, this project focuses on critical scenarios to ensure the robustness and reliability of the application under test.

### Behavior-Driven Development (BDD)

The project follows the Behavior-Driven Development (BDD) concept to enhance collaboration and clarity in test case design. BDD involves creating test cases in a natural language that non-technical stakeholders can understand, facilitating better communication and shared understanding of requirements among developers, testers, and business analysts.

In this project, BDD is implemented through the following practices:

- **Readable Test Cases:** Test cases are written in a human-readable format using the Robot Framework, making them easy to understand and maintain.
- **Collaboration:** Encourages collaboration between technical and non-technical team members to define and refine test scenarios.
- **Scenario-Based Testing:** Focuses on testing the application's behavior through well-defined scenarios that represent user interactions and business requirements.

### Key Scenarios:

1. **Login Automation:**
   - Tests the login functionality with various user credentials, simulating real-world scenarios. Utilizes the Selenium library for seamless interaction with web elements, ensuring a secure and reliable login process.
   - **Valid User Account:** Ensures that users with valid credentials can log in successfully.
   - **Locked User Account:** Verifies that locked users receive the appropriate error message and cannot log in.
   - **Invalid User Account:** Checks that users with invalid credentials receive a proper error message and are prevented from logging in.

2. **Checkout Process Automation:**
   - Automates the purchase and checkout process, executing tests to verify the seamless completion of transactions. Integrates with Selenium for precise interaction with website elements, thoroughly evaluating the checkout functionality.
   - **Validate Checkout Information:** Ensures that all checkout information is correctly displayed and validated.
   - **Calculate Item Price:** Verifies the accuracy of item prices, including the total price calculation during the checkout process.

3. **View Detail Card and Add/Remove Items:**
   - Tests the functionality to view detailed information for items and perform actions to add or remove items. Leverages Selenium's capabilities to ensure users can interact with detail cards seamlessly and perform necessary actions without errors.

4. **Validate Page Title on Navigation:**
   - Validates the title of each page during navigation to ensure consistency and accuracy. This enhances usability and reliability by maintaining accurate page titles throughout the user's browsing experience.