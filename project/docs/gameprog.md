# Biking Valhala
## Student names
- Christian Henriksen <chrhenr@stud.ntnu.no>
- Christian Dammen <chrdamm@stud.ntnu.no>
- Andreas Castro Messel <andrecme@stud.ntnu.no>
- Ida Celine Løvås <idaclo@stud.ntnu.no>
- Lucas Jan Kloos <lucasjk@stud.ntnu.no>
- Ife Oyetoyan <ifeoluao@stud.ntnu.no>

## Repository
[Github IMT3603-Game-Project](https://github.com/LolTape/IMT3603-Game-Project)

## Gameplay video
[Youtube link](https://youtube.com/insert-youtube-link)

## Group discussion on development process
Insert big yap session
**INSERT ROLE DISCUSSION**

### Strengths and weaknesses of Godot
#### pros:
- **Beginner friendly**
Godot is an engine that was relatively easy to learn, especially for those that had programmed in Python before. Its interface is simple and intuitive, making it easy to navigate and understand. We found that it was straightforward to get something up and running on the screen without having to spend too much time setting things up. This allowed us to focus more on developing the game itself rather than learning the engine.
- **Good amount of tutorials**
Godot has a large collection of tutorials and learning resources available online. There are many guides, videos and community-made examples covering everything from basic movement and player controls to more advanced game mechanics. This makes it easier to find help when encountering problems or learning unfamiliar features. The availability of these resources made learning the engine a much smaller challenge.
- **Light Weight**
Godot is relatively lightweight compared to larger game engines such as Unity and Unreal Engine. It does not require as many system resources to run, and the installation size is relatively small. This means it can run smoothly on less powerful computers and generally takes less time to launch and work with. Its lightweight nature also makes it convenient to download, install and start developing without needing extensive setup or powerful hardware.
-**Very «Gitable»**
Godot worked very well with Git and GitHub for us. It was easy to set up version control and keep track of changes throughout development. Godot's project structure consists mostly of files that can be easily tracked and managed using Git. This made it convenient for multiple people to work on the same project, share changes and collaborate without too much difficulty. It also made it easier to revert unwanted changes and keep backups of previous versions of the project.
- **Opensource**
One of Godot's biggest advantages is that it is completely open source. Its source code is publicly available, meaning that anyone can inspect, modify or contribute to the engine itself. This provides greater transparency and makes it possible to understand how the engine works behind the scenes. It also means that we are not dependent on a single company for updates, licensing or continued support, giving us more freedom and flexibility when working on our projects.
#### cons:
- **Multiple ways to do one thing**
We found that Godot often provides multiple ways to achieve the same result. Many tasks can be handled either through the built-in UI using nodes, signals and the Inspector, or directly through code using GDScript. While this flexibility can be useful, it sometimes made development confusing, especially when working as a team. Since we had not agreed on a consistent approach beforehand, different team members sometimes implemented similar functionality in different ways. This made it harder to understand how certain parts of the project worked, follow the flow of the code and maintain consistency across the project.

### How you controlled process and communication systems during development
Our main communication system was through the discord platform. We made a private server where we had different messaging channels dedicated to different themes. ![Picture of our discord server with the meeting messaging chat selected](discord_server.png). This worked very well as we were all accustomed to how discord worked and we could easily give everyone permissions to make channels as needed. We would also be notified as we had the application on when using our computers and some on phone.

For controlling processes we used Scrum boad for our visual project management tool and had planned sprints set to be 1 week. We used the gdd to figure out who wanted to work on what and getting the idea of what we wanted to do for our game. After that we made our first issues and assigned them accordingly, since then we have brought up what we managed to get done during each sprint in our meetings, and brought up new issues we want to prioritize and then assigned them depending on who wants to take them. During a sprint when an issue is designed, we have on them made more issues individually, self assigned them and finished them as we saw fit. ![Picture of our issue board used as a scrum board taken  the 06.11.2026](issue_board.png)

We had meetings every monday at 14:00 where we discussed our progress on the tasks we were assigned. Discord was used from the start of the semester till around the middle of the semester. After we switched partially over to teams where we only had out meetings due to a member not being able to use discord. The rest of the communication still happened over at discord and was relayed over to people who couldn't reach the platform through sms. This caused a lot of annoyance with teams and we noticed a lot of problems with doing it this way.

 Previously during our meetings when we shared progress we also shared our screens to show what we have accomplished. Discord let us do it in 30 fps+ and and downgrade to show clearer text if needed. Teams however was 1-3 fps which made it very hard to show the work that we had done such as animation and gameplay features live. We also noticed teams had worse noise supression which made or team more prone to mute, and only unmute to talk. This made it a more consious decision to talk, instead of letting the discussions flow more naturally. Teams was also slower to load and some team members used linux, which u couldn't install teams on which made the meetings usually starting more late than if on discord. Our choice to keep using discord for other communication came from our experience with teams chatting being nonintuitive, with each channel on teams having it's own file location making it messy to find files, that we found teams notifications more intrusive and that the majority still used discord more actively. It proved it more worth to relay the information being shared on discord, rather than moving platform completely as it was more effecient for us than dealing with the problems teams came with. Towards the end of the semester we all got access to discord again.

### Use of version control systems (ticket tracking, branching, version control)

#### Ticket tracking
We've used Github's own "Projects" to make an Issue Board. The Issue Board contains five sections: Backlog (issues that we want to complete in our game), Ready to worked on, In progress, In review, Done.

#### Branching
Our main is a stable version that we sometimes push development into. Development branch is where we have actively merged our work into when finished. Branching from development we've done two different ways. First way was making branches from issues and closed the issue-branch after merging into development / finishing the issue. The second way was creating a branch and name it after a theme, for example "enemy-wolf", and then whenever an issue has been completed through that branch, we've written "closes issue #x" in commit messages. For the merge to be accepted someone else has to review the pull request by viewing the new code and also running it on their own machine to ensure it works.

#### Version control
We've used semantic commits so that it's easy for us to understand what others have done. This has been helpful while reviewing pull requests.
