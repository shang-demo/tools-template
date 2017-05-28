.PHONY: all test clean static
d=template2
gulp:
	@ gulp
merge:
	git fetch template __template_branch__
	git merge remotes/template/__template_branch__
push:
	@ sh config/push.sh
deploy:
	@ sh config/push.sh deploy $(e)
copy:
	@ sh config/copy.sh $(d)
rsync:
	cp ./package.json ./production
	gsed -i 's/"start": ".*/"start": "PORT=1337 NODE_ENV=production pm2 start .\/index.js --name template:1337",/g' ./production/package.json
	rsync --exclude .tmp --exclude node_modules -cazvF -e "ssh -p 22" ./production/  feng@139.129.92.153:/home/feng/shang/template/$(templateVersion)