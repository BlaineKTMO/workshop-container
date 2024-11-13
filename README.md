# Intro To Robotics

## Windows Prep
### Install WSL
- Open command prompt as an administrator and run the following command.
    ```cmd
    wsl --install -d Ubuntu-22.04
    ```
- You may need to restart your computer.
- Copy the `.wslconfig ` to your `C:\Users\YourUser\` folder

### What is WSL?
- Wsl is the Windows Subsystem for Linux. It creates a virtual Linux environment nested inside of your Windows operating system.
- To open WSL, open the command prompt and type the following command:
    ```bash
    wsl -d <Image>
    ```

- You'll know if you're in WSL when you see the following:
    ```bash
    <Username>@<PC-Name>/some/path/here$ 
    ```

- To get a list of available images on your computer:
    ```bash
    wsl --list
    ```
    and you should get an output like this: 
    ```bash
    Windows Subsystem for Linux Distributions:
    Ubuntu-20.04 (Default)
    Ubuntu-22.04
    ```
    where each line is a seperate image.

- To exit WSL,  type
    ```bash
    exit
    ```

### Install Docker
- Inside your WSL instance:
    ```bash
    sudo apt install docker-compose
    ```
- Add your user to the docker group
    ```bash
    sudo usermod -aG docker <Your Username>
    ```
- Log out and log back in by typing
    ```bash
    exit
    ```
- This should place you back in command prompt, where you can relaunch wsl
    ```cmd
    wsl -d <Image Name>
    ```

## Mac Prep
### Install Docker Desktop
- Install docker [here](https://docs.docker.com/desktop/setup/install/mac-install/) and follow the steps

- You do not need to sign up for a docker account! You can hit skip when prompted

### Install Git
- If you don't already have git installed, in a terminal run. You will need [homebrew](https://brew.sh/):
    ```
    brew install git
    ```

## Using Docker
- Open your terminal / wsl instance.
- In the terminal, move to the home directory by typing:
    ```bash
    cd ~/
    ```
- Clone the github repository using:
    ```bash
    git clone https://github.com/BlaineKTMO/workshop-container.git
    ```
- Navigate into the GitHub repository:
    ```bash
    cd ~/workshop-container
    ```

- Build the docker container
    ```bash
    docker build -t ros-container .
    ```
  - If you get a permissions error, you did not properly set up your user permissions. You must add yourself to the docker group.
    ```bash
    sudo usermod -aG docker <Your User>
    ```
    Then restart your wsl instance

- Once it is built, run the container by doing
    ```bash
    sudo docker run --network host --privileged -v /dev/shm:/dev/shm -it ros-container /bin/bash 
    ```

- If everything worked properly, you should see the following:
    ```bash
    root@<Random>: /ros_ws#
    ```

## **You now have a ROS2 Environment!!**
