FROM rust

RUN apt-get update && \
    # apt-utils is necessary for configuration debs
    # lsb-release, wget, software-properties-common is necessary for installing llvm
    apt-get install -y --no-install-recommends lsb-release wget software-properties-common tree apt-utils && \
    # Install llvm from the official repository
    bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" 12 && \
    # Install additional tools necessary for building
    apt-get update && apt-get install -y --no-install-recommends clang-tools-12 && \
    # Setup symlink for clang, lld and ar
    update-alternatives --install /usr/bin/clang clang /usr/bin/clang-12 100       && \
    update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-12 100 && \
    update-alternatives --install /usr/bin/lld lld /usr/bin/lld-12 100             && \
    update-alternatives --install /usr/bin/ld.lld ld.lld /usr/bin/ld.lld-12 100    && \
    update-alternatives --install /usr/bin/llvm-ar llvm-ar /usr/bin/llvm-ar-12 100 && \
    # Cleanup apt caches
    rm -rf /var/lib/apt/lists/*
