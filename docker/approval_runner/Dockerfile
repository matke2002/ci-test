# build with: 
# docker build --pull -t runner .
#
# run with:
# docker run --name r1 --rm -it runner



FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
RUN groupadd -r arun && useradd --no-log-init -r -g arun arun
RUN mkdir /actions-runner
WORKDIR /tmp
RUN curl -O -L https://github.com/actions/runner/releases/download/v2.169.0/actions-runner-linux-x64-2.169.0.tar.gz
RUN tar xzf actions-runner-linux-x64-2.169.0.tar.gz -C /actions-runner
RUN chown arun:arun /actions-runner
USER arun
WORKDIR /actions-runner
# RUN apk add --no-cache mysql-client
ENTRYPOINT ["bash"]

# ./config.sh --url https://github.com/matke2002/ci-test --token ADIPEOYKNZRMHITVFPT6YOS6TG2LC
# ./config.sh --url https://github.com/matke2002/ci-test --token ADIPEO7AF2BWTNZR242NQV26THHRC
# ./config.sh --url https://github.com/matke2002/ci-test --token ADIPEO5VVKVLZMWRTAPSJE26THKDK
# --name ivan3 --work ivan3
