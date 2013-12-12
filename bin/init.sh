function sb_init {
  local RED="\033[0;31m"
  local NC="\033[0m"

  if [ ! $# == 1 ]; then
    echo -e "${RED}Please specify a project name.${NC}"
    echo -e "Usage: init project-name\n"
  else
    if ! type "ruby" > /dev/null; then
      echo -e "${RED}Please install Ruby:${NC}"
      echo "http://www.ruby-lang.org/en/downloads/"
    else
      if ! type "npm" > /dev/null; then
        echo -e "${RED}Please install Node:${NC}"
        echo "http://nodejs.org/download/"
      else
        if ! type "grunt" > /dev/null; then
          echo -e "${RED}Please install grunt-cli:${NC}"
          echo "npm install grunt-cli"
        else
          echo -e "${RED}Downloading project-init${NC} 🚀\n"
          curl -s -S -O -L http://github.com/sparkbox/project-init/archive/master.zip;
          echo -e "${RED}Download finished.${NC}\n"
          echo -e "${RED}Setting up project config files.${NC}\n"
          unzip -qq master.zip;
          rm master.zip;
          mv project-init-master $1
          sed -i.bak "s/Project-Name/$1/g" $1/package.json;
          rm $1/package.json.bak;
          sed -i.bak "s/Project-Name/$1/g" $1/.rvmrc;
          rm $1/.rvmrc.bak;
          cd $1
          npm install;
          bundle;
          echo -e "${RED}Your project is all ready to go. Enjoy${NC}\n"
        fi
      fi
    fi
  fi
}