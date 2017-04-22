# Contributing to the SQL Server Kit
Please take a moment to review this document in order to make the contribution
process easy and effective for everyone involved.

Following these guidelines will help us get back to you more quickly, and will
show that you care about making MySQLTuner better just like we do. In return, we'll
do our best to respond to your issue or pull request as soon as possible with
the same respect.

_**Please Note:** These guidelines are adapted from [@necolas](https://github.com/necolas)'s
[issue-guidelines](https://github.com/necolas/issue-guidelines) and serve as
an excellent starting point for contributing to any open source project._


## Feature requests
<a name="features"></a>

Feature requests are welcome. But take a moment to find out whether your idea
fits with the scope and aims of the project. It's up to *you* to make a strong
case to convince the project's developers of the merits of this feature. Please
provide as much detail and context as possible.

Building something great means choosing features carefully especially because it
is much, much easier to add features than it is to take them away. Additions
 will be evaluated on a combination of scope (how well it fits into the
project), maintenance burden and general usefulness.

Creating something great often means saying no to seemingly good ideas. Don't
despair if your feature request isn't accepted, take action! Fork the
repository, build your idea and share it with others. We released this project under
the [LICENSE] for this purpose precisely. Open source works best when smart
and dedicated people riff off of each others' ideas to make even greater things.


## Pull requests
<a name="pull-requests"></a>

Good pull requests &mdash; patches, improvements, new features &mdash; are a fantastic help.
They should remain focused in scope and avoid containing unrelated commits.

**Please ask first** before embarking on any significant pull request (e.g.
implementing features, refactoring code, porting to a different language),
otherwise you risk spending a lot of time working on something that the
project's developers might not want to merge into the project. You can solicit
feedback and opinions in an open feature request thread or create a new one.

Please use the [git flow for pull requests](#git-flow) and follow SQL Server KIT
[code conventions](#code-conventions) before submitting your work.


## Git Flow for pull requests
<a name="git-flow"></a>

1. [Fork] the project, clone your fork, and configure the remotes:

   ```bash
   # Clone your fork of the repo into the current directory
   git clone git@github.com:<YOUR_USERNAME>/sqlserver-kit.git
   # Navigate to the newly cloned directory
   cd sqlserver-kit
   # Assign the original repo to a remote called "upstream"
   git remote add upstream https://github.com/ktaranov/sqlserver-kit
   ```

2. If you cloned a while ago, get the latest changes from upstream:

   ```bash
   git checkout master
   git pull upstream master
   ```

3. Create a new topic branch (off the main project development branch) to
   contain your feature, change, or fix:

   ```bash
   git checkout -b <topic-branch-name>
   ```

4. Commit your changes in logical chunks. Please adhere to these [git commit message guidelines]
   or your code is unlikely be merged into the main project. Use Git's [interactive rebase]
   feature to tidy up your commits before making them public.

5. Locally merge (or rebase) the upstream development branch into your topic branch:

   ```bash
   git pull [--rebase] upstream master
   ```

6. Push your topic branch up to your fork:

   ```bash
   git push origin <topic-branch-name>
   ```

7. [Open a Pull Request] with a clear title and description.

**IMPORTANT**: By submitting a patch, you agree to allow the project owner to license your work under the MIT [LICENSE]


## SQL Server KIT Code Conventions
<a name="code-conventions"></a>

Check [code convention]


[Fork]:https://help.github.com/articles/fork-a-repo/
[git commit message guidelines]:http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html
[interactive rebase]:https://help.github.com/articles/about-git-rebase/
[Open a Pull Request]:https://help.github.com/articles/about-pull-requests/
[LICENSE]:https://github.com/ktaranov/sqlserver-kit/blob/master/LICENSE.md
[code convention]:https://github.com/ktaranov/sqlserver-kit/blob/master/SQL%20Server%20Name%20Convention%20and%20T-SQL%20Programming%20Style.md
