function gc --description 'git commit -m without the need to quote commit message.\nIf no commit message is given then commit message will be chosen from (whatthecommit)'
	if [ -z "$argv" ]
        	if test (git new-files | wc -l | tr -d ' ') = 1
            		git commit -m "Add "(git staged-files)
        	else if test (git deleted-files | wc -l | tr -d ' ') = 1
            		git commit -m "Delete "(git deleted-files)
        	else if test (git staged-files | wc -l | tr -d ' ') = 1
            		git commit -m "Update "(git staged-files)
        	else if not git diff --cached --exit-code --quiet
            		echo (curl -s "http://whatthecommit.com/index.txt")
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
