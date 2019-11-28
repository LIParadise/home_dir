REM prerequisite: debian image with openssh-server installed
docker run -itd -p 2222:22 -v F:\docker_vol:/win --name justAContainer my_debian_test:justAnImage 