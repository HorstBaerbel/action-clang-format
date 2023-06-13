# This is largely copied from https://github.com/HorstBaerbel/ccpp-cmake-build-and-test
# But, we just get a modern clang-format.
FROM ubuntu:rolling

WORKDIR /

# Timezone setup might be needed in order for packages to install properly.
ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt update
RUN apt -y dist-upgrade

# Download clang-format-16 since ubuntu repos does not have it right now
# TODO: Change it with `apt install clang-format-16` when ubuntu has it.
RUN apt -y install wget
RUN wget --no-check-certificate -O clang-format "https://drive.google.com/uc?export=download&id=1QCpf_BD_o_1vXyFQmis3DuorSfByRX4X"
RUN chmod +x clang-format
RUN mv clang-format /usr/bin/

# Dependencies for clang-format and python file.
RUN apt -y install libncurses5
RUN apt -y install python3

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
