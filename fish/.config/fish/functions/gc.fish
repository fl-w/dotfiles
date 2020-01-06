function gc --description 'git commit -m without the need to quote commit message.\nIf no commit message is given then commit message will be chosen from (whatthecommit)'
	if [ -z "$argv" ]
        	if test (git diff --name-only --diff-filter=A --cached | wc -l | tr -d ' ') = 1
            		git commit -m "Add "(git diff --name-only --diff-filter=A --cached)
        	else if test (git diff --name-only --diff-filter=D --cached | wc -l | tr -d ' ') = 1
            		git commit -m "Delete "(git diff --name-only --diff-filter=D --cached)
        	else if test (git diff --name-only --cached --diff-filter=RM | wc -l | tr -d ' ') = 1
            		git commit -m "Update "(git diff --name-only --cached --diff-filter=RM)
        	else if not git diff --cached --exit-code --quiet
            		git commit -m (curl -s "http://whatthecommit.com/index.txt")
		else
	    		echo "Nothing staged"
        	end
	else if [ "$argv" = - ]
        	echo 'git checkout -'
        	git checkout -
    	else
        	git commit -m (echo $argv)
    end
end
