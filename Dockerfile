# This is largely copied from https://github.com/HorstBaerbel/ccpp-cmake-build-and-test
# But, we just get clang-format-12 from ubuntu-rolling (ubuntu:latest currently 20.04 doesn't have it).
FROM ubuntu:rolling

WORKDIR /

# Timezone setup might be needed in order for packages to install properly.
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt -y dist-upgrade
RUN apt -y install clang-format-12
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-12 100

RUN apt -y autoclean
RUN apt -y clean
RUN rm -rf /var/lib/apt/lists/*

LABEL "com.github.actions.name"="action-clang-format"
LABEL "com.github.actions.description"="Run clang-format on source directory"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="https://github.com/HorstBaerbel/action-clang-format"
LABEL homepage="https://github.com/HorstBaerbel/action-clang-format"
LABEL maintainer="Bim Overbohm <bim.overbohm@googlemail.com>"

COPY run-clang-format.py /run-clang-format.py
RUN chmod +x /run-clang-format.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]