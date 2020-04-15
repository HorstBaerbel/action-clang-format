FROM ubuntu:latest

LABEL "com.github.actions.name"="action-clang-format"
LABEL "com.github.actions.description"="Run clang-format on source directory"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="https://github.com/HorstBaerbel/action-clang-format"
LABEL homepage="https://github.com/HorstBaerbel/action-clang-format"
LABEL maintainer="Bim Overbohm <bim.overbohm@googlemail.com>"

RUN apt update
RUN apt -y install clang-format-9
RUN update-alternatives --install /usr/bin/clang-format clang-format /usr/bin/clang-format-9 100

RUN ls ~
RUN find / -name run-clang-format.py

COPY run-clang-format.py /run-clang-format.py
RUN chmod +x /run-clang-format.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]