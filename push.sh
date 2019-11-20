set -e

git add -A
git commit -m $1


git checkout dev
git pull origin dev
git merge dev-hqj
git push origin dev
git checkout dev-hqj
git merge dev
git push origin dev-hqj

set +e
