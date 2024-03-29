FROM horstbaerbel/ccpp-cmake-build-and-test:1.1

LABEL "com.github.actions.name"="action-clang-format"
LABEL "com.github.actions.description"="Run clang-format on source directory"
LABEL "com.github.actions.icon"="check-circle"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.1.0"
LABEL repository="https://github.com/HorstBaerbel/action-clang-format"
LABEL homepage="https://github.com/HorstBaerbel/action-clang-format"
LABEL maintainer="Bim Overbohm <bim.overbohm@googlemail.com>"

COPY run-clang-format.py /run-clang-format.py
RUN chmod +x /run-clang-format.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
