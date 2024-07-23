#this returns a 0 (good) or 1 (error) if there are errors so it can be used in 
#a pipeline like github actions

#https://github.com/hadolint/hadolint
#https://hub.docker.com/r/hadolint/hadolint

echo "Running Hadolint on the Dockerfile"

docker container run --rm -i hadolint/hadolint hadolint - < Dockerfile | tee lint_output.txt

# check for errors in the lint output, warnings are ok
# default root user
exists=$(grep -c "error" lint_output.txt)
if [[ $exists -gt 0 ]]; then
    echo "Error(s) found during Linting "
    exit 1
else
    echo "Linting passed with no severe findings"
    exit 0
fi