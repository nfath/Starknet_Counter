# Simple Counter Based on STARKNET Blockchain 

This repository will be used by the teachers of Basecamp 11 to progressively build a Starknet application from start to finish that will include smart contracts, testing and frontend.

## Setup

### 1. Clone the Repository

```sh
git clone https://github.com/nfath/starknet_counter
cd starknet_counter
```

### 2. Dev Environment

Docker 
VS-Code 
Dev Container Extension in VS-Code

### 3. Cairo Smart Contracts

To build and test the smart contracts, follow these steps:

```sh
scarb build
```
This command compiles the smart contracts and prepares them for deployment.

```sh
scarb test
```
This command runs the test suite to ensure the smart contracts are functioning as expected.

### 4. Web 

To set up and run the web application, follow these steps:

1. **Navigate to the Web Directory**:
    ```sh
    cd web
    ```

2. **Install Dependencies**:
    ```sh
    npm install
    ```
    This command installs all the necessary packages and dependencies required for the web application.

3. **Run the Development Server**:
    ```sh
    npm run dev
    ```
    This command starts the development server, allowing you to view and interact with the web application in your browser.
