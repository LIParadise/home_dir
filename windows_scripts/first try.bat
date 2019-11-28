docker run -p 2222:22 -it -v debian:/win --user 1000 --name first_try debian1 /usr/bin/zsh
docker exec -it --user liparadise first_try bash -c "exec /usr/bin/zsh"