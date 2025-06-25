# === This file is part of Calamares - <https://calamares.io> ===
#
#   SPDX-FileCopyrightText: 2020 Adriaan de Groot <groot@kde.org>
#   SPDX-License-Identifier: BSD-2-Clause
#
calamares_add_plugin(shellprocessfinal
    TYPE job
    EXPORT_MACRO PLUGINDLLEXPORT_PRO
    SOURCES
        ShellProcessFinalJob.cpp
    SHARED_LIB
)

calamares_add_test(shellprocessfinaltest SOURCES Tests.cpp LIBRARIES yamlcpp::yamlcpp)
