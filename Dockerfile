# Use https://github.com/medvid/docker-modustoolbox as a base image
ARG MTB_TAG=latest
FROM vmmedvid/modustoolbox:${MTB_TAG}

# Install CMake, Ninja and LLVM/Clang
RUN apt update -y \
 && apt install -y apt-transport-https ca-certificates curl gnupg software-properties-common xz-utils --no-install-recommends \
 && curl -fsSL https://apt.kitware.com/keys/kitware-archive-latest.asc | gpg --dearmor - | tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null \
 && curl -fsSL https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
 && apt-add-repository -y 'deb https://apt.kitware.com/ubuntu/ jammy main' \
 && apt-add-repository -y 'deb http://apt.llvm.org/jammy/ llvm-toolchain-jammy-14 main' \
 && apt update -y \
 && apt install -y cmake ninja-build clang-14 lld-14 --no-install-recommends \
 && apt autoremove -y --purge gnupg \
 && apt clean

# Install GCC 11.2.1
RUN curl -fsSL https://developer.arm.com/-/media/Files/downloads/gnu/11.2-2022.02/binrel/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz -o /tmp/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz \
 && tar -C /opt -xJf /tmp/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz \
 && rm /tmp/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi.tar.xz
ENV GCC_TOOLCHAIN_PATH="/opt/gcc-arm-11.2-2022.02-x86_64-arm-none-eabi"
