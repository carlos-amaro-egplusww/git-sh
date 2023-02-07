
#! /bin/bash
echo "we are on directory $pwd"
git rev-parse --show-toplevel

git branch
echo "what do you want to do?  \n 1. Git status \n 2. Git add (you'll need to add the file route) \n 3. Git commit \n 4. Git reset hard (SHA/commit is required)\n 5. Git push \n 6. Git Checkout \n 7. Git Diff (differonce between commits) \n 8. Branch Delete \n 9. Git Merge Branches \n 0. Git diff HEAD ~ local git"
echo "============================================================================"
read -p "****YOU CHOOSE: " GIT
echo "============================================================================"
case "$GIT" in
  [1])
    #git status
    git branch
    git status
    ~/./.nodeSnips/git.sh
    exit
    ;;
  [2])
    #git add
    echo "add the route of the files you want to commit:"
    read -p "" ROUTE
    git add ${ROUTE}
    clear
    git diff HEAD .
    git status
    echo "--files ready to commit--)"
    ~/./.nodeSnips/git.sh
    exit
    ;;
  [3])
    #git commit
    echo "Add commit msj:   "
    read -p "" MENSAJECOMMIT
    git commit -m "${MENSAJECOMMIT}"
    clear
    echo "--commited--)"
    ~/./.nodeSnips/git.sh
    exit
    ;;
  [4])
    #git reset hard
    git log -n 4
    echo "please paste the SHA: "
    read -p "" SHA
    git reset --hard ${SHA}
    exit
    ;;
  [5])
    #git push
    git branch --v
    echo -e " Does this branch has an stream? \n 1. Yes \n 2. No I need a new branch to set up to origin"
    read -p "" STREAM
    if [ "${STREAM}" == "1" ]
    then
      git push
      echo "branch got pushed"
    else 
      git push -u origin $(git branch --show-current)
    fi
    ;;
  [6])
    #git checkout
    git branch
    echo "Are you changing to an existing branch?
    echo -e "1. Yes(paste brach name)  \n2. No, (create new branch)"
    read -p "" BRANCHEXIST 
    if [ "${BRANCHEXIST}" == "1" ]
    then
      clear
      git branch
      echo "Paste branch()"
      read -p "" BRANCH
      git checkout  $BRANCH
      exit
    else
      echo "Name your new branch: "
      read -p "" BRANCH
      git checkout -b $BRANCH
    exit
    fi
    ;;
  [7]) #git diff
    git log -n 4
    echo "add the first link:
    read -p "" LINK1
    echo "add the second link:
    read -p "" LINK2
    git diff ${LINK1} ${LINK2}
    exit
    ;;
  [8]) #delete branch
    echo "============================================================================"
    git branch --v
    echo "============================================================================"
    echo -e "Are you in the branch you want to delete/and pull again? \n 1) Yeah delete then update this branch  \n 2) No, I wish to delete another branch";
    read -p "" BRANCH
    echo "============================================================================"
    if [ "${BRANCH}" == "1" ]
    then 
      CURRENTBRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
      read -p "Add the name of the base branch for this new branch: \n we will checkout to that branch \nthen we will execute a git pull \nFinally we will create this branch once again \n" BRANCHMASTER
      git checkout ${BRANCHMASTER}
      clear
      git pull
      git branch -D ${CURRENTBRANCH}
      git checkout -b ${CURRENTBRANCH}
      exit
    else 
      echo "Which branches do you want to delete? \nseparate branches using comma (,) \n branch1, branch2, branch3"
      read -p "" BRANCHDELETE
      clear
      git branch -D ${BRANCHDELETE}
      echo "============================================================================"
      echo "branches deleted"
      echo "============================================================================"
      exit
    fi
    ;;
  [9]) #git merge
    echo "============================================================================"
    git branch --v
    echo "============================================================================"
    echo -e "Are you using the branch you want to merge? \n 1) yes  \n 2) No, I need to change to another branch for this merge ";
    read -p "" BRANCH
    echo "============================================================================"
    if [ "${BRANCH}" == "1" ]
    then 
      git branch
      read -p "please add the branch name to merge: " BRANCHFUSION
      clear
      git merge ${BRANCHFUSION}
      echo "============================================================================"
      echo "branches merged"
      echo "============================================================================"
      git  status
      ls -l
      exit
    else 
      CURRENTBRANCH=$(git branch | sed -n -e 's/^\* \(.*\)/\1/p')
      echo "which is the main local branch to merge? "
      read -p "" BRANCHMAIN
      clear
      git checkout ${BRANCHMAIN}
      echo "we checkout to main local branch: ${BRANCHMAIN}"
      git merge ${CURRENTBRANCH}
      echo "============================================================================"
      echo "Merged!"
      echo "============================================================================"
      #git checkout ${CURRENTBRANCH}
      echo "We can continue we are in ${BRANCHMAIN}"
      git status
      ls -l
      exit
    fi
    ;;
  [0])
    git diff HEAD .
    clear
    ~/./.nodeSnips/git.sh
    exit
    ;;
  *)
    echo "You choose: wrong, you need to choose a number between 0 and 9"
    ~/./.nodeSnips/git.sh
    exit
    ;;
esac
